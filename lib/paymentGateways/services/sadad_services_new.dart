import 'package:flutter/cupertino.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/network/rest_apis.dart';
import 'package:ifloriana/paymentGateways/payment_repo.dart';
import 'package:ifloriana/paymentGateways/screens/payment_webview_screen.dart';
import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SadadServicesNew {
  String remarks;
  num totalAmount;
  int bookingId;
  num? serviceTip;
  List<TaxPercentage> taxData = [];
  late Function(Map<String, dynamic>) onComplete;

  SadadServicesNew({
    //required this.paymentSetting,
    required this.totalAmount,
    this.remarks = "",
    required this.bookingId,
    required this.taxData,
    required this.serviceTip,
    required Function(Map) onComplete,
  });

  Future<void> payWithSadad(BuildContext context) async {
    String sadadId = getStringAsync(PaymentKeys.SADAD_CLIENT_ID);
    String sadadKey = getStringAsync(PaymentKeys.SADAD_SECRET_KEY);
    String sadadDomain = getStringAsync(PaymentKeys.SADAD_DOMAIN);

    if (sadadId.isEmpty || sadadKey.isEmpty || sadadDomain.isEmpty) throw locale.accessDeniedContactYourAdmin;

    Map request = {
      "sadadId": sadadId,
      "secretKey": sadadKey,
      "domain": sadadDomain,
    };
    appStore.setLoading(true);
    await sadadLogin(request).then((accessToken) async {
      await createInvoice(context, accessToken: accessToken).then((value) async {
        //
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  Future<void> createInvoice(BuildContext context, {required String accessToken}) async {
    Map<String, dynamic> req = {
      "countryCode": 974,
      "clientname": userStore.userName.validate(),
      "cellnumber": userStore.userContactNumber.validate().splitAfter('-'),
      "invoicedetails": [
        {
          "description": 'Name: ${userStore.userFullName} - Email: ${userStore.userEmail}',
          "quantity": 1,
          "amount": totalAmount,
        },
      ],
      "status": 2,
      "remarks": remarks,
      "amount": totalAmount,
    };
    sadadCreateInvoice(request: req, sadadToken: accessToken).then((value) async {
      appStore.setLoading(false);
      log('val:${value[0]['shareUrl']}');

      String? res = await PaymentWebViewScreen(url: value[0]['shareUrl'], accessToken: accessToken).launch(context);

      if (res.validate().isNotEmpty) {
        onComplete.call(await savePay(
          bookingId: bookingId,
          discountAmount: 0,
          discountPercentage: 0,
          externalTransactionId: res.validate(),
          taxData: taxData,
          transactionType: PaymentMethods.CINET,
          paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
          serviceTip: serviceTip,
        ));
      } else {
        toast(locale.transactionFailed, print: true);
      }
    }).catchError((e) {
      appStore.setLoading(false);
      toast('Error: $e', print: true);
    });
  }
}
// Handle CinetPayment
