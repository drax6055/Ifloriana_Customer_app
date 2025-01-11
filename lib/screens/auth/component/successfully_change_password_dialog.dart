import 'package:flutter/material.dart';
import 'package:ifloriana/screens/dashboard/view/dashboard_screen.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class SuccessfullyChangePasswordDialog extends StatefulWidget {
  @override
  _SuccessfullyChangePasswordDialogState createState() => _SuccessfullyChangePasswordDialogState();
}

class _SuccessfullyChangePasswordDialogState extends State<SuccessfullyChangePasswordDialog> {
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 45 + 16, right: 16, bottom: 16),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(locale.yourPassWorResetSuccessfully, style: boldTextStyle(size: LABEL_TEXT_SIZE, color: context.primaryColor), textAlign: TextAlign.center),
                16.height,
                Text(
                  locale.yourAccountIsReady,
                  style: secondaryTextStyle(size: 14),
                  textAlign: TextAlign.center,
                ).center(),
                24.height,
                AppButton(
                  child: Text(locale.done, style: boldTextStyle(color: white)),
                  color: context.primaryColor,
                  width: context.width(),
                  onTap: () {
                    DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
                16.height,
              ],
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: boxDecorationDefault(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(spreadRadius: 0, blurRadius: 0, blurStyle: BlurStyle.normal, offset: Offset(0.1, 0.5), color: Colors.grey.shade500),
                ],
              ),
              child: Image.asset(ic_confetti_ball, fit: BoxFit.cover, height: 50),
            ),
          ),
        ],
      ),
    );
  }
}
