import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../configs.dart';
import '../../../main.dart';
import '../../../network/network_utils.dart';
import '../../../paymentGateways/models/stripe_pay_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

class OrderStripeService {
  num totalAmount = 0;
  String stripeURL = 'https://api.stripe.com/v1/payment_intents';
  String stripePaymentKey = getStringAsync(PaymentKeys.STRIPE_SECRET_KEY);
  bool isTest = false;
  late Function(dynamic) onComplete;

  init({
    required num totalAmount,
    required bool isTest,
    required Function(dynamic) onComplete,
  }) async {
    Stripe.publishableKey = getStringAsync(PaymentKeys.STRIPE_PUBLIC_KEY);
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    await Stripe.instance.applySettings().catchError((e) {
      toast(e.toString(), print: true);

      throw e.toString();
    });
    this.totalAmount = totalAmount;
    this.isTest = isTest;
    this.onComplete = onComplete;
  }

  //StripPayment
  Future<dynamic> stripePay() async {
    Request request = http.Request(HttpMethodType.POST.name, Uri.parse(stripeURL));

    request.bodyFields = {
      'amount': '${(totalAmount.toInt() * 100)}',
      'currency': appStore.currencyCode,
      'description': 'Name: ${productStore.fullName} - Email: ${productStore.customerEmail}',
    };

    request.headers.addAll(buildHeaderTokens(extraKeys: {'isStripePayment': true, 'stripeKeyPayment': stripePaymentKey}));

    log('URL: ${request.url}');
    log('Header: ${request.headers}');
    log('Request: ${request.bodyFields}');

    await request.send().then((value) {
      http.Response.fromStream(value).then((response) async {
        if (response.statusCode.isSuccessful()) {
          StripePayModel res = StripePayModel.fromJson(jsonDecode(response.body));
          appStore.setLoading(true);

          SetupPaymentSheetParameters setupPaymentSheetParameters = SetupPaymentSheetParameters(
            paymentIntentClientSecret: res.clientSecret.validate(),
            style: appThemeMode,
            appearance: PaymentSheetAppearance(colors: PaymentSheetAppearanceColors(primary: primaryColor)),
            applePay: PaymentSheetApplePay(merchantCountryCode: defaultCountry().countryCode),
            googlePay: PaymentSheetGooglePay(merchantCountryCode: defaultCountry().countryCode, testEnv: isTest),
            merchantDisplayName: APP_NAME,
            customerId: userStore.userId.toString(),
            customerEphemeralKeySecret: isAndroid ? res.clientSecret.validate() : null,
            setupIntentClientSecret: res.clientSecret.validate(),
            billingDetails: BillingDetails(name: productStore.fullName, email: productStore.customerEmail),
          );

          await Stripe.instance.initPaymentSheet(paymentSheetParameters: setupPaymentSheetParameters).then((value) async {
            await Stripe.instance.presentPaymentSheet().then((value) async {
              onComplete.call(res.id);

              appStore.setLoading(false);
            });
          }).catchError((e) {
            appStore.setLoading(false);
            throw errorSomethingWentWrong;
          });
        } else if (response.statusCode == 400) {
          appStore.setLoading(false);
          throw errorSomethingWentWrong;
        }
      }).catchError((e) {
        appStore.setLoading(false);
        throw errorSomethingWentWrong;
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);

      throw e.toString();
    });
  }
}
