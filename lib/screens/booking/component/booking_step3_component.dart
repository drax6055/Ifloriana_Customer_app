import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_common_dialog.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/common_bottom_price_widget.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/paymentGateways/payment_repo.dart';
import 'package:ifloriana/paymentGateways/services/airtel_money/airtel_money_service.dart';
import 'package:ifloriana/paymentGateways/services/cinet_pay_services_new.dart';
import 'package:ifloriana/paymentGateways/services/midtrans_service.dart';
import 'package:ifloriana/paymentGateways/services/paypal_service.dart';
import 'package:ifloriana/paymentGateways/services/phone_pe/phone_pe_service.dart';
import 'package:ifloriana/paymentGateways/services/sadad_services_new.dart';
import 'package:ifloriana/paymentGateways/services/stripe_service.dart';
import 'package:ifloriana/screens/booking/component/confirm_booking_dialog.dart';
import 'package:ifloriana/screens/booking/component/your_package_component.dart';
import 'package:ifloriana/screens/coupons/component/apply_coupon_component.dart';
import 'package:ifloriana/utils/extensions/num_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_app_dialog.dart';
import '../../../components/loader_widget.dart';
import '../../../configs.dart';
import '../../../main.dart';
import '../../../paymentGateways/models/payment_list_model.dart';
import '../../../paymentGateways/services/flutter_wave_service.dart';
import '../../../paymentGateways/services/paystack_service.dart';
import '../../../paymentGateways/services/razor_pay_service.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/model_keys.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../package/component/select_package_components.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';

class BookingStep3Component extends StatefulWidget {
  final bool isReschedule;

  BookingStep3Component({this.isReschedule = false});

  @override
  _BookingStep3ComponentState createState() => _BookingStep3ComponentState();
}

class _BookingStep3ComponentState extends State<BookingStep3Component> {
  bool _isPackageListEmpty = false;

  ScrollController scrollController = ScrollController();

  TextEditingController tipController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  FocusNode tipFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

  List<PaymentData> payments = getPaymentList();

  late PaymentData selectedPayment;

  RazorPayService razorPayService = RazorPayService();
  StripeService stripeServices = StripeService();
  PayStackService paystackServices = PayStackService();
  PayPalService payPalServices = PayPalService();
  FlutterWaveService flutterWaveServices = FlutterWaveService();

  String tempDate = '';
  String tempTime = '';

  DateTime? initialDateTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tempDate = bookingRequestStore.date.validate();
    tempTime = bookingRequestStore.time.validate();
    selectedPayment = payments.first;
    bookingRequestStore.setCouponApplied(false);
  }

  void saveBooking() {
    if (bookingRequestStore.bookingId == null) {
      appStore.setLoading(true);
      String dateString = tempDate + " " + tempTime;

      try {
        initialDateTime = DateTime.parse(dateString);

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
        bookingRequestStore.setNoteInRequest(noteController.text);
      } catch (e) {
        appStore.setLoading(false);
        return toast(e.toString());
      }

      /// Save Booking API
      saveBookingAPI(bookingRequestStore.toJson(dateTime: formatDate(initialDateTime.toString(), format: DateFormatConst.NEW_FORMAT), isRescheduleBooking: widget.isReschedule)).then((value) async {
        appStore.setLoading(false);
        bookingRequestStore.setBookingIdInRequest(value[CommonKey.bookingId]);

        if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_CASH) {
          savePayment(bookingId: bookingRequestStore.bookingId.validate(), isPackageReclaim: bookingRequestStore.isPackageReclaim).then((value) {
            finish(context);
            finish(context);
            showBookingCompleteDialog();
          }).catchError((e) {
            toast(e.toString());
          });
        } else {
          savePayment(bookingId: bookingRequestStore.bookingId.validate());
        }
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    } else {
      savePayment(bookingId: bookingRequestStore.bookingId.validate());
    }
  }

  void _handlePackageListEmpty() {
    setState(() {
      _isPackageListEmpty = true;
    });
  }

  Future<void> savePayment({required int bookingId, bool isPackageReclaim = false}) async {
    if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_CASH) {
      await savePay(
        bookingId: bookingId,
        externalTransactionId: '',
        transactionType: PaymentMethods.PAYMENT_METHOD_CASH,
        discountPercentage: 0,
        discountAmount: 0,
        taxData: bookingRequestStore.taxPercentage.validate(),

        /// if package is reclaimed then set the payment is paid
        paymentStatus: isPackageReclaim ? SERVICE_PAYMENT_STATUS_PAID : '0',
      );
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_RAZORPAY) {
      appStore.setLoading(true);

      razorPayService.init(
        razorKey: getStringAsync(PaymentKeys.RAZORPAY_PUBLIC_KEY),
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (res) {
          log(res);

          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      razorPayService.razorPayCheckout();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_STRIPE) {
      appStore.setLoading(true);

      await stripeServices.init(
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        isTest: true,
        discountAmount: 0,
        discountPercentage: 0,
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (res) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      stripeServices.stripePay().then((value) {
        appStore.setLoading(false);
        //
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_PAYSTACK) {
      appStore.setLoading(true);

      await paystackServices.init(
        context: context,
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (p0) {
          log(p0);

          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      paystackServices.checkout();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_PAYPAL) {
      appStore.setLoading(true);

      await payPalServices.init(
        context: context,
        isTest: true,
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (p0) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      payPalServices.paypalCheckOut();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE) {
      appStore.setLoading(true);

      flutterWaveServices.checkout(
        flutterWavePublicKey: getStringAsync(PaymentKeys.FLUTTER_WAVE_PUBLIC_KEY),
        flutterWaveSecretKey: getStringAsync(PaymentKeys.FLUTTER_WAVE_SECRET_KEY),
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        serviceTip: tipController.text.toDouble(),
        isTestMode: true,
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (p0) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);
    } else if (selectedPayment.id == PaymentMethods.AIRTEL_MONEY) {
      showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        barrierDismissible: false,
        builder: (context) {
          return AppCommonDialog(
            title: locale.airtelMoneyPayment,
            child: AirtelMoneyDialog(
              amount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
              reference: APP_NAME,
              serviceTip: tipController.text.toDouble(),
              taxData: bookingRequestStore.taxPercentage.validate(),
              bookingId: bookingRequestStore.bookingId.validate(),
              onComplete: (res) {
                finish(context);
                finish(context);
                showBookingCompleteDialog();
              },
            ),
          );
        },
      ).then((value) => appStore.setLoading(false));
    } else if (selectedPayment.id == PaymentMethods.CINET) {
      List<String> supportedCurrencies = ["XOF", "XAF", "CDF", "GNF", "USD"];

      if (!supportedCurrencies.contains(appStore.currencyCode)) {
        toast(locale.ciNetPayNotSupportedMessage);
        return;
      } else if (bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip < 100) {
        return toast('${locale.totalAmountShouldBeMoreThan} ${100.toPriceFormat()}');
      } else if (bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip > 1500000) {
        return toast('${locale.totalAmountShouldBeLessThan} ${1500000.toPriceFormat()}');
      }

      CinetPayServicesNew cinetPayServices = CinetPayServicesNew(
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (p0) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      cinetPayServices.payWithCinetPay(context: context);
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_SADAD_PAYMENT) {
      SadadServicesNew sadadServices = SadadServicesNew(
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        remarks: locale.topUpWallet,
        onComplete: (p0) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );

      sadadServices.payWithSadad(context);
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_MIDTRANS) {
      //TODO: all params check
      MidtransService midtransService = MidtransService();
      appStore.setLoading(true);
      await midtransService.initialize(
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        bookingId: bookingRequestStore.bookingId.validate(),
        onComplete: (res) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        },
      );
      await Future.delayed(const Duration(seconds: 1));
      midtransService.midtransPaymentCheckout().then((value) => appStore.setLoading(false));
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_PHONEPE) {
      PhonePeServices peServices = PhonePeServices(
        totalAmount: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip,
        bookingId: bookingRequestStore.bookingId.validate(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (res) {
          finish(context, true);
          finish(context, true);
          showBookingCompleteDialog();
        },
      );

      peServices.phonePeCheckout(context);
    }
  }

  void showBookingCompleteDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => CommonAppDialog(
        title: '${locale.bookingSuccessful}',
        subTitle:
            '${locale.yourBookingFor} ${bookingRequestStore.isPackagePurchase ? bookingRequestStore.selectedPackageList.map((e) => e.name.validate()).toList().join(', ') : bookingRequestStore.selectedServiceList.validate().map((e) => e.name.validate()).toList().join(', ')} has been successfully booked',
        buttonText: locale.goToBookings,
        onTap: () {
          finish(context);
          DashboardScreen(pageIndex: 1).launch(context, isNewTask: true);
        },
      ),
    );
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.height,

                ///Select Package
                if (bookingRequestStore.isPackagePurchase && !bookingRequestStore.isPackageReclaim) SelectPackageComponents( onPackageListEmpty: _handlePackageListEmpty).paddingBottom(16),

                /// Your reclaimed Package component
                if (bookingRequestStore.isPackagePurchase && bookingRequestStore.isPackageReclaim) YourPackageComponent(),

                /// Apply coupon component
                if (!bookingRequestStore.isPackageReclaim) ApplyCouponComponent(callback: () => setState(() {})).visible(!bookingRequestStore.isCouponApplied),
                if (!bookingRequestStore.isPackageReclaim)ViewAllLabel(label: locale.paymentMethod, isShowAll: false),
                if (!bookingRequestStore.isPackageReclaim) AnimatedListView(
                    shrinkWrap: true,
                    itemCount: bookingRequestStore.isPackageReclaim ? payments.take(1).length : payments.length,
                    listAnimationType: ListAnimationType.None,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.cardColor),
                        margin: EdgeInsets.only(bottom: 16),
                        child: SettingItemWidget(
                          title: payments[index].paymentMethod.validate(),
                          titleTextStyle: boldTextStyle(size: 14),
                          padding: EdgeInsets.only(left: 16, bottom: 10, top: 10, right: 10),
                          leading: CachedImageWidget(url: payments[index].icon.validate(), height: 22, width: 22, fit: BoxFit.contain),
                          radius: radius(),
                          trailing: Radio<PaymentData>(
                            value: payments[index],
                            visualDensity: VisualDensity.compact,
                            groupValue: selectedPayment,
                            onChanged: (value) {
                              selectedPayment = value!;

                              if (index == 0) {
                                tipController.text = '';
                                bookingRequestStore.setTip(0);
                              }
                              setState(() {});
                            },
                          ),
                          onTap: () {
                            selectedPayment = payments[index];

                            if (index == 0) {
                              tipController.text = '';
                              bookingRequestStore.setTip(0);
                            }
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                8.height,
                Text(locale.optionalDetails, style: boldTextStyle()),
                if (selectedPayment != payments.first)
                  AppTextField(
                    textFieldType: TextFieldType.NUMBER,
                    controller: tipController,
                    focus: tipFocusNode,
                    nextFocus: noteFocusNode,
                    decoration: inputDecoration(context, label: locale.tip),
                    onChanged: (s) {
                      bookingRequestStore.setTip(s.toInt());
                      scrollController.animToBottom();
                      setState(() {});
                    },
                    onTap: () {
                      scrollController.animToBottom();
                    },
                  ).paddingTop(16),
                16.height,
                AppTextField(
                  textFieldType: TextFieldType.MULTILINE,
                  controller: noteController,
                  focus: noteFocusNode,
                  minLines: 3,
                  maxLines: 4,
                  decoration: inputDecoration(context, label: locale.note),
                  onTap: () {
                    scrollController.animToBottom();
                  },
                  onChanged: (s) {
                    scrollController.animToBottom();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (_) => CommonBottomPriceWidget(
                title: bookingRequestStore.selectedServiceList.validate().map((e) => widget.isReschedule ? e.serviceName.validate() : e.name.validate()).toList().join(', '),
                price: bookingRequestStore.totalAmount,
                buttonText: locale.confirm,
                onTap: () {
                  doIfLoggedIn(context, () async {
                    bool? res = await showInDialog(
                      context,
                      builder: (context) => ConfirmBookingDialog(),
                    );

                    if (res ?? false) {
                      saveBooking();
                    }
                  });
                },
              ),
            ).visible(!_isPackageListEmpty),
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
