import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ifloriana/configs.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../main.dart';

class ConfirmBookingDialog extends StatefulWidget {
  final String? title;
  final String? subTitle;

  ConfirmBookingDialog({this.title, this.subTitle});

  @override
  _ConfirmBookingDialog createState() => _ConfirmBookingDialog();
}

class _ConfirmBookingDialog extends State<ConfirmBookingDialog> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  handleClick() async {
    commonLaunchUrl(TERMS_CONDITION_URL, launchMode: LaunchMode.externalApplication);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(ic_confirm_check, height: 100, width: 100, color: primaryColor),
            16.height,
            Text(widget.title ?? locale.confirmBooking, style: boldTextStyle(size: 20), textAlign: TextAlign.center),
            16.height,
            Text(widget.subTitle ?? locale.doWantToBookAppointment, style: primaryTextStyle(), textAlign: TextAlign.center).center(),
            16.height,
            CheckboxListTile(
              value: isSelected,
              onChanged: (val) async {
                await setValue(SharedPreferenceConst.IS_SELECTED, isSelected);
                isSelected = !isSelected;
                setState(() {});
              },
              title: RichText(
                text: TextSpan(
                  text: locale.iHaveReadThe.toLowerCase().capitalizeFirstLetter(),
                  style: secondaryTextStyle(),
                  children: [
                    TextSpan(
                      text: locale.termsConditions.toLowerCase()+".",
                      style: secondaryTextStyle(color: secondaryColor),
                      recognizer: TapGestureRecognizer()..onTap = handleClick,
                    ),
                  ],
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            24.height,
            Row(
              children: [
                AppButton(
                  child: Text(locale.cancel, style: boldTextStyle()),
                  color: context.cardColor,
                  width: context.width(),
                  onTap: () {
                    finish(context);
                  },
                ).expand(),
                16.width,
                AppButton(
                  child: Text(locale.confirm, style: boldTextStyle(color: white)),
                  color: secondaryColor,
                  width: context.width(),
                  onTap: () {
                    if (isSelected) {
                      finish(context, true);
                    } else {
                      toast(locale.pleaseAcceptTermsAndConditions);
                    }
                  },
                ).expand(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
