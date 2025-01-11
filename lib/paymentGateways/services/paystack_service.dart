import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/paymentGateways/payment_repo.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../screens/booking/model/booking_detail_response.dart';
import '../../utils/constants.dart';

class PayStackService {
  late BuildContext ctx;
  PaystackPlugin paystackPlugin = PaystackPlugin();
  num totalAmount = 0;
  int bookingId = 0;
  String paystackPaymentPublicKey = getStringAsync(PaymentKeys.PAY_STACK_PUBLIC_KEY);
  String userEmail = "";
  num discountAmount = 0;
  num discountPercentage = 0;
  num? serviceTip;
  List<TaxPercentage> taxData = [];
  late Function(Map<String, dynamic>) onComplete;

  init({
    required BuildContext context,
    required num totalAmount,
    required int bookingId,
    required num discountAmount,
    required num discountPercentage,
    num? serviceTip,
    required List<TaxPercentage> taxData,
    required Function(Map<String, dynamic>) onComplete,
  }) {
    paystackPlugin.initialize(publicKey: paystackPaymentPublicKey);
    this.ctx = context;
    this.userEmail = userStore.userEmail;
    this.totalAmount = totalAmount;
    this.bookingId = bookingId;
    this.discountAmount = discountAmount;
    this.discountPercentage = discountPercentage;
    this.serviceTip = serviceTip;
    this.taxData = taxData;
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

      onComplete.call(await savePay(
        bookingId: bookingId,
        discountAmount: discountAmount,
        discountPercentage: discountPercentage,
        externalTransactionId: response.reference.validate(),
        taxData: taxData,
        transactionType: PaymentMethods.PAYMENT_METHOD_PAYSTACK,
        paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
        serviceTip: serviceTip,
      ));

      log('Payment was successful. Ref: ${response.reference}');
    } else {
      toast(response.message, print: true);
    }
  }
}
