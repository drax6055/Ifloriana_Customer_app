import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:ifloriana/components/back_widget.dart';
import 'package:ifloriana/components/html_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs.dart';
import 'common_base.dart';

Future<bool> get isIqonicProduct  async => await getPackageName() == appPackageName;

// Currency position common
bool get isCurrencyPositionLeft => getStringAsync(SharedPreferenceConst.CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_LEFT;

bool get isCurrencyPositionRight => getStringAsync(SharedPreferenceConst.CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_RIGHT;

bool get isCurrencyPositionLeftWithSpace => getStringAsync(SharedPreferenceConst.CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_LEFT_WITH_SPACE;

bool get isCurrencyPositionRightWithSpace => getStringAsync(SharedPreferenceConst.CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_RIGHT_WITH_SPACE;
//endregion

// Firebase Constants
String get appNameTopic => APP_NAME.toLowerCase().replaceAll(' ', '_');
//endregion

Future<void> commonLaunchUrl(String address, {LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).then((value) => null).catchError((e) {
    toast('${locale.invalidUrl}: $address');
  });
}

void launchCall(String? url) {
  if (url.validate().isNotEmpty) {
    if (isIOS)
      commonLaunchUrl('tel://' + url!, launchMode: LaunchMode.externalApplication);
    else
      commonLaunchUrl('tel:' + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMap(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl(GOOGLE_MAP_PREFIX + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMail(String url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('$MAIL_TO$url', launchMode: LaunchMode.externalApplication);
  }
}

void checkIfLink(BuildContext context, String value, {String? title}) {
  if (value.validate().isEmpty) return;

  String temp = parseHtmlString(value.validate());
  if (temp.startsWith("https") || temp.startsWith("http")) {
    launchUrlCustomTab(temp.validate());
  } else if (temp.validateEmail()) {
    launchMail(temp);
  } else if (temp.validatePhone() || temp.startsWith('+')) {
    launchCall(temp);
  } else {
    HtmlWidget(postContent: value, title: title).launch(context);
  }
}

void launchUrlCustomTab(String? url) {
  if (url.validate().isNotEmpty) {
    custom_tabs.launchUrl(
      Uri.parse(url.validate()),
      customTabsOptions: custom_tabs.CustomTabsOptions(
        colorSchemes: custom_tabs.CustomTabsColorSchemes.defaults(toolbarColor: primaryColor),
        animations: custom_tabs.CustomTabsSystemAnimations.slideIn(),
        urlBarHidingEnabled: true,
        shareState: custom_tabs.CustomTabsShareState.on,
        browser: custom_tabs.CustomTabsBrowserConfiguration(
          fallbackCustomTabs: [
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
          headers: {'key': 'value'},
        ),
      ),
      safariVCOptions: custom_tabs.SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: custom_tabs.SafariViewControllerDismissButtonStyle.close,
        entersReaderIfAvailable: false,
        preferredControlTintColor: Colors.white,
        preferredBarTintColor: primaryColor,
      ),
    );
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

PreferredSizeWidget commonAppBarWidget(BuildContext context, {String? title, double? appBarHeight, bool? showLeadingIcon, bool? roundCornerShape, List<Widget>? actions}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight ?? 100.0),
    child: AppBar(
      title: Text(title!, style: boldTextStyle(color: whiteColor, size: APPBAR_TEXT_SIZE)),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      backgroundColor: primaryColor,
      centerTitle: true,
      leading: !showLeadingIcon.validate() ? Offstage() : BackWidget(),
      elevation: 0,
      actions: actions,
      shape: roundCornerShape.validate()
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            )
          : RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
  );
}

double calculateDistance(double startLat, double startLong, double endLat, double endLong) {
  double distance = Geolocator.distanceBetween(
    startLat,
    startLong,
    endLat,
    endLong,
  );

  double distanceInKiloMeters = distance / 1000;
  return double.parse((distanceInKiloMeters).toStringAsFixed(2));
}

(String, Color) getBranchIsOpen({required String startTime, required String endTime, bool isHoliday = false}) {
  if (isHoliday) {
    return (BRANCH_STATUS_CLOSED, Colors.red);
  }

  final currentTime = TimeOfDay.now();
  final branchStartTime = TimeOfDay(hour: int.parse(startTime.split(':')[0]), minute: int.parse(startTime.split(':')[1]));
  final branchEndTime = TimeOfDay(hour: int.parse(endTime.split(':')[0]), minute: int.parse(endTime.split(':')[1]));

  if (isTimeBefore(currentTime, branchStartTime) || isTimeAfter(currentTime, branchEndTime)) {
    return (locale.closed, Colors.red);
  } else {
    return (locale.open, Colors.green);
  }
}


void serviceCommonBottomSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) => child,
  );
}

String formatPackageDates({required DateTime date}) {
  final DateFormat formatter = DateFormat(DateFormatConst.DATE_FORMAT_2);
  DateTime now = DateTime.now();
  Duration difference = date.difference(now);
  if (difference.inDays == 0) {
    return locale.expiringToday;
  } else if (difference.inDays < 7 && difference.inDays >= 0) {
    return '${locale.expiryIn} ${difference.inDays} ${locale.days}';
  } else {
    String formattedDate = formatter.format(date);
    return '${locale.expiryBy} $formattedDate';
  }
}
