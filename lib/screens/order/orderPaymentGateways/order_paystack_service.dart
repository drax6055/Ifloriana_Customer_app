import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';


class OrderPayStackService {
  late BuildContext ctx;
  PaystackPlugin paystackPlugin = PaystackPlugin();
  num totalAmount = 0;
  String paystackPaymentPublicKey = getStringAsync(PaymentKeys.PAY_STACK_PUBLIC_KEY);
  String userEmail = "";
  late Function(dynamic) onComplete;

  init({
    required BuildContext context,
    required num totalAmount,
    required Function(dynamic) onComplete,
  }) {
    paystackPlugin.initialize(publicKey: paystackPaymentPublicKey);
    this.ctx = context;
    this.userEmail = productStore.customerEmail;
    this.totalAmount = totalAmount;
    this.onComplete = onComplete;
  }

  Future checkout() async {
    int price = totalAmount.toInt() * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
      ..email = userEmail
      ..currency = appStore.currencyCode;

    CheckoutResponse response = await paystackPlugin.checkout(
      ctx,
      method: CheckoutMethod.card,
      charge: charge,
    );

    log('Response: $response');

    if (response.status == true) {
      log('Response $response');

      onComplete.call(response.reference);

      log('Payment was successful. Ref: ${response.reference}');
    } else {
      toast(response.message, print: true);
    }
  }
}
