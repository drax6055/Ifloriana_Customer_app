
import '../../main.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';

class PaymentData {
  final String? id;
  final String? paymentMethod;
  final String? icon;
  final bool isSelected;

  PaymentData({
    this.id,
    this.paymentMethod,
    this.icon,
    this.isSelected = false,
  });
}

List<PaymentData> getPaymentList({bool includeCash = true}) {
  List<PaymentData> list = [];

  if (includeCash) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_CASH, icon: ic_payment, paymentMethod: locale.cashAfterService));
  if (appConfigurationResponseCached!.razorPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_RAZORPAY, icon: razorpay_logo, paymentMethod: locale.razorpay));
  if (appConfigurationResponseCached!.stripePay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_STRIPE, icon: stripe_logo, paymentMethod: locale.stripe));
  if (appConfigurationResponseCached!.payStackPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_PAYSTACK, icon: paystack_logo, paymentMethod: locale.paystack));
  if (appConfigurationResponseCached!.paypalPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_PAYPAL, icon: paypal_logo, paymentMethod: locale.paypal));
  if (appConfigurationResponseCached!.flutterWavePay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE, icon: flutter_wave_logo, paymentMethod: locale.flutterwave));
  if (appConfigurationResponseCached!.airtelMoneyPay != null) list.add(PaymentData(id: PaymentMethods.AIRTEL_MONEY, icon: ic_airtel_money_logo, paymentMethod: locale.airtelMoneyPayment));
  if (appConfigurationResponseCached!.cinetPay != null) list.add(PaymentData(id: PaymentMethods.CINET, icon: ic_cinet_pay, paymentMethod: locale.ciNetPay));
  if (appConfigurationResponseCached!.sadadPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_SADAD_PAYMENT, icon: ic_sadad_payment, paymentMethod: locale.sadadPayment));
  if (appConfigurationResponseCached!.airtelMoneyPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_MIDTRANS, icon: ic_midtrance_pay, paymentMethod: locale.midTransPayment));
  if (appConfigurationResponseCached!.phonePayPay != null) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_PHONEPE, icon: ic_phone_pe, paymentMethod: locale.phonePe));

  return list;
}
