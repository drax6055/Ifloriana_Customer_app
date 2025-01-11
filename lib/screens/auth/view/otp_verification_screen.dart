import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifloriana/components/body_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/view/change_password_screen.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class OtpVerificationScreen extends StatefulWidget {
  final Function(String? otpCode)? onTap;

  OtpVerificationScreen({this.onTap});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;

  String otpCode = '';

  void submitOtp() {
    if (otpCode.validate().isNotEmpty) {
      if (otpCode.validate().length >= 6) {
        hideKeyboard(context);
        appStore.setLoading(true);
        widget.onTap!.call(otpCode);
      } else {
        toast(locale.pleaseEnterValidOtp);
      }
    } else {
      toast(locale.pleaseEnterValidOtp);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    startTimeout();
  }

  /// region Start Timer
  void startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
        }
      });
    });
  }

  /// endregion

  /// region FromWidget
  Widget _formWidget() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          OTPTextField(
            pinLength: 4,
            onChanged: (s) {
              otpCode = s;
              log(otpCode);
            },
            onCompleted: (pin) {
              otpCode = pin;
              submitOtp();
            },
          ).center(),
        ],
      ),
    );
  }

  /// endregion

  /// region OnVerify OTP
  Future<void> onVerify() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ChangePasswordScreen().launch(context);
    }
  }

  /// endregion

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.otpVerification, appBarHeight: 70, roundCornerShape: true, showLeadingIcon: true),
      body: Body(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text(locale.checkYourMailAnd, style: secondaryTextStyle(), textAlign: TextAlign.center).center(),
              16.height,
              _formWidget(),
              16.height,
              Text(
                '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}',
                style: boldTextStyle(color: context.primaryColor),
              ).center(),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locale.didNotGetTheOtp, style: secondaryTextStyle()),
                  TextButton(
                    onPressed: () {
                      //
                    },
                    child: Text(locale.resendOtp, style: boldTextStyle(color: primaryColor, decoration: TextDecoration.underline)),
                  ),
                ],
              ).visible(currentSeconds == timerMaxSeconds),
              36.height,
              AppButton(
                child: Text(locale.verify, style: boldTextStyle(color: white)),
                width: context.width(),
                color: secondaryColor,
                onTap: () async {
                  onVerify();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
