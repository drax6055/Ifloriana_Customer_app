import 'package:country_picker/country_picker.dart';

const APP_NAME = 'IFloriana';
const DEFAULT_LANGUAGE = 'en';

const DOMAIN_URL = 'https://ifloriana.iflorainfo.com';

const BASE_URL = '$DOMAIN_URL/api/';
const appStoreAppBaseURL = 'https://apps.apple.com/us/app/frezka-beauty-salons/id6450424262';

const APP_PLAY_STORE_URL = '';
const APP_APPSTORE_URL = '';

const TERMS_CONDITION_URL = 'https://iqonic.design/terms-of-use';
const PRIVACY_POLICY_URL = 'https://iqonic.design/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'demo@gmail.com';
const DASHBOARD_AUTO_SLIDER_SECOND = 5;

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+15265897485';
const STRIPE_CURRENCY_CODE = "INR";
const IS_USER_AUTHORIZED = 'IS_USER_AUTHORIZED';

Country defaultCountry() {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '23456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+919123456789',
  );

}
  