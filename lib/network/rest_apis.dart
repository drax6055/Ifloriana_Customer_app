import 'package:ifloriana/configs.dart';
import 'package:ifloriana/network/network_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../models/configuration_response.dart';
import '../models/verify_transaction_response.dart';
import '../utils/api_end_points.dart';
import '../utils/constants.dart';

Future<void> clearPreferences() async {
  await userStore.setFirstName('');
  await userStore.setLastName('');
  await userStore.setUserId(0);
  await userStore.setUserName('');
  await userStore.setContactNumber('');
  await userStore.setGenderValue('');
  await userStore.setUserProfile('');
  await userStore.setUId('');
  await userStore.setToken('');

  await appStore.setHelplineNumber('');
  await appStore.setInquiryEmail('');
  await appStore.setLoggedIn(false);
}

//region Configurations Api
Future<ConfigurationResponse> getAppConfigurations({bool isCurrentLocation = false, double? lat, double? long}) async {
  try {
    appConfigurationResponseCached = ConfigurationResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.appConfiguration}?is_authenticated=1', method: HttpMethodType.POST)));

    if (appConfigurationResponseCached!.onesignalCustomerApp != null) {
      await setValue(ConfigurationKeyConst.ONESIGNAL_API_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalAppId);
      await setValue(ConfigurationKeyConst.ONESIGNAL_CHANNEL_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalChannelId);
      await setValue(ConfigurationKeyConst.ONESIGNAL_REST_API_KEY, appConfigurationResponseCached!.onesignalCustomerApp!.onesignalRestApiKey);

      /// Initialize OneSignal if we get API Keys
      // initOneSignal();
    }

    // set cinet pay  keys
    if (appConfigurationResponseCached!.cinetPay != null) {
      await setValue(PaymentKeys.CINET_CLIENT_ID, appConfigurationResponseCached!.cinetPay!.cinetClientId);
      await setValue(PaymentKeys.CINET_API_KEY, appConfigurationResponseCached!.cinetPay!.cinetApiKey);
      await setValue(PaymentKeys.CINET_SECRET_KEY, appConfigurationResponseCached!.cinetPay!.cinetSecretkey);
      await setValue(PaymentKeys.CINET_SITE_ID, appConfigurationResponseCached!.cinetPay!.cinetSiteID);
    }
    // set sadad pay  keys
    if (appConfigurationResponseCached!.sadadPay != null) {
      await setValue(PaymentKeys.SADAD_CLIENT_ID, appConfigurationResponseCached!.sadadPay!.sadadClientId);
      await setValue(PaymentKeys.SADAD_SECRET_KEY, appConfigurationResponseCached!.sadadPay!.sadadSecretKey);
      await setValue(PaymentKeys.SADAD_DOMAIN, appConfigurationResponseCached!.sadadPay!.sadadDomain);
    }
    // set airtel money keys
    if (appConfigurationResponseCached!.airtelMoneyPay != null) {
      await setValue(PaymentKeys.AIRTEL_MONEY_CLIENT_ID, appConfigurationResponseCached!.airtelMoneyPay!.airtelMoneyClientId);
      await setValue(PaymentKeys.AIRTEL_MONEY_SECRET_KEY, appConfigurationResponseCached!.airtelMoneyPay!.airtelMoneySecretKey);
      await setValue(PaymentKeys.AIRTEL_MONEY_IS_IN_PRODUCTION, appConfigurationResponseCached!.airtelMoneyPay!.airtelMoneyIsInProduction);
    }
    // set razorpay keys
    if (appConfigurationResponseCached!.razorPay != null) {
      await setValue(PaymentKeys.RAZORPAY_SECRET_KEY, appConfigurationResponseCached!.razorPay!.razorpaySecretKey);
      await setValue(PaymentKeys.RAZORPAY_PUBLIC_KEY, appConfigurationResponseCached!.razorPay!.razorpayPublicKey);
    }
    // set stripe keys
    if (appConfigurationResponseCached!.stripePay != null) {
      await setValue(PaymentKeys.STRIPE_SECRET_KEY, appConfigurationResponseCached!.stripePay!.stripeSecretKey);
      await setValue(PaymentKeys.STRIPE_PUBLIC_KEY, appConfigurationResponseCached!.stripePay!.stripePublicKey);
    }
    // set pay stack keys
    if (appConfigurationResponseCached!.payStackPay != null) {
      await setValue(PaymentKeys.PAY_STACK_SECRET_KEY, appConfigurationResponseCached!.payStackPay!.payStackSecretKey);
      await setValue(PaymentKeys.PAY_STACK_PUBLIC_KEY, appConfigurationResponseCached!.payStackPay!.payStackPublicKey);
    }
    // set paypal keys
    if (appConfigurationResponseCached!.paypalPay != null) {
      await setValue(PaymentKeys.PAYPAL_SECRET_KEY, appConfigurationResponseCached!.paypalPay!.paypalSecretKey);
      await setValue(PaymentKeys.PAYPAL_CLIENT_ID, appConfigurationResponseCached!.paypalPay!.paypalClientId);
    }
    // set flutter wave keys
    if (appConfigurationResponseCached!.flutterWavePay != null) {
      await setValue(PaymentKeys.FLUTTER_WAVE_SECRET_KEY, appConfigurationResponseCached!.flutterWavePay!.flutterWaveSecretKey);
      await setValue(PaymentKeys.FLUTTER_WAVE_PUBLIC_KEY, appConfigurationResponseCached!.flutterWavePay!.flutterWavePublicKey);
    }

    // set phone pay  keys
    if (appConfigurationResponseCached!.phonePayPay != null) {
      await setValue(PaymentKeys.PHONE_PAY_APP_ID, appConfigurationResponseCached!.phonePayPay!.phonePayAppId);
      await setValue(PaymentKeys.PHONE_PAY_MERCHANT_ID, appConfigurationResponseCached!.phonePayPay!.phonePayMerchantId);
      await setValue(PaymentKeys.PHONE_PAY_SALT_ID, appConfigurationResponseCached!.phonePayPay!.phonePaySaltId);
      await setValue(PaymentKeys.PHONE_PAY_SALT_KEY, appConfigurationResponseCached!.phonePayPay!.phonePaySaltId);
      await setValue(PaymentKeys.PHONE_PAY_IS_IN_PRODUCTION, appConfigurationResponseCached!.phonePayPay!.phonePayIsInProduction);
    }
    // set midtrance keys
    if (appConfigurationResponseCached!.midtransPay != null) {
      await setValue(PaymentKeys.MIDTRANS_CLIENT_ID, appConfigurationResponseCached!.midtransPay!.midtransClientId);
      await setValue(PaymentKeys.MIDTRANS_IS_IN_PRODUCTION, appConfigurationResponseCached!.midtransPay!.midtranceIsInProduction);
    }

    await setValue(ConfigurationKeyConst.APP_NAME, appConfigurationResponseCached!.appName);
    await setValue(ConfigurationKeyConst.FOOTER_TEXT, appConfigurationResponseCached!.footerText);
    await setValue(ConfigurationKeyConst.HELPLINE_NUMBER, appConfigurationResponseCached!.helplineNumber.validate(value: HELP_LINE_NUMBER));
    await setValue(ConfigurationKeyConst.COPYRIGHT, appConfigurationResponseCached!.copyright);
    await setValue(ConfigurationKeyConst.INQUIRY_EMAIL, appConfigurationResponseCached!.inquiryEmail.validate(value: INQUIRY_SUPPORT_EMAIL));
    await setValue(ConfigurationKeyConst.SITE_DESCRIPTION, appConfigurationResponseCached!.siteDescription);
    await setValue(ConfigurationKeyConst.PRIMARY, appConfigurationResponseCached!.primaryColor);
    appConfigurationResponseCached!.pages.forEach((element) async {
      if (element.slug == 'privacy-policy') {
        await setValue(ConfigurationKeyConst.PRIVACY_POLICY, element.description);
      } else if (element.slug == 'term-condition') {
        await setValue(ConfigurationKeyConst.TERMS_CONDITION, element.description);
      } else if (element.slug == 'faq') {
        await setValue(ConfigurationKeyConst.FAQ, element.description);
      }
    });
    await setValue(ConfigurationKeyConst.GOOGLE_MAPS_KEY, appConfigurationResponseCached!.googleMapsKey);
    await setValue(ConfigurationKeyConst.CUSTOMER_APP_PLAY_STORE, appConfigurationResponseCached!.customerAppPlayStore);
    await setValue(ConfigurationKeyConst.CUSTOMER_APP_APP_STORE, appConfigurationResponseCached!.customerAppAppStore);
    await setValue(ConfigurationKeyConst.GOOGLE_LOGIN_STATUS, appConfigurationResponseCached!.googleLoginStatus);
    await setValue(ConfigurationKeyConst.APPLE_LOGIN_STATUS, appConfigurationResponseCached!.appleLoginStatus);
    await setValue(ConfigurationKeyConst.OTP_LOGIN_STATUS, appConfigurationResponseCached!.otpLoginStatus);
    await setValue(ConfigurationKeyConst.APPLICATION_LANGUAGE, appConfigurationResponseCached!.applicationLanguage);
    await setValue(ConfigurationKeyConst.IS_FORCE_UPDATE, appConfigurationResponseCached!.isForceUpdate);
    await setValue(ConfigurationKeyConst.VERSION_CODE, appConfigurationResponseCached!.versionCode);

    if (appConfigurationResponseCached!.currency != null) {
      appStore.setCurrencySymbol(appConfigurationResponseCached!.currency!.currencySymbol.validate());
      appStore.setCurrencyCode(appConfigurationResponseCached!.currency!.currencyCode.validate());
      await setValue(ConfigurationKeyConst.CURRENCY_NAME, appConfigurationResponseCached!.currency!.currencyName);
      await setValue(ConfigurationKeyConst.CURRENCY_SYMBOL, appConfigurationResponseCached!.currency!.currencySymbol);
      await setValue(ConfigurationKeyConst.CURRENCY_CODE, appConfigurationResponseCached!.currency!.currencyCode);
      await setValue(ConfigurationKeyConst.CURRENCY_POSITION, appConfigurationResponseCached!.currency!.currencyPosition);
      await setValue(ConfigurationKeyConst.NO_OF_DECIMAL, appConfigurationResponseCached!.currency!.noOfDecimal);
      await setValue(ConfigurationKeyConst.THOUSAND_SEPARATOR, appConfigurationResponseCached!.currency!.thousandSeparator);
      await setValue(ConfigurationKeyConst.DECIMAL_SEPARATOR, appConfigurationResponseCached!.currency!.decimalSeparator);
    }

    return appConfigurationResponseCached!;
  } catch (e) {
    log(e);
    throw e;
  }
}
//endregion

//region FlutterWave Verify Transaction API
Future<VerifyTransactionResponse> verifyPayment({required String transactionId, required String flutterWaveSecretKey}) async {
  return VerifyTransactionResponse.fromJson(
    await handleResponse(
      await buildHttpResponse("https://api.flutterwave.com/v3/transactions/$transactionId/verify", extraKeys: {
        'isFlutterWave': true,
        'flutterWaveSecretKey': flutterWaveSecretKey,
      }),
      isFlutterWave: true,
    ),
  );
}
//endregion

//region Sadad Payment Api
Future<String> sadadLogin(Map request) async {
  try {
    var res = await handleSadadResponse(
      await buildHttpResponse(
        '${getStringAsync(PaymentKeys.SADAD_DOMAIN)}/api/userbusinesses/login',
        method: HttpMethodType.POST,
        request: request,
        header: buildHeaderForSadad(),
      ),
    );

    return res['accessToken'];
  } catch (e) {
    throw errorSomethingWentWrong;
  }
}

Future sadadCreateInvoice({required Map<String, dynamic> request, required String sadadToken}) async {
  return await handleSadadResponse(await buildHttpResponse(
    '${getStringAsync(PaymentKeys.SADAD_DOMAIN)}/api/invoices/createInvoice',
    method: HttpMethodType.POST,
    request: request,
    header: buildHeaderForSadad(sadadToken: sadadToken),
  ));
}
//endregion
