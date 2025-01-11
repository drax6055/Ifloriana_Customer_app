import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/screens/auth/view/otp_verification_screen.dart';
import 'package:ifloriana/screens/auth/view/sign_up_screen.dart';
import 'package:ifloriana/screens/dashboard/view/dashboard_screen.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OtpLoginAuthService {

  Future loginWithOTP(BuildContext context, {String phoneNumber = "", String? countryCode}) async {
    log("PHONE NUMBER VERIFIED $countryCode$phoneNumber");
    return await auth.verifyPhoneNumber(
      phoneNumber: "$countryCode$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {
        toast(locale.verified);
      },
      verificationFailed: (FirebaseAuthException e) {
        appStore.setLoading(false);
        if (e.code == 'invalid-phone-number') {
          toast(locale.otpInvalidMessage, print: true);
        } else {
          toast(e.toString(), print: true);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        toast(locale.otpInvalidMessage);

        appStore.setLoading(false);

        /// Opens a dialog when the code is sent to the user successfully.
        await OtpVerificationScreen(
          onTap: (otpCode) async {
            if (otpCode != null) {
              AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode);

              await auth.signInWithCredential(credential).then((credentials) async {
                Map<String, dynamic> request = {
                  'username': phoneNumber,
                  'password': phoneNumber,
                  'login_type': LoginTypeConst.LOGIN_TYPE_OTP,
                };
                await loginUser(request, isSocialLogin: true).then((loginResponse) async {
                  if (loginResponse.isUserExist == null) {
                    toast(locale.loginSuccessfully);

                    /// Register

                    if (loginResponse.userData != null) await saveUserData(loginResponse.userData!);

                    if (loginResponse.userData!.status == 0) {
                      toast(locale.pleaseContactWithAdmin);
                    } else {

                      DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                    }
                  } else {
                    ///Not Register
                    toast(locale.confirmOtp);
                    appStore.setLoading(false);
                    finish(context);

                    SignUpScreen(isOTPLogin: true, phoneNumber: phoneNumber, countryCode: countryCode, uid: credentials.user!.uid.validate()).launch(context);
                  }
                }).catchError((e) {
                  appStore.setLoading(false);
                  toast(e.toString(), print: true);
                });
              }).catchError((e) {
                if (e.code.toString() == 'invalid-verification-code') {
                  toast(locale.otpInvalidMessage, print: true);
                } else {
                  toast(e.message.toString(), print: true);
                }
                appStore.setLoading(false);
              });
            }
          },
        ).launch(context);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //
      },
    );
  }
}