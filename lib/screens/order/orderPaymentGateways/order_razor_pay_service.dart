import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../configs.dart';
import '../../../main.dart';

class OrderRazorPayService {
  static late Razorpay razorPay;
  static late String razorKeys;
  num totalAmount = 0;
  late Function(dynamic) onComplete;

  init({
    required String razorKey,
    required num totalAmount,
    required Function(dynamic) onComplete,
  }) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    this.totalAmount = totalAmount;
    this.onComplete = onComplete;
  }

  Future handlePaymentSuccess(PaymentSuccessResponse response) async {
    onComplete.call(response.paymentId);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    toast(response.message.validate(), print: true);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    toast("${locale.externalWallet} " + response.walletName!);
  }

  void razorPayCheckout() async {
    var options = {
      'key': razorKeys,
      'amount': (totalAmount * 100),
      'name': APP_NAME,
      'theme.color': '#A82D86',
      'description': APP_NAME,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': appStore.currencyCode,
      'prefill': {'contact': productStore.contactNumber, 'email': productStore.customerEmail},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
