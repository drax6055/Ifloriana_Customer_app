import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../screens/booking/model/booking_detail_response.dart';
import '../../screens/services/models/service_response.dart';
import '../../utils/constants.dart';
import '../payment_repo.dart';

class PayPalService {
  late BuildContext ctx;
  num totalAmount = 0;
  int bookingId = 0;
  String payPalClientId = getStringAsync(PaymentKeys.PAYPAL_CLIENT_ID);
  String secretKey = getStringAsync(PaymentKeys.PAYPAL_SECRET_KEY);
  num discountAmount = 0;
  num discountPercentage = 0;
  num? serviceTip;
  bool isTest = false;
  List<ServiceListData> services = [];
  List<TaxPercentage> taxData = [];
  late Function(Map<String, dynamic>) onComplete;

  init({
    required BuildContext context,
    required num totalAmount,
    required int bookingId,
    required num discountAmount,
    required num discountPercentage,
    num? serviceTip,
    required bool isTest,
    required List<TaxPercentage> taxData,
    required Function(Map<String, dynamic>) onComplete,
  }) {
    this.ctx = context;

    this.totalAmount = totalAmount;
    this.bookingId = bookingId;
    this.discountAmount = discountAmount;
    this.discountPercentage = discountPercentage;
    this.serviceTip = serviceTip;
    this.isTest = isTest;
    this.taxData = taxData;
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
            "currency": appStore.currencyCode,
            "details": {"subtotal": totalAmount, "shipping": '0', "shipping_discount": 0}
          },
          "description": "The payment transaction description.",
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");

        onComplete.call(await savePay(
          bookingId: bookingId,
          discountAmount: discountAmount,
          discountPercentage: discountPercentage,
          externalTransactionId: params['data']['id'],
          taxData: taxData,
          transactionType: PaymentMethods.PAYMENT_METHOD_PAYPAL,
          paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          serviceTip: serviceTip,
        ));
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
