import 'package:flutter/cupertino.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs.dart';
import '../../../main.dart';
import '../../../models/about_model.dart';
import '../../../models/configuration_response.dart';
import '../../../network/rest_apis.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
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
Future<List<Pages>> fetchPagesData() async {
  try {
    // Ensure `getAppConfigurations` is called to populate the cache
    ConfigurationResponse configResponse = await getAppConfigurations();

    // Return the pages data from the cached response
    return configResponse.pages;
  } catch (e) {
    log("Error fetching pages data: $e");
    return []; // Return an empty list if an error occurs
  }
}


// List<AboutModel> getHelpList({required BuildContext context}) {
//   List<AboutModel> aboutList = [];
//
//   aboutList.add(
//       AboutModel(
//     title: locale.privacyPolicy,
//     icon: ic_privacy_policy,
//     onTap: () {
//       checkIfLink(context, getStringAsync(ConfigurationKeyConst.PRIVACY_POLICY), title: locale.privacyPolicy);
//     },
//   ));
//   aboutList.add(AboutModel(
//     title: locale.termsConditions,
//     icon: ic_terms_conditions,
//     onTap: () {
//       checkIfLink(context, getStringAsync(ConfigurationKeyConst.TERMS_CONDITION), title: locale.termsConditions);
//     },
//   ));
//
//   aboutList.add(AboutModel(
//     title: "FAQs",
//     icon: ic_faq,
//     onTap: () {
//       checkIfLink(context, getStringAsync(ConfigurationKeyConst.FAQ), title: "FAQs");
//     },
//   ));
//
//   aboutList.add(AboutModel(
//     title: locale.helpCenter,
//     icon: ic_call,
//     onTap: () {
//       launchCall(appStore.helplineNumber.validate());
//     },
//   ));
//   return aboutList;
// }
Future<List<AboutModel>> getHelpList({required BuildContext context}) async {
  try {
    // Fetch Pages data using fetchPagesData
    List<Pages> pagesData = await fetchPagesData();
    return pagesData.map<AboutModel>((page) {
      print(page.title);

      // Define the icon based on the title match
      String icon;

      if (page.title == locale.privacyPolicy) {
        icon = ic_privacy_policy; // Assign the String path
      } else if (page.title == locale.termsConditions) {
        icon = ic_terms_conditions;
      } else if (page.title == locale.FAQs) {
        icon = ic_faq;
      } else if (page.title == locale.helpCenter) {
        icon = ic_call;
      } else {
        icon = ic_default; // Provide a default path
      }

      return AboutModel(
        title: page.title.validate(), // Use the title from Pages
        icon: icon, // Assign the matched icon
        onTap: () {
          checkIfLink(context, page.description.validate(), title: page.title.validate());
        },
      );
    }).toList();

  } catch (e) {
    log("Error creating help list: $e");
    return [];
  }
}

