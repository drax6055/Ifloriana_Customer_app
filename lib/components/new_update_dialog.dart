import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_common.dart';
import '../utils/constants.dart';
import '../utils/images.dart';

class NewUpdateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: context.width() - 16,
          constraints: BoxConstraints(maxHeight: context.height() * 0.6),
          child: AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            children: [
              60.height,
              Text(locale.newUpdate, style: boldTextStyle(size: 18)),
              8.height,
              Text(locale.anUpdateToIs, style: secondaryTextStyle(), textAlign: TextAlign.left),
              24.height,
              Row(
                children: [
                  AppButton(
                    child: Text(locale.closeApp, style: boldTextStyle(color: primaryColor)),
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius(), side: BorderSide(color: primaryColor)),
                    elevation: 0,
                    onTap: () async {
                      if (getIntAsync(ConfigurationKeyConst.IS_FORCE_UPDATE) == 1) {
                        exit(0);   /// For Close the App
                      } else {
                        finish(context);
                      }
                    },
                  ).expand(),
                  16.width,
                  AppButton(
                    child: Text(locale.update, style: boldTextStyle(color: white)),
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                    color: primaryColor,
                    elevation: 0,
                    onTap: () async {
                      getPackageName().then((value) {
                        String package = '';
                        if (isAndroid) package = value;

                        commonLaunchUrl(
                          '${getSocialMediaLink(LinkProvider.PLAY_STORE)}$package',
                          launchMode: LaunchMode.externalApplication,
                        );

                        if (getIntAsync(ConfigurationKeyConst.IS_FORCE_UPDATE) == 1) {
                          exit(0);
                        } else {
                          finish(context);
                        }
                      });
                    },
                  ).expand(),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 24),
        ),
        Positioned(
          top: -42,
          child: Image.asset(imgForceUpdate, height: 100, width: 100, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
