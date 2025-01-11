import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/screens/coupons/component/apply_coupon_component.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/extensions/date_extensions.dart';
import 'package:ifloriana/utils/extensions/int_extension.dart';
import 'package:ifloriana/utils/extensions/num_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_app_dialog.dart';
import '../../../components/dotted_line.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../components/price_widget.dart';
import '../../../components/slot_widget.dart';
import '../../../main.dart';
import '../../../paymentGateways/payment_repo.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../../../utils/model_keys.dart';
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_configuration_response.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../experts/employee_repository.dart';
import '../../experts/model/employee_detail_response.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';
import '../model/booking_request_model.dart';

VoidCallback? onQuickBookingDataUpdate;

class QuickBookingComponent extends StatefulWidget {
  final List<ServiceListData> serviceListData;
  final VoidCallback? callback;

  QuickBookingComponent({required this.serviceListData, this.callback});

  @override
  _QuickBookingComponentState createState() => _QuickBookingComponentState();
}

class _QuickBookingComponentState extends State<QuickBookingComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UniqueKey keyForSlotWidget = UniqueKey();

  Future<List<EmployeeData>>? futureEmployeeList;

  Future<BranchConfigurationResponse>? futureTimeSlotList;

  TextEditingController selectDateCont = TextEditingController();
  TextEditingController selectTimeCont = TextEditingController();

  FocusNode dateFocus = FocusNode();
  FocusNode timeFocus = FocusNode();

  num totalAmount = 0;

  final List<ServiceListData> selectedService = [];
  final List<int> selectedServiceIdList = [];
  List<EmployeeData> employeeList = [];

  bool isSelectedService = false;
  bool showEmployeeList = false;

  EmployeeData? selectedEmployee;

  double containerHeight = 300;

  BookingRequestModel taxRequest = BookingRequestModel();

  DateTime selectedHorizontalDate = DateTime.now();

  String startTime = DEFAULT_SLOT_INTERVAL_DURATION;
  String endTime = DEFAULT_SLOT_INTERVAL_DURATION;

  @override
  void initState() {
    super.initState();
    onQuickBookingDataUpdate = () {
      selectedService.clear();
      selectedServiceIdList.clear();
      widget.serviceListData.forEachIndexed((element, index) {
        element.isServiceChecked = false;
      });
      selectDateCont.text = '';
      selectTimeCont.text = '';
      dateFocus.unfocus();
      timeFocus.unfocus();
      totalAmount = 0;
      showEmployeeList = false;
      init();
      setState(() {});
    };
  }

  void init() async {
    futureEmployeeList = getEmployeeList(branchId: appStore.branchId, serviceIds: selectedServiceIdList.join(', '), list: employeeList);
  }

  Future<BranchConfigurationResponse>? fetchBranchConfigurationApi() {
    futureTimeSlotList = getBranchConfiguration(appStore.branchId);
    return futureTimeSlotList;
  }

  /// region Service List Widget
  Widget serviceListWidget({required ServiceListData services}) {
    return CheckboxListTile(
      value: services.isServiceChecked,
      title: Text('${services.name.validate()}', style: boldTextStyle(color: appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor, size: 14)),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: PriceWidget(price: services.defaultPrice.validate(), color: context.primaryColor),
      checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
      side: BorderSide(color: textSecondaryColorGlobal),
      dense: true,
      activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
      onChanged: (value) {
        // Ensure only one service can be selected
        if (value == true) {
          // Deselect other services
          //TODO: Check This
          for (var service in widget.serviceListData) {
            if (service.id != services.id) {
              service.isServiceChecked = false;
              selectedService.remove(service);
              selectedServiceIdList.remove(service.id.validate());
            }
          }
          // Select the current service
          services.isServiceChecked = true;
          selectedService.add(services);
          selectedServiceIdList.add(services.id.validate());
        } else {
          // Deselect the current service
          services.isServiceChecked = false;
          selectedService.remove(services);
          selectedServiceIdList.remove(services.id.validate());
        }

        taxRequest.selectedServiceList = selectedService;
        taxRequest.taxPercentage = bookingRequestStore.taxPercentage;
        bookingRequestStore.setPackagePurchase(false);
        calculateTotalAmount();

        setState(() {});
      },
    );
  }

  /// Selected Service Widget
  Widget selectedServiceWidget({ServiceListData? selectedServiceText}) {
    return Container(
      width: context.width() / 3 - 30,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(),
        backgroundColor: appStore.isDarkMode ? indicatorColor.withOpacity(0.5) : indicatorColor.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Marquee(
            child: Text(
              '${selectedServiceText!.name}',
              style: secondaryTextStyle(color: appStore.isDarkMode ? textPrimaryColorGlobal : textSecondaryColorGlobal),
            ),
          ).expand(),
          4.width,
          Container(
            height: 16,
            width: 16,
            decoration: boxDecorationWithRoundedCorners(borderRadius: radius(5), backgroundColor: scaffoldSecondaryDark),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                try {
                  final service = widget.serviceListData.firstWhere((element) => element.name == selectedServiceText.name);
                  service.isServiceChecked = false;
                  selectedService.remove(selectedServiceText);
                  selectedServiceIdList.remove(selectedServiceText.id.validate());
                  calculateTotalAmount();
                  setState(() {});
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.close, color: cardColor, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveBooking() async {
    hideKeyboard(context);

    if (branchConfigurationCached != null) {
      BookingRequestModel req = BookingRequestModel();
      req.selectedServiceList = widget.serviceListData.where((element) => element.isServiceChecked.validate()).toList();

      String dateString = selectDateCont.text + " " + selectTimeCont.text;
      DateFormat inputFormat = DateFormat("dd/MM/yyyy h:mm");
      DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

      DateTime dateTime = inputFormat.parse(dateString);

      String formattedString = outputFormat.format(dateTime);

      DateTime initialDateTime = DateTime.parse(formattedString);

      req.selectedServiceList.validate().forEachIndexed((element, index) {
        if (index == 0) {
          element.startDateTime = formatDate(initialDateTime.toString(), format: DateFormatConst.NEW_FORMAT);
          element.previousTime = initialDateTime;
        } else {
          ServiceListData previousData = req.selectedServiceList.validate()[index - 1];
          element.startDateTime = formatDate(previousData.previousTime!.add(previousData.durationMin.minutes).toString(), format: DateFormatConst.NEW_FORMAT);
          element.previousTime = previousData.previousTime!.add(previousData.durationMin.minutes);
        }
      });

      String selectDateTime = formatDate(initialDateTime.toString(), format: DateFormatConst.NEW_FORMAT);
      req.taxPercentage = branchConfigurationCached!.tax;

      if (bookingRequestStore.isCouponApplied) {
        req.finalDiscountCouponAmount = taxRequest.totalCouponDiscount;
        req.discountCouponCode = bookingRequestStore.discountCouponCode;
      }

      bookingRequestStore.employeeId = selectedEmployee!.id.validate();

      log('Request: ${req.toJson(dateTime: selectDateTime)}');

      appStore.setLoading(true);

      doIfLoggedIn(context, () async {
        await verifySlot(selectedEmployee!.id.validate(), initialDateTime.toString()).then((value) async {
          saveBookingAPI(req.toJson(dateTime: selectDateTime)).then((value) async {
            appStore.setLoading(true);
            bookingRequestStore.setCouponApplied(false);

            await savePay(
              bookingId: value[CommonKey.bookingId],
              externalTransactionId: '',
              transactionType: PaymentMethods.PAYMENT_METHOD_CASH,
              discountPercentage: 0,
              discountAmount: 0,
              taxData: req.taxPercentage.validate(),
              paymentStatus: '0',
            );
            appStore.setLoading(false);

            showDialog(
              context: context,
              useSafeArea: false,
              builder: (BuildContext context) => CommonAppDialog(
                title: locale.bookingSuccessful,
                subTitle: locale.yourBookingForHairBookingMessage,
                buttonText: locale.goToBookings,
                onTap: () {
                  finish(context);
                  DashboardScreen(pageIndex: 1).launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                },
              ),
            ).then(
              (value) {
                showEmployeeList = false;
                selectedService.clear();
                taxRequest.selectedServiceList = selectedService;
                selectedServiceIdList.clear();
                widget.callback?.call();
              },
            );
          }).catchError((e) {
            appStore.setLoading(false);
            toast(e.toString(), print: true);
          });
        }).catchError((e) {
          appStore.setLoading(false);
          toast(e.toString());
        });
      });
    } else {
      appStore.setLoading(true);
      getBranchConfiguration(appStore.branchId).then((value) {
        saveBooking();
      }).catchError((e) {
        toast(e.toString());
      });
    }
  }

  void calculateTotalAmount() {
    totalAmount = widget.serviceListData.where((element) => element.isServiceChecked).sumByDouble((p0) => p0.defaultPrice.validate());
  }

  Widget totalAmountWidget() {
    if (totalAmount != 0 && !bookingRequestStore.isCouponApplied)
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${locale.total} : ', style: boldTextStyle(size: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PriceWidget(price: taxRequest.calculateTotalAmount, color: textPrimaryColorGlobal, size: 16),
                8.width,
                taxRequest.totalTax != 0
                    ? Marquee(
                        child: Text(
                          '(${taxRequest.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                          style: secondaryTextStyle(),
                        ),
                      )
                    : Offstage(),
              ],
            ),
          ],
        ).paddingSymmetric(vertical: 16),
      );
    else if (totalAmount != 0 && bookingRequestStore.isCouponApplied)
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.price, style: secondaryTextStyle(size: 14)),
                PriceWidget(price: taxRequest.totalAmount, color: textPrimaryColorGlobal, size: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.couponDiscount, style: secondaryTextStyle(size: 14)),
                Row(
                  children: [
                    PriceWidget(price: taxRequest.totalCouponDiscount.validate(), isDiscountedPrice: true, color: greenColor, size: 16),
                    if (!bookingRequestStore.isFixedDiscountCoupon)
                      Marquee(
                        child: Text(
                          '(${bookingRequestStore.couponDiscountPercentage} %)',
                          style: secondaryTextStyle(),
                        ),
                      ).paddingLeft(8),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.subtotal, style: secondaryTextStyle(size: 14)),
                PriceWidget(price: taxRequest.totalAmountWithCouponDiscount, color: textPrimaryColorGlobal, size: 16),
              ],
            ),
            Divider(height: 32),
            taxRequest.totalAmount >= taxRequest.totalCouponDiscount
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${locale.total} : ', style: boldTextStyle(size: 16)),
                      8.width,
                      PriceWidget(price: taxRequest.calculateTotalAmountWithCouponAndTaxAndTip, color: textPrimaryColorGlobal, size: 16),
                      8.width,
                      taxRequest.totalTax != 0
                          ? Marquee(
                              child: Text(
                                '(${taxRequest.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                                style: secondaryTextStyle(size: 10),
                              ),
                            )
                          : Offstage(),
                    ],
                  )
                : Text(
                    locale.theCouponAmountExceeds,
                    style: primaryTextStyle(color: redColor),
                  )
          ],
        ),
      );

    return Offstage();
  }

  /// For showing Time Slots in BottomSheet
  Future<String?> _showTimeSlotBottomSheet(BuildContext context) async {
    String? newTime = await showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: 16, topRight: 16)),
      builder: (context) {
        return SnapHelperWidget(
          future: fetchBranchConfigurationApi(),
          loadingWidget: LoaderWidget(),
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.reload,
              imageWidget: ErrorStateWidget(),
              onRetry: () {
                appStore.setLoading(true);
                fetchBranchConfigurationApi();
                setState(() {});
              },
            );
          },
          onSuccess: (snap) {
            if (snap.data == null) {
              return NoDataWidget(
                title: locale.noTimeSlots,
                retryText: locale.reload,
                onRetry: () {
                  appStore.setLoading(true);

                  fetchBranchConfigurationApi();
                  setState(() {});
                },
              );
            }

            if (snap.data!.slot.validate().any((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName)) {
              startTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).startTime.validate();
              endTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).endTime.validate();
            }

            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  SettingItemWidget(
                    title: locale.availableSlots,
                    padding: EdgeInsets.zero,
                    trailing: CloseButton(onPressed: () {
                      finish(context);
                    }),
                  ),
                  4.height,
                  AnimatedScrollView(
                    listAnimationType: ListAnimationType.None,
                    onSwipeRefresh: () async {
                      fetchBranchConfigurationApi();
                      setState(() {});

                      return await 2.seconds.delay;
                    },
                    children: [
                      SlotWidget(
                        key: keyForSlotWidget,
                        selectedHorizontalDate: selectedHorizontalDate,
                        startTime: startTime,
                        endTime: endTime,
                        isFromQuickBooking: true,
                        slotDuration: snap.data!.slotDuration.validate(value: DEFAULT_SLOT_INTERVAL_DURATION),
                      ),
                    ],
                  ).expand(),
                ],
              ),
            );
          },
        );
      },
    );

    if (newTime != null) {
      return newTime;
    } else {
      return null;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    bookingRequestStore.setCouponApplied(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            Text(locale.quickBookAppointment, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
            16.height,
            Row(
              children: [
                AppTextField(
                  controller: selectDateCont,
                  focus: dateFocus,
                  textFieldType: TextFieldType.NAME,
                  isValidationRequired: false,
                  readOnly: true,
                  errorThisFieldRequired: locale.thisFieldIsRequired,
                  onTap: () async {
                    DateTime? date = await datePicker(context);

                    if (date != null) {
                      selectDateCont.text = date.setFormattedDate(DateFormatConst.BOOK_DATE_FORMAT).toString();
                      selectedHorizontalDate = date;

                      if (branchConfigurationCached!.slot.validate().any((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName)) {
                        startTime = branchConfigurationCached!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).startTime.validate();
                        endTime = branchConfigurationCached!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).endTime.validate();
                      }

                      keyForSlotWidget = UniqueKey();

                      /// Show BottomSheet only when date is not empty
                      if (selectDateCont.text.isNotEmpty) {
                        String? time = await _showTimeSlotBottomSheet(context);

                        if (time != null) {
                          selectTimeCont.text = formatOnlyTime(context, startTime: time);
                          timeFocus.nextFocus();
                        }
                      }

                      setState(() {});
                    }
                  },
                  decoration: inputDecoration(
                    context,
                    label: locale.date,
                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: context.iconColor, size: 20).paddingAll(14),
                  ),
                ).expand(),
                16.width,
                AppTextField(
                  controller: selectTimeCont,
                  focus: timeFocus,
                  textFieldType: TextFieldType.NAME,
                  isValidationRequired: false,
                  readOnly: true,
                  onTap: () async {
                    if (selectDateCont.text.isNotEmpty) {
                      String? time = await _showTimeSlotBottomSheet(context);

                      if (time != null) {
                        selectTimeCont.text = formatOnlyTime(context, startTime: time);
                        log("selected time : =>?${selectTimeCont.text}");
                        setState(() {});
                      }
                    } else {
                      toast(locale.pleaseSelectTheDateFirst);
                    }
                  },
                  decoration: inputDecoration(
                    context,
                    label: locale.time,
                    suffixIcon: Icon(Icons.keyboard_arrow_down, color: context.iconColor, size: 20).paddingAll(14),
                  ),
                ).expand(),
              ],
            ),
            16.height,
            AnimatedCrossFade(
              firstChild: AnimatedContainer(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
                duration: 300.milliseconds,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    textTheme: context.theme.textTheme,
                  ),
                  child: ExpansionTile(
                    title: Text(locale.service, style: secondaryTextStyle()),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    iconColor: context.iconColor,
                    collapsedIconColor: context.iconColor,
                    childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    children: [
                      SizedBox(
                        height: containerHeight,
                        child: SizeListener(
                          onSizeChange: (p0) {
                            containerHeight = p0.height;
                          },
                          child: ListView.separated(
                            itemCount: widget.serviceListData.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (_, i) {
                              return DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor);
                            },
                            itemBuilder: (context, index) {
                              return serviceListWidget(services: widget.serviceListData[index]);
                            },
                          ),
                        ),
                      ),
                      if (isSelectedService) 12.height,
                      if (isSelectedService)
                        AnimatedWrap(
                          spacing: 12,
                          runSpacing: 12,
                          itemCount: selectedService.length,
                          itemBuilder: (_, index) {
                            return selectedServiceWidget(selectedServiceText: selectedService[index]);
                          },
                        ).paddingBottom(16),
                    ],
                  ),
                ),
              ),
              crossFadeState: showEmployeeList ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              secondCurve: Curves.linearToEaseOut,
              duration: 200.milliseconds,
              secondChild: AnimatedContainer(
                duration: 300.milliseconds,
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    primaryColor: context.primaryColor,
                    fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    textTheme: context.theme.textTheme,
                  ),
                  child: SnapHelperWidget<List<EmployeeData>>(
                    future: futureEmployeeList,
                    loadingWidget: LoaderWidget(),
                    useConnectionStateForLoader: true,
                    onSuccess: (employeeList) {
                      if (employeeList.isEmpty) return Text(locale.noStaffFound, style: primaryTextStyle()).center().paddingSymmetric(vertical: 50);

                      return ExpansionTile(
                        title: Text(locale.specialist, style: secondaryTextStyle()),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        iconColor: context.iconColor,
                        collapsedIconColor: context.iconColor,
                        initiallyExpanded: true,
                        childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        children: [
                          SizedBox(
                            height: employeeList.length >= 6 ? 300 : null,
                            child: ListView.separated(
                              itemCount: employeeList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, i) {
                                return DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor);
                              },
                              itemBuilder: (context, index) {
                                EmployeeData employeeData = employeeList[index];

                                return RadioListTile<EmployeeData>(
                                  value: employeeList[index],
                                  groupValue: selectedEmployee,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
                                  title: Row(
                                    children: [
                                      CachedImageWidget(url: employeeData.profileImage.validate(), height: 24, width: 24, circle: true),
                                      16.width,
                                      Text(employeeData.fullName.validate(), style: boldTextStyle(color: appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor, size: 14)),
                                    ],
                                  ),
                                  onChanged: (value) {
                                    selectedEmployee = value!;
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ).paddingBottom(16),
                        ],
                      );
                    },
                    errorBuilder: (error) {
                      return NoDataWidget(
                        title: error,
                        imageWidget: ErrorStateWidget(),
                        retryText: locale.reload,
                        onRetry: () {
                          appStore.setLoading(true);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            16.height,

            /// Apply coupon component

            ApplyCouponComponent(taxRequest: taxRequest, callback: () => setState(() {})),

            /// total Amount Widget

            Observer(
                warnWhenNoObservables: false,
                builder: (context) {
                  return totalAmountWidget().paddingTop(16).visible(selectedServiceIdList.isNotEmpty);
                }),

            16.height,
            Row(
              children: [
                AppButton(
                  width: context.width(),
                  child: Text(locale.back, style: boldTextStyle(color: Colors.black)),
                  color: context.cardColor,
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  onTap: () {
                    showEmployeeList = false;
                    selectedEmployee = null;
                    setState(() {});
                  },
                ).flexible(flex: 3).visible(showEmployeeList),
                AppButton(
                  width: context.width(),
                  child: Text(locale.bookNow, style: boldTextStyle(color: Colors.white)),
                  color: secondaryColor,
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  margin: EdgeInsets.only(left: showEmployeeList ? 16 : 0),
                  onTap: () {
                    if (selectDateCont.text.isEmpty) {
                      return toast(locale.dateIsRequired);
                    } else if (selectTimeCont.text.isEmpty) {
                      return toast(locale.timeIsRequired);
                    } else if (selectedServiceIdList.isEmpty) {
                      toast(locale.pleaseSelectService);
                    }

                    if (formKey.currentState!.validate() && selectedServiceIdList.isNotEmpty) {
                      formKey.currentState!.save();

                      if (showEmployeeList) {
                        doIfLoggedIn(context, () {
                          if (selectedEmployee == null) {
                            return toast(locale.selectEmployeeFirst);
                          }
                          showDialog(
                            context: context,
                            useSafeArea: false,
                            builder: (BuildContext context) => CommonAppDialog(
                              icon: ic_confirm_check,
                              isQuickBooking: true,
                              title: locale.confirmBooking,
                              subTitle: locale.doYouWantToConfirmBooking,
                              buttonText: locale.confirm,
                              onTap: () async {
                                finish(context);
                                saveBooking();
                              },
                            ),
                          );
                        });
                      } else {
                        showEmployeeList = true;
                        init();
                        setState(() {});
                      }
                    }
                  },
                ).flexible(flex: showEmployeeList ? 7 : 1).visible(taxRequest.totalAmount >= taxRequest.totalCouponDiscount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
