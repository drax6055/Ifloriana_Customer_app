import 'package:flutter/material.dart';
import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../configs.dart';
import '../../main.dart';
import '../../utils/constants.dart';
import '../payment_repo.dart';

class RazorPayService {
  static late Razorpay razorPay;
  static late String razorKeys;
  num totalAmount = 0;
  int bookingId = 0;
  num discountAmount = 0;
  num discountPercentage = 0;
  num? serviceTip;
  List<TaxPercentage> taxData = [];
  late Function(Map<String, dynamic>) onComplete;

  init({
    required String razorKey,
    required num totalAmount,
    required int bookingId,
    required num discountAmount,
    required num discountPercentage,
    num? serviceTip,
    required List<TaxPercentage> taxData,
    required Function(Map<String, dynamic>) onComplete,
  }) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    razorKeys = razorKey;
    this.totalAmount = totalAmount;
    this.bookingId = bookingId;
    this.discountAmount = discountAmount;
    this.discountPercentage = discountPercentage;
    this.serviceTip = serviceTip;
    this.taxData = taxData;
    this.onComplete = onComplete;
  }

  Future handlePaymentSuccess(PaymentSuccessResponse response) async {
    onComplete.call(await savePay(
      transactionType: PaymentMethods.PAYMENT_METHOD_RAZORPAY,
      paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
      externalTransactionId: response.paymentId!,
      bookingId: bookingId,
      discountAmount: discountAmount,
      discountPercentage: discountPercentage,
      taxData: taxData,
      serviceTip: serviceTip,
    ));
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
      'amount': (totalAmount * 100).toInt(),
      'name': APP_NAME,
      'theme.color': '#A82D86',
      'description': APP_NAME,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': appStore.currencyCode,
      'prefill': {'contact': userStore.userContactNumber, 'email': userStore.userEmail},
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
