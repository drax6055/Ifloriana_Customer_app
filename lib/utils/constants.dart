/// DO NOT CHANGE THIS PACKAGE NAME
var appPackageName = 'com.iflorainfopvtltd.ifloriana';

const PER_PAGE_ITEM = 25;
const LABEL_TEXT_SIZE = 14;
const ICON_SIZE = 16.0;

const MAIL_TO = 'mailto:';
const TEL = 'tel:';
const GOOGLE_MAP_PREFIX = 'https://www.google.com/maps/search/?api=1&query=';
const MESSAGE = 'message';
const DECIMAL_POINT = 2;
const double CATEGORY_ICON_SIZE = 85;
const DEFAULT_FIREBASE_PASSWORD = '12345678';
const APPBAR_TEXT_SIZE = 18;
const UNSELECTED_BRANCH_ID = -1;
const MARK_AS_READ = 'mark_as_read';
const DEFAULT_SLOT_INTERVAL_DURATION = '00:30';
const NOTIFICATION_TYPE_BOOKING = 'booking';
const IN_CART = 1;
const DEFAULT_QUANTITY = 1;
const SHIPPING_DELIVERY_TYPE_REGULAR = 'regular';
const APP_BAR_TEXT_SIZE = 18;


//region Branch Status
const BRANCH_STATUS_OPEN = 'Open';
const BRANCH_STATUS_CLOSED = 'Closed';

//region default USER login
const DEFAULT_EMAIL = 'john@gmail.com';
const DEFAULT_PASS = '12345678';
//endregion

class TaxType {
  static const FIXED = 'fixed';
  static const PERCENT = 'percent';
}

class PaymentMethods {
  static const PAYMENT_METHOD_CASH = 'cash';
  static const PAYMENT_METHOD_STRIPE = 'stripe';
  static const PAYMENT_METHOD_RAZORPAY = 'razorpay';
  static const PAYMENT_METHOD_PAYPAL = 'paypal';
  static const PAYMENT_METHOD_PAYSTACK = 'paystack';
  static const PAYMENT_METHOD_FLUTTER_WAVE = 'flutterwave';
  static const PAYMENT_METHOD_PAYTM = 'paytm';
  static const AIRTEL_MONEY = 'airtel_money';
  static const CINET = 'cinet';
  static const PAYMENT_METHOD_MIDTRANS = 'midtrans';
  static const PAYMENT_METHOD_SADAD_PAYMENT = 'sadad';
  static const PAYMENT_METHOD_PHONEPE = 'phonepe';
}

class GenderConst {
  static const MALE = 'male';
  static const FEMALE = 'female';
  static const OTHER = 'other';
}

//region SERVICE PAYMENT STATUS
const SERVICE_PAYMENT_STATUS_PAID = 'paid';
const SERVICE_PAYMENT_STATUS_PENDING = 'pending';
const SERVICE_PAYMENT_STATUS_UNPAID = 'unpaid';
//endregion

//region DateFormats
class DateFormatConst {
  static const DATE_FORMAT_1 = 'dd-MMM-yyyy hh:mm a';
  static const NEW_FORMAT = 'yyyy-MM-dd HH:mm';
  static const DATE_FORMAT_2 = 'd MMM, yyyy';
  static const DATE_FORMAT_3 = 'dd-MMM-yyyy';
  static const DATE_FORMAT_4 = 'dd MMM';
  static const DATE_FORMAT_5 = 'yyyy-MM-dd';
  static const BOOK_DATE_FORMAT = 'dd/MM/yyyy';
  static const HOUR_12_FORMAT = 'hh:mm a';
  static const HOUR_24_FORMAT = 'HH:mm';
  static const DATE_FORMAT_HOUR_12 = 'hh:mm a';
  static const YEAR = 'yyyy';
}
//endregion

//region LOGIN TYPE
class LoginTypeConst {
  static const LOGIN_TYPE_USER = 'user';
  static const LOGIN_TYPE_GOOGLE = 'google';
  static const LOGIN_TYPE_APPLE = 'apple';
  static const LOGIN_TYPE_OTP = 'mobile';
}
//endregion

//region BOOKING STATUS
class BookingStatusConst {
  static const COMPLETED = 'completed';
  static const PENDING = 'pending';
  static const CONFIRMED = 'confirmed';
  static const CHECK_IN = 'check_in';
  static const CHECKOUT = 'checkout';
  static const CANCELLED = 'cancelled';
}
//endregion

//region ORDER STATUS
class OrderStatusConst {
  static const ORDER_PLACED = 'order_placed';
  static const PENDING = 'pending';
  static const PROCESSING = 'processing';
  static const DELIVERED = 'delivered';
  static const CANCELLED = 'cancelled';
}
//endregion

// region LIVESTREAM KEYS
class LiveStreamKeyConst {
  static const LIVESTREAM_TOKEN = 'tokenStream';
  static const LIVESTREAM_CHANGE_STEP = 'LIVESTREAM_CHANGE_STEP';
//endregion
}
//endregion

//region CONFIGURATION KEYS
class ConfigurationKeyConst {
  static const CURRENCY_COUNTRY_CODE = 'CURRENCY_COUNTRY_CODE';
  static const CURRENCY_COUNTRY_ID = 'CURRENCY_COUNTRY_ID';
  static const CURRENCY_COUNTRY_SYMBOL = 'CURRENCY_COUNTRY_SYMBOL';
  static const ONESIGNAL_API_KEY = 'ONESIGNAL_API_KEY';
  static const ONESIGNAL_REST_API_KEY = 'ONESIGNAL_REST_API_KEY';
  static const ONESIGNAL_CHANNEL_KEY = 'ONESIGNAL_CHANNEL_KEY';
  static const APP_NAME = 'APP_NAME';
  static const FOOTER_TEXT = 'FOOTER_TEXT';
  static const HELPLINE_NUMBER = 'HELPLINE_NUMBER';
  static const COPYRIGHT = 'COPYRIGHT';
  static const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
  static const SITE_DESCRIPTION = 'SITE_DESCRIPTION';
  static const PRIMARY = 'PRIMARY';
  static const GOOGLE_MAPS_KEY = 'GOOGLE_MAPS_KEY';
  static const CUSTOMER_APP_PLAY_STORE = 'CUSTOMER_APP_PLAY_STORE';
  static const CUSTOMER_APP_APP_STORE = 'CUSTOMER_APP_APP_STORE';
  static const GOOGLE_LOGIN_STATUS = 'GOOGLE_LOGIN_STATUS';
  static const APPLE_LOGIN_STATUS = 'APPLE_LOGIN_STATUS';
  static const OTP_LOGIN_STATUS = 'OTP_LOGIN_STATUS';
  static const APPLICATION_LANGUAGE = 'APPLICATION_LANGUAGE';
  static const CURRENCY_NAME = 'CURRENCY_NAME';
  static const CURRENCY_SYMBOL = 'CURRENCY_SYMBOL';
  static const CURRENCY_CODE = 'CURRENCY_CODE';
  static const CURRENCY_POSITION = 'CURRENCY_POSITION';
  static const NO_OF_DECIMAL = 'NO_OF_DECIMAL';
  static const THOUSAND_SEPARATOR = 'THOUSAND_SEPARATOR';
  static const DECIMAL_SEPARATOR = 'DECIMAL_SEPARATOR';
  static const IS_FORCE_UPDATE = 'IS_FORCE_UPDATE';
  static const VERSION_CODE = 'VERSION_CODE';
  static const TERMS_CONDITION = 'TERMS_CONDITION_URL';
  static const PRIVACY_POLICY = 'PRIVACY_POLICY_URL';
  static const FAQ = 'FAQ_URL';
}
//endregion

// payment const

class PaymentKeys {
  /// cinet pay keys
  static const CINET_CLIENT_ID = 'CINET_CLIENT_ID';
  static const CINET_API_KEY = 'CINET_API_KEY';
  static const CINET_SECRET_KEY = 'CINET_SECRET_KEY';
  static const CINET_SITE_ID = 'CINET_SITE_ID';

  /// sadad pay keys

  static const SADAD_CLIENT_ID = 'SADAD_CLIENT_ID';
  static const SADAD_SECRET_KEY = 'SADAD_SECRET_KEY';
  static const SADAD_DOMAIN = 'SADAD_DOMAIN';

  /// airtel money keys
  static const AIRTEL_MONEY_CLIENT_ID = 'AIRTEL_MONEY_CLIENT_ID0';
  static const AIRTEL_MONEY_SECRET_KEY = 'AIRTEL_MONEY_SECRET_KEY';
  static const AIRTEL_MONEY_IS_IN_PRODUCTION = 'AIRTEL_MONEY_IS_IN_PRODUCTION';
  static const CLIENT_CREDENTIALS = 'client_credentials';

  /// phone pe keys
  static const PHONE_PAY_APP_ID = 'PHONE_PAY_APP_ID';
  static const PHONE_PAY_MERCHANT_ID = 'PHONE_PAY_MERCHANT_ID';
  static const PHONE_PAY_SALT_ID = 'PHONE_PAY_SALT_ID';
  static const PHONE_PAY_SALT_KEY = 'PHONE_PAY_SALT_KEY';
  static const PHONE_PAY_IS_IN_PRODUCTION = 'PHONE_PAY_IS_IN_PRODUCTION';

  /// midtrance keys
  static const MIDTRANS_CLIENT_ID = 'MIDTRANS_CLIENT_ID';
  static const MIDTRANS_IS_IN_PRODUCTION = 'MIDTRANS_IS_IN_PRODUCTION';

  /// razorpay keys
  static const RAZORPAY_SECRET_KEY = 'RAZORPAY_SECRET_KEY';
  static const RAZORPAY_PUBLIC_KEY = 'RAZORPAY_PUBLIC_KEY';

  /// stripe keys
  static const STRIPE_SECRET_KEY = 'STRIPE_SECRET_KEY';
  static const STRIPE_PUBLIC_KEY = 'STRIPE_PUBLIC_KEY';

  /// payStack keys
  static const PAY_STACK_SECRET_KEY = 'PAY_STACK_SECRET_KEY';
  static const PAY_STACK_PUBLIC_KEY = 'PAY_STACK_PUBLIC_KEY';

  /// paypal keys
  static const PAYPAL_SECRET_KEY = 'PAYPAL_SECRET_KEY';
  static const PAYPAL_CLIENT_ID = 'PAYPAL_CLIENT_ID';

  /// flutter wave keys
  static const FLUTTER_WAVE_SECRET_KEY = 'FLUTTER_WAVE_SECRET_KEY';
  static const FLUTTER_WAVE_PUBLIC_KEY = 'FLUTTER_WAVE_PUBLIC_KEY';
}

//region THEME MODE TYPE
class ThemeConst {
  static const THEME_MODE_LIGHT = 0;
  static const THEME_MODE_DARK = 1;
  static const THEME_MODE_SYSTEM = 2;
}

//endregion

//region FireBase Collection Name
const USER_COLLECTION = "users";
//endregion

//region CHAT LANGUAGE
const List<String> RTL_LanguageS = ['ar', 'ur'];
//endregion

//region SharedPreference Keys

class SharedPreferenceConst {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_ID = 'USER_ID';
  static const FIRST_NAME = 'FIRST_NAME';
  static const LAST_NAME = 'LAST_NAME';
  static const USER_EMAIL = 'USER_EMAIL';
  static const TOKEN = 'TOKEN';
  static const AVTAR = 'AVTAR';
  static const LOGIN_TYPE = 'LOGIN_TYPE';
  static const ONESIGNAL_API_KEY = 'ONESIGNAL_API_KEY';
  static const USER_PASSWORD = 'USER_PASSWORD';
  static const CONTACT_NUMBER = 'CONTACT_NUMBER';
  static const GENDER = 'GENDER';
  static const HELPLINE_NUMBER = 'HELPLINE_NUMBER';
  static const IS_SELECTED = 'IS_SELECTED';

  static const USERNAME = 'USERNAME';
  static const PROFILE_IMAGE = 'PROFILE_IMAGE';
  static const IS_REMEMBERED = 'IS_REMEMBERED';
  static const USER_TYPE = 'USER_TYPE';
  static const IS_FIRST_TIME = 'IS_FIRST_TIME';
  static const UID = 'UID';
  static const APPLE_UID = 'APPLE_UID';
  static const APPLE_EMAIL = 'APPLE_EMAIL';
  static const APPLE_GIVE_NAME = 'APPLE_GIVE_NAME';
  static const APPLE_FAMILY_NAME = 'APPLE_FAMILY_NAME';
  static const COUNTRY_ID = 'COUNTRY_ID';
  static const STATE_ID = 'STATE_ID';
  static const CITY_ID = 'CITY_ID';
  static const CURRENCY_POSITION = 'CURRENCY_POSITION';
  static const APPSTORE_URL = 'APPSTORE_URL';
  static const PLAY_STORE_URL = 'PLAY_STORE_URL';
  static const PRIVACY_POLICY = 'PRIVACY_POLICY';
  static const TERM_CONDITIONS = 'TERM_CONDITIONS';
  static const SERVER_LANGUAGES = 'SERVER_LANGUAGES';
  static const SITE_DESCRIPTION = 'SITE_DESCRIPTION';
  static const SITE_COPYRIGHT = 'SITE_COPYRIGHT';
  static const FACEBOOK_URL = 'FACEBOOK_URL';
  static const INSTAGRAM_URL = 'INSTAGRAM_URL';
  static const TWITTER_URL = 'TWITTER_URL';
  static const LINKEDIN_URL = 'LINKEDIN_URL';
  static const YOUTUBE_URL = 'YOUTUBE_URL';
  static const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
  static const BRANCH_ID = 'BRANCH_ID';
  static const BRANCH_CONTACT_NUMBER = 'BRANCH_CONTACT_NUMBER';
  static const BRANCH_ADDRESS = 'BRANCH_ADDRESS';
  static const BRANCH_NAME = 'BRANCH_NAME';
  static const AUTO_SLIDER_STATUS = 'AUTO_SLIDER_STATUS';
}

//endregion

const USER_NOT_CREATED = "User not created";
const USER_CANNOT_LOGIN = "User can't login";
const USER_NOT_FOUND = "User not found";

const ONESIGNAL_TAG_KEY = 'appType';
const ONESIGNAL_TAG_VALUE = 'userApp';

// Currency position
const CURRENCY_POSITION_LEFT = 'left';
const CURRENCY_POSITION_RIGHT = 'right';
const CURRENCY_POSITION_LEFT_WITH_SPACE = 'left_with_space';
const CURRENCY_POSITION_RIGHT_WITH_SPACE = 'right_with_space';
//endregion

//region BOOKING STATUS
const SLIDER_TYPE_CATEGORY = 'category';
const SLIDER_TYPE_SERVICE = 'service';

//endregion
//region Firebase Messaging
class FirebaseMsgConst {
  //region Firebase Notification
  static const additionalDataKey = 'additional_data';
  static const notificationGroupKey = 'notification_group';
  static const idKey = 'id';

  static const shopKey = 'shop';

  static const orderCodeKey = 'order_code';

  static const bookingServicesNameKey = 'booking_services_names';
  static const userWithUnderscoreKey = 'user_';
  static const notificationDataKey = 'Notification Data';
  static const fcmNotificationTokenKey = 'FCM Notification Token';
  static const apnsNotificationTokenKey = 'APNS Notification Token';
  static const notificationErrorKey = 'Notification Error';
  static const notificationTitleKey = 'Notification Title';

  static const notificationKey = 'Notification';

  static const onClickListener = "Error On Notification Click Listener";
  static const onMessageListen = "Error On Message Listen";
  static const onMessageOpened = "Error On Message Opened App";
  static const onGetInitialMessage = 'Error On Get Initial Message';

  static const messageDataCollapseKey = 'MessageData Collapse Key';

  static const messageDataMessageIdKey = 'MessageData Message Id';

  static const messageDataMessageTypeKey = 'MessageData Type';
  static const notificationBodyKey = 'Notification Body';
  static const backgroundChannelIdKey = 'background_channel';
  static const backgroundChannelNameKey = 'background_channel';

  static const notificationChannelIdKey = 'notification';
  static const notificationChannelNameKey = 'Notification';

  static const topicSubscribed = 'topic-----subscribed---->';

  static const topicUnSubscribed = 'topic-----Unsubscribed---->';

  //endregion
  // Notification Click Post type Keys
  static const postTypeKey = 'post_type';
  static const movieKey = 'movie';
  static const tvShowKey = 'tv_show';
  static const episodeKey = 'episode';
  static const videoKey = 'video';

//region
}
//endregion


