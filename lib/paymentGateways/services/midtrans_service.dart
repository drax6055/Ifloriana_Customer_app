import 'dart:math';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/paymentGateways/payment_repo.dart';
import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:midpay/midpay.dart';
import 'package:nb_utils/nb_utils.dart';

class MidtransService {
  Midpay midpay = Midpay();
  num totalAmount = 0;
  int bookingId = 0;
  num? serviceTip;
  List<TaxPercentage>? taxData = [];

  late Function(Map<String, dynamic>) onComplete;
  final String transactionId = Random().nextInt(100000000).toString();

  initialize({
    required num totalAmount,
    int? bookingId,
    num? serviceTip,
    List<TaxPercentage>? taxData,
    required Function(Map<String, dynamic>) onComplete,
  }) {
    this.totalAmount = totalAmount;
    this.bookingId = bookingId.validate();
    this.onComplete = onComplete;
    this.taxData = taxData;
    this.serviceTip = serviceTip;
  }

  Future midtransPaymentCheckout() async {
    //for android auto sandbox when debug and production when release
    String clientId = getStringAsync(PaymentKeys.MIDTRANS_CLIENT_ID);
    if (clientId.isEmpty) throw locale.accessDeniedContactYourAdmin;

    midpay.init(
      clientId,
      getStringAsync(PaymentKeys.MIDTRANS_IS_IN_PRODUCTION) != "1" ? "https://app.sandbox.midtrans.com/snap/v1/transactions/" : 'https://app.midtrans.com/snap/v1/transactions/',
      environment: getStringAsync(PaymentKeys.MIDTRANS_IS_IN_PRODUCTION) != "1" ? Environment.sandbox : Environment.production,
    );

    var midtransCustomer = MidtransCustomer(userStore.userFirstName, userStore.userLastName, userStore.userEmail, userStore.userContactNumber);

    List<MidtransItem> listitems = [];

    var midtransTransaction = MidtransTransaction(totalAmount.toInt() /*100000*/, midtransCustomer, listitems, skipCustomer: true); //TODO: check

    midpay.makePayment(midtransTransaction).catchError((err) => log("ERROR $err"));

    midpay.setFinishCallback(_callback);
  }

  //callback
  Future<void> _callback(TransactionFinished finished) async {
    log("Finish $finished");
    onComplete.call(await savePay(
      bookingId: bookingId,
      discountAmount: 0,
      discountPercentage: 0,
      externalTransactionId: transactionId,
      taxData: taxData.validate(),
      transactionType: PaymentMethods.PAYMENT_METHOD_MIDTRANS,
      paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
      serviceTip: serviceTip,
    ));
    return Future.value(null);
  }
}
