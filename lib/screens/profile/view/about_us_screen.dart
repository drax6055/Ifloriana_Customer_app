import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../configs.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.light));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.about,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: AnimatedScrollView(
        crossAxisAlignment: CrossAxisAlignment.center,
        listAnimationType: ListAnimationType.FadeIn,
        padding: EdgeInsets.symmetric(horizontal: 16),
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        children: [
          16.height,
          Text(APP_NAME, style: boldTextStyle(size: 20, color: context.primaryColor)),
          16.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(getStringAsync(ConfigurationKeyConst.SITE_DESCRIPTION), style: primaryTextStyle(), textAlign: TextAlign.justify),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (appStore.helplineNumber.isNotEmpty)
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Image.asset(ic_call, height: 22, color: context.primaryColor),
                      4.height,
                      Text(locale.call, style: secondaryTextStyle(), textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(
                  () {
                    launchCall(appStore.helplineNumber);
                  },
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              if (appStore.inquiryEmail.isNotEmpty)
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Image.asset(ic_message, height: 22, color: primaryColor),
                      4.height,
                      Text(locale.email, style: secondaryTextStyle(), textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(
                  () {
                    launchMail(appStore.inquiryEmail);
                  },
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
            ],
          ),
          25.height,
        ],
      ),
    );
  }
}
