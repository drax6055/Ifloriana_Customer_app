import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class OrderPayPalService {
  late BuildContext ctx;
  num totalAmount = 0;
  String payPalClientId =getStringAsync(PaymentKeys.PAYPAL_CLIENT_ID);
  String secretKey = getStringAsync(PaymentKeys.PAYPAL_CLIENT_ID);
  bool isTest = false;
  late Function(dynamic) onComplete;

  init({
    required BuildContext context,

    required num totalAmount,
    required bool isTest,
    required Function(dynamic) onComplete,
  }) {
    this.ctx = context;

    this.totalAmount = totalAmount;
    this.isTest = isTest;
    this.onComplete = onComplete;
  }

  Future paypalCheckOut() async {
    PaypalCheckout(
      sandboxMode: isTest,
      clientId: payPalClientId,
      secretKey: secretKey,
      returnURL: "junedr375.github.io/junedr375-payment/",
      cancelURL: "junedr375.github.io/junedr375-payment/error.html",
      transactions: [
        {
          "amount": {
            "total": totalAmount,
            "currency":appStore.currencyCode,
            "details": {"subtotal": totalAmount, "shipping": '0', "shipping_discount": 0}
          },
          "description": "Name: ${userStore.userName} - Email: ${userStore.userEmail}",
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");

        onComplete.call(params['data']['id']);
      },
      onError: (error) {
        log("onError: $error");
        toast("onError: $error");
        Navigator.pop(ctx);
      },
      onCancel: (params) {
        toast('cancelled');
      },
    ).launch(ctx);
  }
}
