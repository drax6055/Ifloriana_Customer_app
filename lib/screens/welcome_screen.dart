import 'package:flutter/material.dart';
import 'package:ifloriana/configs.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'auth/view/sign_in_screen.dart';
import 'auth/view/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: Stack(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: context.height() * 0.5,
                  width: context.width(),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: primaryColor,
                    borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                    decorationImage: DecorationImage(image: AssetImage(bg_pattern), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: -70,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: boxDecorationDefault(shape: BoxShape.circle),
                    child: Image.asset(app_logo, height: 134, width: 134, fit: BoxFit.cover),
                  ).center(),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text('${locale.welcomeToThe} $APP_NAME', style: boldTextStyle(size: 22), textAlign: TextAlign.center),
                  16.height,
                  Text('${locale.weProvideYouBestServiceMessage} \n ${locale.userExperience}', style: secondaryTextStyle(), textAlign: TextAlign.center),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        child: Text(locale.signIn, style: boldTextStyle()),
                        elevation: 0,
                        width: 150,
                        onTap: () async {
                          SignInScreen().launch(context);
                        },
                      ),
                      16.width,
                      AppButton(
                        child: Text(locale.createAccount, style: boldTextStyle(color: white)),
                        elevation: 0,
                        color: secondaryColor,
                        width: 150,
                        onTap: () async {
                          SignUpScreen().launch(context);
                        },
                      ),
                    ],
                  ),
                  16.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
