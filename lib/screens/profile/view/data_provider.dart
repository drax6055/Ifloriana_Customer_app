import 'package:flutter/cupertino.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs.dart';
import '../../../main.dart';
import '../../../models/about_model.dart';
import '../../../utils/app_common.dart';
import 'about_us_screen.dart';

List<AboutModel> getAboutDataModel({required BuildContext context}) {
  List<AboutModel> aboutList = [];

  aboutList.add(AboutModel(
    title: locale.rateUs,
    icon: ic_star,
    onTap: () async {
      if (isAndroid) {
        if (getStringAsync(APP_PLAY_STORE_URL).isNotEmpty) {
          commonLaunchUrl(getStringAsync(APP_PLAY_STORE_URL), launchMode: LaunchMode.externalApplication);
        } else {
          commonLaunchUrl('${getSocialMediaLink(LinkProvider.PLAY_STORE)}${await getPackageName()}', launchMode: LaunchMode.externalApplication);
        }
      } else if (isIOS) {
        if (getStringAsync(APP_APPSTORE_URL).isNotEmpty) {
          commonLaunchUrl(getStringAsync(APP_APPSTORE_URL), launchMode: LaunchMode.externalApplication);
        }
      }
    },
  ));
  aboutList.add(AboutModel(
    title: locale.share,
    icon: ic_share,
    onTap: () async {
      if (isIOS) {
        Share.share('${locale.share} $APP_NAME ${locale.app}\n\n$appStoreAppBaseURL');
      } else {
        Share.share('${locale.share} $APP_NAME ${locale.app}\n\n$playStoreBaseURL${await getPackageInfo().then((value) => value.packageName.validate())}');
      }
    },
  ));
  aboutList.add(AboutModel(
    title: locale.about,
    icon: ic_about,
    onTap: () {
      AboutScreen().launch(context);
    },
  ));

  return aboutList;
}

List<AboutModel> getHelpList({required BuildContext context}) {
  List<AboutModel> aboutList = [];

  aboutList.add(AboutModel(
    title: locale.privacyPolicy,
    icon: ic_privacy_policy,
    onTap: () {
      commonLaunchUrl(PRIVACY_POLICY_URL, launchMode: LaunchMode.externalApplication);
    },
  ));
  aboutList.add(AboutModel(
    title: locale.termsConditions,
    icon: ic_terms_conditions,
    onTap: () {
      commonLaunchUrl(TERMS_CONDITION_URL, launchMode: LaunchMode.externalApplication);
    },
  ));

  aboutList.add(AboutModel(
    title: locale.helpCenter,
    icon: ic_call,
    onTap: () {
      launchCall(appStore.helplineNumber.validate());
    },
  ));
  return aboutList;
}
