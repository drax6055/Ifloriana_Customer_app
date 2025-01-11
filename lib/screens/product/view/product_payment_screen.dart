import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/screens/order/view/order_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/common_app_dialog.dart';
import '../../../main.dart';
import '../../../paymentGateways/models/payment_list_model.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../booking/component/confirm_booking_dialog.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../order/orderPaymentGateways/order_flutter_wave_service.dart';
import '../../order/orderPaymentGateways/order_paypal_service.dart';
import '../../order/orderPaymentGateways/order_paystack_service.dart';
import '../../order/orderPaymentGateways/order_razor_pay_service.dart';
import '../../order/orderPaymentGateways/order_stripe_service.dart';
import '../../order/order_repository.dart';

class ProductPaymentScreen extends StatefulWidget {
  @override
  _ProductPaymentScreenState createState() => _ProductPaymentScreenState();
}

class _ProductPaymentScreenState extends State<ProductPaymentScreen> {
  List<PaymentData> payments = getPaymentList();

  late PaymentData selectedPayment;

  OrderRazorPayService razorPayService = OrderRazorPayService();
  OrderStripeService stripeServices = OrderStripeService();
  OrderPayStackService paystackServices = OrderPayStackService();
  OrderPayPalService payPalServices = OrderPayPalService();
  OrderFlutterWaveService flutterWaveServices = OrderFlutterWaveService();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    selectedPayment = payments.first;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void placeOrder({required String txnId, required String paymentType, required String paymentStatus}) {
    appStore.setLoading(true);

    Map request = {
      "location_id": 1,
      "shipping_address_id": productStore.addressData.id,
      "billing_address_id": productStore.addressData.id,
      "phone": productStore.contactNumber,
      "alternative_phone": productStore.alternateContactNumber.isNotEmpty ? productStore.alternateContactNumber : '',
      "chosen_logistic_zone_id": productStore.logisticZoneData.logisticId,
      "shipping_delivery_type": SHIPPING_DELIVERY_TYPE_REGULAR,
      "payment_method": paymentType,
      "payment_details": txnId.isNotEmpty ? txnId : '',
      "payment_status": paymentStatus,
    };

    /// Place Order API
    placeOrderAPI(request).then((value) async {
      productStore.setCartItemCount(0);
      appStore.setLoading(false);
      finish(context);
      showOrderCompleteDialog();
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> savePayment() async {
    if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_CASH) {
      placeOrder(
        txnId: '',
        paymentType: PaymentMethods.PAYMENT_METHOD_CASH,
        paymentStatus: SERVICE_PAYMENT_STATUS_UNPAID,
      );
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_RAZORPAY) {
      appStore.setLoading(true);

      razorPayService.init(
        razorKey: getStringAsync(PaymentKeys.RAZORPAY_PUBLIC_KEY),
        totalAmount: productStore.totalAmount,
        onComplete: (res) {
          log(res);

          placeOrder(
            txnId: res,
            paymentType: PaymentMethods.PAYMENT_METHOD_RAZORPAY,
            paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          );
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      razorPayService.razorPayCheckout();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_STRIPE) {
      appStore.setLoading(true);

      await stripeServices.init(
        totalAmount: productStore.totalAmount,
        isTest: true,
        onComplete: (res) {
          log(res);

          placeOrder(
            txnId: res,
            paymentType: PaymentMethods.PAYMENT_METHOD_STRIPE,
            paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          );
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
        totalAmount: productStore.totalAmount,
        onComplete: (response) {
          log(response);

          placeOrder(
            txnId: response,
            paymentType: PaymentMethods.PAYMENT_METHOD_PAYSTACK,
            paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          );
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
        totalAmount: productStore.totalAmount,
        onComplete: (response) {
          log(response);

          placeOrder(
            txnId: response,
            paymentType: PaymentMethods.PAYMENT_METHOD_PAYPAL,
            paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          );
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
        totalAmount: productStore.totalAmount,
        isTestMode: true,
        onComplete: (res) {
          log(res);

          placeOrder(
            txnId: res,
            paymentType: PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE,
            paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          );
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);
    }
  }

  void showOrderCompleteDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => CommonAppDialog(
        title: '${locale.orderSuccessfullyPlaced}!',
        subTitle: locale.yorOrderHasBeen,
        buttonText: locale.goToOrderList,
        onTap: () {
          finish(context);
          DashboardScreen(pageIndex: 3).launch(context, isNewTask: true);
          OrderListScreen(showBack: true).launch(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.payment,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.height,
                Text(locale.choosePaymentMethod, style: boldTextStyle()),
                8.height,
                Text(locale.chooseYourConvenientPayment, style: secondaryTextStyle()),
                32.height,
                AnimatedListView(
                  shrinkWrap: true,
                  itemCount: payments.length,
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
                            setState(() {});
                          },
                        ),
                        onTap: () {
                          selectedPayment = payments[index];
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: context.width(),
              child: Text(locale.placeOrder, style: boldTextStyle(color: Colors.white)),
              color: secondaryColor,
              onTap: () {
                doIfLoggedIn(context, () async {
                  bool? res = await showInDialog(
                    context,
                    builder: (context) => ConfirmBookingDialog(
                      title: locale.confirmOrder,
                      subTitle: '${locale.doYouConfirmThisPayment}?',
                    ),
                  );

                  if (res ?? false) {
                    savePayment();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
