class ConfigurationResponse {
  String? appName;
  String? appleLoginStatus;
  String? applicationLanguage;
  String? copyright;
  Currency? currency;
  String? customerAppAppStore;
  String? customerAppPlayStore;
  String? footerText;
  String? googleLoginStatus;
  String? googleMapsKey;
  String? helplineNumber;
  String? inquiryEmail;
  OnesignalModel? onesignalCustomerApp;
  String? otpLoginStatus;
  String? primaryColor;
  String? siteDescription;
  int? isForceUpdate;
  int? versionCode;
  CinetPay? cinetPay;
  SadadPay? sadadPay;
  AirtelMoneyPay? airtelMoneyPay;
  PhonePayPay? phonePayPay;
  MidtransPay? midtransPay;
  RazorPay? razorPay;
  StripePay? stripePay;
  PayStackPay? payStackPay;
  PaypalPay? paypalPay;
  FlutterWavePay? flutterWavePay;
  bool? status;
  bool isUserAuthorized;

  ConfigurationResponse({
    this.appName,
    this.appleLoginStatus,
    this.applicationLanguage,
    this.copyright,
    this.currency,
    this.customerAppAppStore,
    this.customerAppPlayStore,
    this.footerText,
    this.googleLoginStatus,
    this.googleMapsKey,
    this.helplineNumber,
    this.inquiryEmail,
    this.onesignalCustomerApp,
    this.otpLoginStatus,
    this.primaryColor,
    this.siteDescription,
    this.isForceUpdate,
    this.versionCode,
    this.status,
    this.cinetPay,
    this.sadadPay,
    this.airtelMoneyPay,
    this.phonePayPay,
    this.midtransPay,
    this.razorPay,
    this.stripePay,
    this.payStackPay,
    this.paypalPay,
    this.flutterWavePay,
    this.isUserAuthorized = false,
  });

  factory ConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return ConfigurationResponse(
      cinetPay: json["cinet_pay"] == null ? null : CinetPay.fromJson(json["cinet_pay"]),
      sadadPay: json["sadad_pay"] == null ? null : SadadPay.fromJson(json["sadad_pay"]),
      airtelMoneyPay: json["airtelmoney_pay"] == null ? null : AirtelMoneyPay.fromJson(json["airtelmoney_pay"]),
      phonePayPay: json["phonepay_pay"] == null ? null : PhonePayPay.fromJson(json["phonepay_pay"]),
      midtransPay: json["midtrans_pay"] == null ? null : MidtransPay.fromJson(json["midtrans_pay"]),
      razorPay: json["razor_pay"] == null ? null : RazorPay.fromJson(json["razor_pay"]),
      stripePay: json["stripe_pay"] == null ? null : StripePay.fromJson(json["stripe_pay"]),
      payStackPay: json["paystack_pay"] == null ? null : PayStackPay.fromJson(json["paystack_pay"]),
      paypalPay: json["paypal_pay"] == null ? null : PaypalPay.fromJson(json["paypal_pay"]),
      flutterWavePay: json["flutterwave_pay"] == null ? null : FlutterWavePay.fromJson(json["flutterwave_pay"]),
      appName: json['app_name'],
      appleLoginStatus: json['apple_login_status'],
      applicationLanguage: json['application_language'],
      copyright: json['copyright'],
      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      customerAppAppStore: json['customer_app_app_store'],
      customerAppPlayStore: json['customer_app_play_store'],
      footerText: json['footer_text'],
      googleLoginStatus: json['google_login_status'],
      googleMapsKey: json['google_maps_key'],
      helplineNumber: json['helpline_number'],
      inquiryEmail: json['inquriy_email'],
      onesignalCustomerApp: json['onesignal_customer_app'] != null ? OnesignalModel.fromJson(json['onesignal_customer_app']) : null,
      otpLoginStatus: json['otp_login_status'],
      primaryColor: json['primary'],
      siteDescription: json['site_description'],
      isForceUpdate: json['isForceUpdate'],
      versionCode: json['version_code'],
      status: json["status"],
      isUserAuthorized: json["is_user_authorized"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["cinet_pay"] = this.cinetPay;
    data["sadad_pay"] = this.sadadPay;
    data["airtelmoney_pay"] = airtelMoneyPay;
    data["phonepay_pay"] = this.phonePayPay;
    data["midtrans_pay"] = midtransPay;
    data["razor_pay"] = razorPay;
    data["stripe_pay"] = stripePay;
    data["paystack_pay"] = payStackPay;
    data["paypal_pay"] = paypalPay;
    data["flutterwave_pay"] = flutterWavePay;
    data['app_name'] = this.appName;
    data['apple_login_status'] = this.appleLoginStatus;
    data['application_language'] = this.applicationLanguage;
    data['copyright'] = this.copyright;
    data['customer_app_app_store'] = this.customerAppAppStore;
    data['customer_app_play_store'] = this.customerAppPlayStore;
    data['footer_text'] = this.footerText;
    data['google_login_status'] = this.googleLoginStatus;
    data['google_maps_key'] = this.googleMapsKey;
    data['helpline_number'] = this.helplineNumber;
    data['inquriy_email'] = this.inquiryEmail;
    data['otp_login_status'] = this.otpLoginStatus;
    data['primary'] = this.primaryColor;
    data['site_description'] = this.siteDescription;
    data['isForceUpdate'] = this.isForceUpdate;
    data['version_code'] = this.versionCode;
    data["status"] = this.status;
    data["is_user_authorized"] = this.isUserAuthorized;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.onesignalCustomerApp != null) {
      data['onesignal_customer_app'] = this.onesignalCustomerApp!.toJson();
    }
    return data;
  }
}

class Currency {
  String? currencyCode;
  String? currencyName;
  String? currencyPosition;
  String? currencySymbol;
  String? decimalSeparator;
  int? noOfDecimal;
  String? thousandSeparator;

  Currency({this.currencyCode, this.currencyName, this.currencyPosition, this.currencySymbol, this.decimalSeparator, this.noOfDecimal, this.thousandSeparator});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyCode: json['currency_code'],
      currencyName: json['currency_name'],
      currencyPosition: json['currency_position'],
      currencySymbol: json['currency_symbol'],
      decimalSeparator: json['decimal_separator'],
      noOfDecimal: json['no_of_decimal'],
      thousandSeparator: json['thousand_separator'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_code'] = this.currencyCode;
    data['currency_name'] = this.currencyName;
    data['currency_position'] = this.currencyPosition;
    data['currency_symbol'] = this.currencySymbol;
    data['decimal_separator'] = this.decimalSeparator;
    data['no_of_decimal'] = this.noOfDecimal;
    data['thousand_separator'] = this.thousandSeparator;
    return data;
  }
}

class OnesignalModel {
  String? onesignalAppId;
  String? onesignalChannelId;
  String? onesignalRestApiKey;

  OnesignalModel({this.onesignalAppId, this.onesignalChannelId, this.onesignalRestApiKey});

  factory OnesignalModel.fromJson(Map<String, dynamic> json) {
    return OnesignalModel(
      onesignalAppId: json['onesignal_app_id'],
      onesignalChannelId: json['onesignal_channel_id'],
      onesignalRestApiKey: json['onesignal_rest_api_key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onesignal_app_id'] = this.onesignalAppId;
    data['onesignal_channel_id'] = this.onesignalChannelId;
    data['onesignal_rest_api_key'] = this.onesignalRestApiKey;
    return data;
  }
}

class AirtelMoneyPay {
  String? airtelMoneyClientId;
  String? airtelMoneySecretKey;
  String? airtelMoneyIsInProduction;

  AirtelMoneyPay({
    this.airtelMoneyClientId,
    this.airtelMoneySecretKey,
    this.airtelMoneyIsInProduction,
  });

  factory AirtelMoneyPay.fromJson(Map<String, dynamic> json) => AirtelMoneyPay(
        airtelMoneyClientId: json["airtelmoney_clientid"],
        airtelMoneySecretKey: json["airtelmoney_secretkey"],
        airtelMoneyIsInProduction: json["airtelmoney_is_status"],
      );

  Map<String, dynamic> toJson() => {
        "airtelmoney_clientid": airtelMoneyClientId,
        "airtelmoney_secretkey": airtelMoneySecretKey,
        "airtelmoney_is_status": airtelMoneyIsInProduction,
      };
}

class CinetPay {
  String? cinetClientId;
  String? cinetApiKey;
  String? cinetSecretkey;
  String? cinetSiteID;

  CinetPay({this.cinetClientId, this.cinetApiKey, this.cinetSecretkey, this.cinetSiteID});

  factory CinetPay.fromJson(Map<String, dynamic> json) => CinetPay(
        cinetClientId: json["cinet_clientid"],
        cinetApiKey: json["cinet_apikey"],
        cinetSecretkey: json["cinet_secretkey"],
        cinetSiteID: json["cinet_site_id"],
      );

  Map<String, dynamic> toJson() => {
        "cinet_clientid": cinetClientId,
        "cinet_apikey": cinetApiKey,
        "cinet_secretkey": cinetSecretkey,
        "cinet_site_id": cinetSiteID,
      };
}

class FlutterWavePay {
  String? flutterWaveSecretKey;
  String? flutterWavePublicKey;

  FlutterWavePay({
    this.flutterWaveSecretKey,
    this.flutterWavePublicKey,
  });

  factory FlutterWavePay.fromJson(Map<String, dynamic> json) => FlutterWavePay(
        flutterWaveSecretKey: json["flutterwave_secretkey"],
        flutterWavePublicKey: json["flutterwave_publickey"],
      );

  Map<String, dynamic> toJson() => {
        "flutterwave_secretkey": flutterWaveSecretKey,
        "flutterwave_publickey": flutterWavePublicKey,
      };
}

class MidtransPay {
  String? midtransClientId;
  String? midtranceIsInProduction;

  MidtransPay({
    this.midtransClientId,
    this.midtranceIsInProduction,
  });

  factory MidtransPay.fromJson(Map<String, dynamic> json) => MidtransPay(
        midtransClientId: json["midtrans_clientid"],
        midtranceIsInProduction: json["midtrans_is_status"],
      );

  Map<String, dynamic> toJson() => {
        "midtrans_clientid": midtransClientId,
        "midtrans_is_status": midtranceIsInProduction,
      };
}

class PaypalPay {
  String? paypalSecretKey;
  String? paypalClientId;

  PaypalPay({
    this.paypalSecretKey,
    this.paypalClientId,
  });

  factory PaypalPay.fromJson(Map<String, dynamic> json) => PaypalPay(
        paypalSecretKey: json["paypal_secretkey"],
        paypalClientId: json["paypal_clientid"],
      );

  Map<String, dynamic> toJson() => {
        "paypal_secretkey": paypalSecretKey,
        "paypal_clientid": paypalClientId,
      };
}

class PayStackPay {
  String? payStackSecretKey;
  String? payStackPublicKey;

  PayStackPay({
    this.payStackSecretKey,
    this.payStackPublicKey,
  });

  factory PayStackPay.fromJson(Map<String, dynamic> json) => PayStackPay(
        payStackSecretKey: json["paystack_secretkey"],
        payStackPublicKey: json["paystack_publickey"],
      );

  Map<String, dynamic> toJson() => {
        "paystack_secretkey": payStackSecretKey,
        "paystack_publickey": payStackPublicKey,
      };
}

class PhonePayPay {
  String? phonePayAppId;
  String? phonePayMerchantId;
  String? phonePaySaltId;
  String? phonePaySaltKey;
  String? phonePayIsInProduction;

  PhonePayPay({
    this.phonePayAppId,
    this.phonePayMerchantId,
    this.phonePaySaltId,
    this.phonePaySaltKey,
    this.phonePayIsInProduction,
  });

  factory PhonePayPay.fromJson(Map<String, dynamic> json) => PhonePayPay(
        phonePayAppId: json["phonepay_appid"],
        phonePayMerchantId: json["phonepay_merchentid"],
        phonePaySaltId: json["phonepay_saltid"],
        phonePaySaltKey: json["phonepay_saltkey"],
        phonePayIsInProduction: json["phonepay_is_status"],
      );

  Map<String, dynamic> toJson() => {"phonepay_appid": phonePayAppId, "phonepay_merchentid": phonePayMerchantId, "phonepay_saltid": phonePaySaltId, "phonepay_saltkey": phonePaySaltKey, "phonepay_is_status": phonePayIsInProduction};
}

class RazorPay {
  String? razorpaySecretKey;
  String? razorpayPublicKey;

  RazorPay({
    this.razorpaySecretKey,
    this.razorpayPublicKey,
  });

  factory RazorPay.fromJson(Map<String, dynamic> json) => RazorPay(
        razorpaySecretKey: json["razorpay_secretkey"],
        razorpayPublicKey: json["razorpay_publickey"],
      );

  Map<String, dynamic> toJson() => {
        "razorpay_secretkey": razorpaySecretKey,
        "razorpay_publickey": razorpayPublicKey,
      };
}

class SadadPay {
  String? sadadClientId;
  String? sadadSecretKey;
  String? sadadDomain;

  SadadPay({
    this.sadadClientId,
    this.sadadSecretKey,
    this.sadadDomain,
  });

  factory SadadPay.fromJson(Map<String, dynamic> json) => SadadPay(
        sadadClientId: json["sadad_clientid"],
        sadadSecretKey: json["sadad_secretkey"],
        sadadDomain: json["sadad_domain"],
      );

  Map<String, dynamic> toJson() => {
        "sadad_clientid": sadadClientId,
        "sadad_secretkey": sadadSecretKey,
        "sadad_domain": sadadDomain,
      };
}

class StripePay {
  String? stripeSecretKey;
  String? stripePublicKey;

  StripePay({
    this.stripeSecretKey,
    this.stripePublicKey,
  });

  factory StripePay.fromJson(Map<String, dynamic> json) => StripePay(
        stripeSecretKey: json["stripe_secretkey"],
        stripePublicKey: json["stripe_publickey"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_secretkey": stripeSecretKey,
        "stripe_publickey": stripePublicKey,
      };
}
