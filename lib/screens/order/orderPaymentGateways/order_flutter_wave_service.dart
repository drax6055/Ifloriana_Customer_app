import 'package:flutterwave_standard/flutterwave.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../configs.dart';
import '../../../network/rest_apis.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class OrderFlutterWaveService {
  final Customer customer = Customer(
    name: productStore.fullName,
    phoneNumber: productStore.contactNumber,
    email: userStore.userEmail,
  );

  void checkout({
    required String flutterWavePublicKey,
    required String flutterWaveSecretKey,
    required num totalAmount,
    required bool isTestMode,
    required Function(dynamic) onComplete,
  }) async {
    String transactionId = Uuid().v1();

    Flutterwave flutterWave = Flutterwave(
      context: getContext,
      publicKey: flutterWavePublicKey,
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

        verifyPayment(transactionId: value.transactionId.validate(), flutterWaveSecretKey: flutterWaveSecretKey).then((v) async {
          if (v.status == "success") {

            onComplete.call(value.transactionId);

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
