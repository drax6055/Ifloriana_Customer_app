import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs.dart';
import '../main.dart';
import '../utils/app_common.dart';

class CommonAppDialog extends StatefulWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? buttonText;
  final Function? onTap;
  final bool isQuickBooking;
  final bool isBooking;

  CommonAppDialog({this.icon, this.title, this.subTitle, this.buttonText, this.onTap, this.isQuickBooking = false, this.isBooking = false});

  @override
  _CommonAppDialogState createState() => _CommonAppDialogState();
}

class _CommonAppDialogState extends State<CommonAppDialog> {
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(shape: BoxShape.rectangle, color: context.cardColor, borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(child: Image.asset(widget.icon ?? ic_confetti_ball, fit: BoxFit.cover, height: 50), backgroundColor: indicatorColor, radius: 50),
              16.height,
              Text(widget.title.validate(), style: boldTextStyle(size: LABEL_TEXT_SIZE), textAlign: TextAlign.center),
              16.height,
              Text(widget.subTitle.validate(), style: secondaryTextStyle(size: 14), textAlign: TextAlign.center).center(),
              if (widget.isBooking) 16.height,
              if (widget.isBooking)
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
                          text: locale.termsConditions + ".",
                          style: secondaryTextStyle(color: secondaryColor, size: 15, weight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = handleClick,
                        ),
                      ],
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              24.height,
              if (widget.isQuickBooking)
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
                        child: Text(widget.buttonText.validate(), style: boldTextStyle(color: white)),
                        color: secondaryColor,
                        width: context.width(),
                        onTap: () {
                          if (isSelected) {
                            log("is true");
                            finish(context, true);
                            widget.onTap?.call();
                          } else {
                            toast(locale.pleaseAcceptTermsAndConditions);
                          }
                        }).expand(),
                  ],
                )
              else
                AppButton(
                  child: Text(widget.buttonText.validate(), style: boldTextStyle(color: white)),
                  color: secondaryColor,
                  width: context.width(),
                  onTap: widget.onTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
