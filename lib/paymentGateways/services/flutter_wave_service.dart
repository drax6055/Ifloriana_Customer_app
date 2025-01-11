import 'package:flutterwave_standard/flutterwave.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

import '../../configs.dart';
import '../../network/rest_apis.dart';
import '../../screens/booking/model/booking_detail_response.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';
import '../payment_repo.dart';

class FlutterWaveService {
  final Customer customer = Customer(
    name: userStore.userName,
    phoneNumber: userStore.userContactNumber,
    email: userStore.userEmail,
  );

  void checkout({
    required String flutterWavePublicKey,
    required String flutterWaveSecretKey,
    required num totalAmount,
    required int bookingId,
    required num discountAmount,
    required num discountPercentage,
    num? serviceTip,
    required bool isTestMode,
    required List<TaxPercentage> taxData,
    required Function(Map<String, dynamic>) onComplete,
  }) async {
    String transactionId = Uuid().v1();

    Flutterwave flutterWave = Flutterwave(
      context: getContext,
      publicKey: getStringAsync(PaymentKeys.FLUTTER_WAVE_PUBLIC_KEY),
      currency: appStore.currencyCode,
      redirectUrl: BASE_URL,
      txRef: transactionId,
      amount: totalAmount.validate().toStringAsFixed(DECIMAL_POINT),
      customer: customer,
      paymentOptions: "ussd, card, payattitude, barter, bank transfer",
      customization: Customization(title: locale.payWithFlutterwave, logo: app_logo),
      isTestMode: isTestMode,
    );

    await flutterWave.charge().then((value) {
      if (value.status == "successful") {
        appStore.setLoading(true);

        verifyPayment(transactionId: value.transactionId.validate(), flutterWaveSecretKey: getStringAsync(PaymentKeys.FLUTTER_WAVE_SECRET_KEY)).then((v) async {
          if (v.status == "success") {
            onComplete.call(
              await savePay(
                bookingId: bookingId,
                discountAmount: discountAmount,
                discountPercentage: discountPercentage,
                externalTransactionId: value.transactionId.validate(),
                taxData: taxData,
                transactionType: PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE,
                paymentStatus: SERVICE_PAYMENT_STATUS_PAID,
                serviceTip: serviceTip,
              ),
            );
          } else {
            appStore.setLoading(false);
            toast(locale.transactionFailed);
          }
        }).catchError((e) {
          appStore.setLoading(false);

          toast(e.toString());
        });
      } else {
        toast(locale.transactionCancelled);
        appStore.setLoading(false);
      }
    });
  }
}
