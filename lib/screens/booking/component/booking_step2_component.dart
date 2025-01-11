import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/custom_stepper.dart';
import 'package:ifloriana/components/slot_widget.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/extensions/date_extensions.dart';
import 'package:ifloriana/utils/extensions/int_extension.dart';
import 'package:ifloriana/utils/horizontalCalender/date_item.dart';
import 'package:ifloriana/utils/horizontalCalender/date_picker_controller.dart';
import 'package:ifloriana/utils/horizontalCalender/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_bottom_price_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../utils/app_common.dart';
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_configuration_response.dart';
import '../../dashboard/component/booking_list_component.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';
import '../shimmer/booking_step2_shimmer.dart';
import '../view/booking_detail_screen.dart';

class BookingStep2Component extends StatefulWidget {
  final bool isFromBookingInfoDetail;
  final bool isReschedule;
  final int? bookingId;
  final int? employeeId;
  final String? selectedDate;
  final String? selectedTime;
  final List<ServiceListData>? serviceList;


  BookingStep2Component({this.isFromBookingInfoDetail = false, this.bookingId, this.serviceList, this.employeeId, this.isReschedule = false,this.selectedDate,this.selectedTime});

  @override
  _BookingStep2ComponentState createState() => _BookingStep2ComponentState();
}

class _BookingStep2ComponentState extends State<BookingStep2Component> {
  DatePickerController _datePickerController = DatePickerController();

  UniqueKey keyForSlotWidget = UniqueKey();

  Future<BranchConfigurationResponse>? future;

  DateTime selectedHorizontalDate = DateTime.now();

  List<String> monthList = List.generate(12, (index) => (index + 1).toMonthName());
  int currentMonthNumber = DateTime.now().month;
  int selectedMonthIndex = DateTime.now().month - 1;

  String startTime = DEFAULT_SLOT_INTERVAL_DURATION;
  String endTime = DEFAULT_SLOT_INTERVAL_DURATION;

  @override
  void initState() {
    super.initState();
    init();

    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    selectedHorizontalDate = widget.selectedDate != null &&
        inputFormat.parse(widget.selectedDate!).isAfter(DateTime.now())
        ? inputFormat.parse(widget.selectedDate!)
        : DateTime.now();
    bookingRequestStore.setDateInRequest(selectedHorizontalDate.setFormattedDate(DateFormatConst.DATE_FORMAT_5).toString());
    bookingRequestStore.setCouponApplied(false);
  }

  void init() async {
    future = getBranchConfiguration(appStore.branchId);
  }

  void setCustomDate(int month) {
    selectedHorizontalDate = DateTime(selectedHorizontalDate.year, month, 1);
    _datePickerController.selectedDate = selectedHorizontalDate;
    _datePickerController.scrollTo(selectedHorizontalDate);

    _datePickerController.scrollToSelectedItem();
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: widget.isFromBookingInfoDetail ? true : false,
      appBarWidget: commonAppBarWidget(
        context,
        title: '${locale.date} & ${locale.time}',
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            children: [
              SnapHelperWidget(
                future: future,
                loadingWidget: BookingStep2Shimmer(isFromBookingInfoDetail: widget.isFromBookingInfoDetail),
                errorBuilder: (error) {
                  return NoDataWidget(
                    title: error,
                    retryText: locale.reload,
                    imageWidget: ErrorStateWidget(),
                    onRetry: () {
                      appStore.setLoading(true);

                      init();
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

                        init();
                        setState(() {});
                      },
                    );
                  }

                  if (snap.data!.slot.validate().any((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName)) {
                    startTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).startTime.validate();
                    endTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).endTime.validate();
                  }

                  return AnimatedScrollView(
                    padding: EdgeInsets.only(left: 20, right: 20, top: widget.isFromBookingInfoDetail ? 10 : 60, bottom: widget.isFromBookingInfoDetail ? 60 : 80),
                    onSwipeRefresh: () async {
                      init();
                      setState(() {});

                      return await 2.seconds.delay;
                    },
                    children: [
                      ViewAllLabel(label: locale.date, isShowAll: false),
                      8.height,
                      Container(
                        decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingItemWidget(
                              title: '${monthList[selectedMonthIndex]} ${selectedHorizontalDate.year}',
                              titleTextStyle: boldTextStyle(size: 14, color: textSecondaryColorGlobal),
                              padding: EdgeInsets.zero,
                              trailing: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (selectedMonthIndex < currentMonthNumber) {
                                        //
                                      } else {
                                        selectedMonthIndex--;
                                        setCustomDate(currentMonthNumber - 1);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: ICON_SIZE,
                                      color: selectedMonthIndex < currentMonthNumber ? grey : context.iconColor,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (selectedMonthIndex == 11) {
                                          //
                                        } else {
                                          selectedMonthIndex++;
                                          setCustomDate(currentMonthNumber + 1);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: ICON_SIZE,
                                        color: selectedMonthIndex == 11 ? grey : context.iconColor,
                                      )),
                                ],
                              ),
                            ).paddingOnly(left: 16),
                            Divider(height: 0, color: context.dividerColor),
                            HorizontalDatePickerWidget(
                              datePickerController: _datePickerController,
                              height: 70,
                              startDate: DateTime.now(),
                              endDate: bookingRequestStore.isPackagePurchase ? DateTime.parse(bookingRequestStore.selectedPackageList.first.endDate.validate()) : DateTime(DateTime.now().year, DateTime.now().month + 2),
                              selectedDate: selectedHorizontalDate,
                              widgetWidth: context.width(),
                              selectedColor: indicatorColor,
                              selectedTextColor: Colors.black,
                              dateItemComponentList: [DateItem.Month, DateItem.WeekDay, DateItem.Day],
                              dayFontSize: 14,
                              weekDayFontSize: 14,
                              onValueSelected: (date) {
                                _datePickerController.scrollTo(selectedHorizontalDate);
                                selectedHorizontalDate = date;
                                log(selectedHorizontalDate);

                                if (snap.data!.slot.validate().any((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName)) {
                                  startTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).startTime.validate();
                                  endTime = snap.data!.slot.validate().firstWhere((element) => element.day == selectedHorizontalDate.weekday.getWeekDayName).endTime.validate();
                                }

                                keyForSlotWidget = UniqueKey();

                                setState(() {});
                              },
                            ).paddingSymmetric(vertical: 16),],


                  ),
                      ),
                      16.height,
                      ViewAllLabel(label: locale.availableSlots, isShowAll: false),
                      8.height,
                      SlotWidget(
                        selectedTime:widget.selectedTime,
                        key: keyForSlotWidget,
                        selectedHorizontalDate: selectedHorizontalDate,
                        startTime: startTime,
                        endTime: endTime,
                        slotDuration: snap.data!.slotDuration.validate(value: DEFAULT_SLOT_INTERVAL_DURATION),
                      ),
                    ],
                  );
                },
              ),
              Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (_) => CommonBottomPriceWidget(
                title: bookingRequestStore.selectedServiceList.map((e) => widget.isReschedule ? e.serviceName.validate() : e.name.validate()).toList().join(', '),
                price: bookingRequestStore.totalAmount,
                buttonText: locale.next,
                onTap: () async {
                  if (bookingRequestStore.time.isNotEmpty) {
                    bookingRequestStore.setDateInRequest(selectedHorizontalDate.setFormattedDate(DateFormatConst.DATE_FORMAT_5).toString());

                    /// Slot Verify API Call
                    doIfLoggedIn(context, () async {
                      appStore.setLoading(true);

                      await verifySlot(bookingRequestStore.employeeId, '${bookingRequestStore.date} ${bookingRequestStore.time}:00').then((value) {
                        log(bookingRequestStore.toJson());
                        customStepperController.nextPage(duration: 200.milliseconds, curve: Curves.easeOut);
                      }).catchError((e) {
                        toast(e.toString());
                      });
                      appStore.setLoading(false);
                    });
                  } else {
                    toast(locale.pleaseSelectTimeSlotFirst);
                  }
                },
              ),
            ),
          ).visible(!widget.isFromBookingInfoDetail),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondaryColor,
        onPressed: () {
          showConfirmDialogCustom(
            context,
            title: locale.bookingTimeSlotChangeMessage,
            positiveText: locale.yes,
            negativeText: locale.no,
            onAccept: (_) {
              List<ServiceListData> selectedService = [];

              bookingRequestStore.setEmployeeIdInRequest(widget.employeeId.validate());
              bookingRequestStore.setDateInRequest(selectedHorizontalDate.setFormattedDate(DateFormatConst.DATE_FORMAT_5).toString());

              widget.serviceList.validate().forEachIndexed((element, index) {
                selectedService.add(widget.serviceList.validate()[index]);
              });

              bookingRequestStore.setSelectedServiceListInRequest(selectedService);

              String tempDate = bookingRequestStore.date.validate();
              String tempTime = bookingRequestStore.time.validate();

              String dateString = tempDate + " " + tempTime;

              DateTime initialDateTime = DateTime.parse(dateString);

              String updatedDateTime = formatDate(initialDateTime.toString(), format: DateFormatConst.NEW_FORMAT);

              bookingRequestStore.selectedServiceList.validate().forEachIndexed((element, index) {
                if (index == 0) {
                  element.startDateTime = formatDate(initialDateTime.toString(), format: DateFormatConst.NEW_FORMAT);
                  element.previousTime = initialDateTime;
                } else {
                  ServiceListData previousData = bookingRequestStore.selectedServiceList.validate()[index - 1];
                  element.startDateTime = formatDate(previousData.previousTime!.add(previousData.durationMin.minutes).toString(), format: DateFormatConst.NEW_FORMAT);
                  element.previousTime = previousData.previousTime!.add(previousData.durationMin.minutes);
                }
              });

              appStore.setLoading(true);

              bookingUpdate(bookingRequestStore.toJson(dateTime: updatedDateTime, bookingId: widget.bookingId, bookingStatus: BookingStatusConst.PENDING, isUpdate: true)).then((value) {
                appStore.setLoading(false);

                onBookingDetailUpdate.call();
                onBookingListUpdate.call('');
                finish(context);
                toast(locale.bookingSuccessfullyUpdateMessage);
              }).catchError((e) {
                appStore.setLoading(false);
                toast(e.toString());
              });
            },
            primaryColor: context.primaryColor,
          );
        },
        label: Text(locale.update, style: boldTextStyle(color: Colors.white)),
      ).visible(widget.isFromBookingInfoDetail),
    );
  }
}

