import 'package:flutter/material.dart';
import 'package:ifloriana/app_theme.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/new_update_dialog.dart';
import '../main.dart';
import '../screens/auth/view/sign_in_screen.dart';
import '../screens/product/product_repository.dart';
import '../screens/product/view/product_detail_screen.dart';
import '../screens/product/view/product_wish_list_screen.dart';
import 'colors.dart';
import 'constants.dart';
import 'images.dart';
import 'model_keys.dart';

ThemeMode get appThemeMode => appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light;

bool get isRTL => RTL_LanguageS.contains(appStore.selectedLanguageCode);

bool get isLoginTypeUser => userStore.loginType == LoginTypeConst.LOGIN_TYPE_USER;

bool get isLoginTypeGoogle => userStore.loginType == LoginTypeConst.LOGIN_TYPE_GOOGLE;

bool get isLoginTypeApple => userStore.loginType == LoginTypeConst.LOGIN_TYPE_APPLE;

bool get isSocialLoginType => userStore.loginType == LoginTypeConst.LOGIN_TYPE_APPLE || userStore.loginType == LoginTypeConst.LOGIN_TYPE_GOOGLE;

String formatDate(String? dateTime, {String format = DateFormatConst.DATE_FORMAT_1, bool isFromMicrosecondsSinceEpoch = false, bool isLanguageNeeded = true}) {
  final languageCode = isLanguageNeeded ? appStore.selectedLanguageCode : null;
  final parsedDateTime = isFromMicrosecondsSinceEpoch ? DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000) : DateTime.parse(dateTime.validate());

  return DateFormat(format, languageCode).format(parsedDateTime);
}

String formatOnlyTime(BuildContext context, {String? startTime, String? endTime}) {
  if (startTime != null && endTime == null) {
    return '${TimeOfDay(hour: startTime.validate().split(':')[0].toInt(), minute: startTime.validate().split(':')[1].toInt()).format(context)}';
  } else if (endTime != null && startTime == null) {
    return '${TimeOfDay(hour: endTime.validate().split(':')[0].toInt(), minute: endTime.validate().split(':')[1].toInt()).format(context)}';
  } else {
    return '${TimeOfDay(hour: startTime.validate().split(':')[0].toInt(), minute: startTime.validate().split(':')[1].toInt()).format(context)} - ${TimeOfDay(hour: endTime.validate().split(':')[0].toInt(), minute: endTime.validate().split(':')[1].toInt()).format(context)}';
  }
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: ic_us),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: ic_india),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: ic_ar),
    LanguageDataModel(id: 4, name: 'French', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: ic_fr),
    LanguageDataModel(id: 5, name: 'German', languageCode: 'de', fullLanguageCode: 'de-DE', flag: ic_de),
    LanguageDataModel(id: 6, name: 'Spanish', languageCode: 'es', fullLanguageCode: 'es-ES', flag: ic_es),
  ];
}

String getOrderBookingStatus({required String status}) {
  if (status.toLowerCase().contains(OrderStatusConst.ORDER_PLACED)) {
    return locale.orderPlaced;
  } else if (status.toLowerCase().contains(OrderStatusConst.PENDING)) {
    return locale.pending;
  } else if (status.toLowerCase().contains(OrderStatusConst.PROCESSING)) {
    return locale.processing;
  } else if (status.toLowerCase().contains(OrderStatusConst.DELIVERED)) {
    return locale.delivered;
  } else if (status.toLowerCase().contains(OrderStatusConst.CANCELLED)) {
    return locale.cancelled;
  } else {
    return "";
  }
}

String getBookingStatusKey({required String status}) {
  if (status.toLowerCase().contains(BookingStatusConst.COMPLETED)) {
    return locale.completed;
  } else if (status.toLowerCase().contains(BookingStatusConst.CONFIRMED)) {
    return locale.confirmed;
  } else if (status.toLowerCase().contains(BookingStatusConst.CANCELLED)) {
    return locale.cancelled;
  } else if (status.toLowerCase().contains(BookingStatusConst.CHECK_IN)) {
    return locale.checkIn;
  } else if (status.toLowerCase().contains(BookingStatusConst.CHECKOUT)) {
    return locale.checkOut;
  } else if (status.toLowerCase().contains(BookingStatusConst.PENDING)) {
    return locale.pending;
  } else {
    return "";
  }
}

Color getBookingStatusColor({required String status}) {
  if (status.toLowerCase().contains(BookingStatusConst.COMPLETED)) {
    return Colors.lightGreen;
  } else if (status.toLowerCase().contains(BookingStatusConst.CONFIRMED)) {
    return Colors.green;
  } else if (status.toLowerCase().contains(BookingStatusConst.CANCELLED)) {
    return Colors.red;
  } else if (status.toLowerCase().contains(BookingStatusConst.CHECK_IN)) {
    return Colors.blue;
  } else if (status.toLowerCase().contains(BookingStatusConst.CHECKOUT)) {
    return Colors.blue;
  } else if (status.toLowerCase().contains(BookingStatusConst.PENDING)) {
    return Colors.redAccent;
  } else {
    return Colors.transparent;
  }
}

String getBookingPaymentStatus({required String status}) {
  if (status.toLowerCase().contains(SERVICE_PAYMENT_STATUS_UNPAID)) {
    return locale.unpaid;
  } else if (status.toLowerCase().contains(SERVICE_PAYMENT_STATUS_PAID)) {
    return locale.paid;
  } else {
    return "";
  }
}

InputDecoration inputDecoration(
  BuildContext context, {
  Widget? prefixIcon,
  Widget? prefix,
  String? label,
  TextStyle? labelStyle,
  String? hint,
  Color? fillColor,
  String? counterText,
  double? borderRadius,
  Widget? suffixIcon,
  Widget? suffix,
  String? prefixText,
  Color? defaultBorderColor,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    hintText: hint,
    hintStyle: secondaryTextStyle(),
    labelText: label,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    counterText: counterText,
    prefixIcon: prefixIcon,
    prefix: prefix,
    suffix: suffix,
    prefixText: prefixText,
    suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: defaultBorderColor ?? Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    border: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: defaultBorderColor ?? Colors.transparent, width: 0.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: defaultBorderColor ?? Colors.transparent, width: 0.0),
    ),
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: true,
    fillColor: fillColor ?? context.cardColor,
  );
}

NavigationDestination bottomTab({required Widget iconData, required Widget activeIconData, required String tabName}) {
  return NavigationDestination(
    icon: iconData,
    selectedIcon: activeIconData,
    label: tabName,
  );
}

Color getRatingBarColor(int rating) {
  if (rating == 1 || rating == 2) {
    return ratingBarColor;
  } else if (rating == 3) {
    return Color(0xFFff6200);
  } else if (rating == 4 || rating == 5) {
    return Color(0xFF73CB92);
  } else {
    return ratingBarColor;
  }
}

void viewFiles(String url) {
  if (url.isNotEmpty) {
    commonLaunchUrl(url, launchMode: LaunchMode.externalApplication);
  }
}

Future<DateTime?> datePicker(BuildContext context) async {
  DateTime? newDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (_, child) {
      return Theme(
        data: appStore.isDarkMode ? ThemeData.dark(useMaterial3: true) : AppTheme.lightTheme,
        child: child!,
      );
    },
  );

  if (newDate != null) {
    return newDate;
  } else {
    return null;
  }
}

Future<String?> timePicker(BuildContext context) async {
  TimeOfDay? newTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (_, child) {
      return Theme(
        data: appStore.isDarkMode ? ThemeData.dark(useMaterial3: true) : AppTheme.lightTheme,
        child: child!,
      );
    },
  );

  if (newTime != null) {
    DateTime pickerTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, newTime.hour, newTime.minute);
    return DateFormat(DateFormatConst.HOUR_12_FORMAT).format(pickerTime);
  } else {
    return null;
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  var hour, minute;

  List<String> parts = d.toString().split(':');

  if (parts[0].padLeft(2, '0').contains('00')) {
    hour = '';
  } else {
    hour = '${parts[0].padLeft(2, '0')} Hour ';
  }

  if (parts[1].padLeft(2, '0').contains('00')) {
    minute = '';
  } else {
    minute = '${parts[1].padLeft(2, '0')} Minutes';
  }

  return '$hour$minute';
}

void doIfLoggedIn(BuildContext context, VoidCallback callback) async {
  if (appStore.isLoggedIn) {
    callback.call();
  } else {
    bool? res = await SignInScreen(returnExpected: true).launch(context);

    if (res ?? false) {
      callback.call();
    }
  }
}

bool isTimeBefore(TimeOfDay currentTime, TimeOfDay specifiedTime) {
  final now = DateTime.now();
  final currentTimeDateTime = DateTime(now.year, now.month, now.day, currentTime.hour, currentTime.minute);
  final specifiedTimeDateTime = DateTime(now.year, now.month, now.day, specifiedTime.hour, specifiedTime.minute);

  return currentTimeDateTime.isBefore(specifiedTimeDateTime);
}

bool isTimeAfter(TimeOfDay currentTime, TimeOfDay specifiedTime) {
  final now = DateTime.now();
  final currentTimeDateTime = DateTime(now.year, now.month, now.day, currentTime.hour, currentTime.minute);
  final specifiedTimeDateTime = DateTime(now.year, now.month, now.day, specifiedTime.hour, specifiedTime.minute);

  return currentTimeDateTime.isAfter(specifiedTimeDateTime);
}

void ifNotTester(VoidCallback callback) {
  if (userStore.userEmail != DEFAULT_EMAIL) {
    callback.call();
  } else {
    toast(locale.demoUserCannotBeGrantedForThis);
  }
}

void showNewUpdateDialog(BuildContext context) async {
  showInDialog(
    context,
    contentPadding: EdgeInsets.zero,
    barrierDismissible: !(getIntAsync(ConfigurationKeyConst.IS_FORCE_UPDATE) == 1 ? true : false),
    builder: (_) {
      return NewUpdateDialog();
    },
  );
}

Future<void> showForceUpdateDialog(BuildContext context) async {
  if (getIntAsync(ConfigurationKeyConst.IS_FORCE_UPDATE) == 1) {
    getPackageInfo().then((value) {
      if (isAndroid && getIntAsync(ConfigurationKeyConst.VERSION_CODE) > value.versionCode.validate().toInt()) {
        showNewUpdateDialog(context);
      }
      /*else if (isIOS && remoteConfigDataModel.iOS != null && remoteConfigDataModel.iOS!.versionCode.validate() != value.versionCode.validate()) {
        showNewUpdateDialog(context);
      }*/
    });
  }
}

Future<bool> addToWishList({required int productId}) async {
  Map req = {ProductModelKey.productId: productId};
  return await addWishList(req).then((res) {
    toast(res.message);
    return true;
  }).catchError((error) {
    toast(error.toString());
    return false;
  });
}

Future<bool> removeFromWishList({int? wishListId, int? productId, bool isFromProductDetail = false}) async {
  return await removeWishList(wishListId: wishListId, productId: productId).then((res) {
    if (isFromProductDetail) {
      onProductDetailUpdate.call();
      onWishListUpdate.call();
    } else if (wishListId != null) {
      onWishListUpdate.call();
    } else {
      //
    }
    toast(res.message);
    return true;
  }).catchError((error) {
    toast(error.toString());
    return false;
  });
}
