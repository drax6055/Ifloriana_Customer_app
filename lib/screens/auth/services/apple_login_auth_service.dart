import 'dart:convert';

import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AppleLoginAuthService {
  Future<void> appleSignIn() async {
    if (await TheAppleSignIn.isAvailable()) {
      AuthorizationResult result = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
          );

          final authResult = await auth.signInWithCredential(credential);
          final user = authResult.user!;

          log('User:- $user');
          print('result :- ${result.credential!.email}');
          if (result.credential!.email != null) {
            appStore.setLoading(true);

            await saveAppleData(result).then((value) {
              appStore.setLoading(false);
            }).catchError((e) {
              appStore.setLoading(false);
              throw e;
            });
          }
          await setValue(SharedPreferenceConst.APPLE_UID, user.uid.validate());

          await saveAppleDataWithoutEmail(user).then((value) {
            appStore.setLoading(false);
          }).catchError((e) {
            appStore.setLoading(false);
            throw e;
          });

          break;
        case AuthorizationStatus.error:
          throw ("${locale.signInFailed}: ${result.error!.localizedDescription}");
        case AuthorizationStatus.cancelled:
          throw (locale.userCancelled);
      }
    } else {
      throw locale.appleSigInIsNotAvailable;
    }
  }

  Future<void> saveAppleData(AuthorizationResult result) async {

    await setValue(SharedPreferenceConst.APPLE_EMAIL, result.credential!.email);
    await setValue(SharedPreferenceConst.APPLE_GIVE_NAME, result.credential!.fullName!.givenName);
    await setValue(SharedPreferenceConst.APPLE_FAMILY_NAME, result.credential!.fullName!.familyName);
  }

  Future<void> saveAppleDataWithoutEmail(User user) async {
    log('UID: ${getStringAsync(SharedPreferenceConst.APPLE_UID)}');
    log('Email:- ${getStringAsync(SharedPreferenceConst.APPLE_EMAIL)}');
    log('appleGivenName:- ${getStringAsync(SharedPreferenceConst.APPLE_GIVE_NAME)}');
    log('appleFamilyName:- ${getStringAsync(SharedPreferenceConst.APPLE_FAMILY_NAME)}');

    var req = {
      'email': getStringAsync(SharedPreferenceConst.APPLE_EMAIL).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_EMAIL) : getStringAsync(SharedPreferenceConst.APPLE_UID) + '@gmail.com',
      'first_name':getStringAsync(SharedPreferenceConst.APPLE_GIVE_NAME).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_GIVE_NAME) : '',
      'last_name':  getStringAsync(SharedPreferenceConst.APPLE_FAMILY_NAME).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_FAMILY_NAME) : '',
      "username": getStringAsync(SharedPreferenceConst.APPLE_EMAIL).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_EMAIL) : getStringAsync(SharedPreferenceConst.APPLE_UID) + '@gmail.com',
      "profile_image": '',
      "social_image": '',
      'accessToken': '12345678',
      'login_type': LoginTypeConst.LOGIN_TYPE_APPLE,
      "user_type": LoginTypeConst.LOGIN_TYPE_USER,
    };

    log("Apple Login Json" + jsonEncode(req));

    if (!getStringAsync(SharedPreferenceConst.APPLE_EMAIL).isEmptyOrNull) {
      await loginUser(req, isSocialLogin: true).then((value) async {
        //
      }).catchError((e) {
        log(e.toString());
        throw e;
      });
    } else {
      throw locale.emailAddressIsRequiredUpdateAppleAccount;
    }
  }
}
