import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/screens/auth/model/user_data_model.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService {
  Future<String> setRegisterData({required UserData userData}) async {
    return await userService.addDocumentWithCustomId(userData.uid.validate(), userData.toJson()).then((value) async {
      return value.id.validate();
    }).catchError((e) {
      throw false;
    });
  }

//region Email
  Future<String> signUpWithEmailPassword(BuildContext context, {required UserData userData}) async {
    return await auth.createUserWithEmailAndPassword(email: userData.email.validate(), password: DEFAULT_FIREBASE_PASSWORD).then((userCredential) async {
      User currentUser = userCredential.user!;
      String displayName = userData.firstName.validate() + userData.lastName.validate();

      userData.uid = currentUser.uid.validate();
      userData.email = currentUser.email.validate();
      userData.displayName = displayName;
      userData.createdAt = Timestamp.now().toDate().toString();
      userData.updatedAt = Timestamp.now().toDate().toString();
      userData.loginType = LoginTypeConst.LOGIN_TYPE_USER;

      log("Step 1 ${userData.toJson()}");

      return await setRegisterData(userData: userData);
    }).catchError((e) {
      log(e.toString());
      throw false;
    });
  }

  Future<String> signInWithEmailPassword({required String email, String? uid, bool isSocialLogin = false}) async {
    if (isSocialLogin) {
      return uid.validate();
    }
    return await auth.signInWithEmailAndPassword(email: email, password: DEFAULT_FIREBASE_PASSWORD).then((value) async {
      return value.user!.uid.validate();
    }).catchError((e) async {
      appStore.setLoading(false);
      log(e.toString());
      throw locale.userNotFound;
    });
  }

//endregion

  Future<void> updateUserData(UserData user) async {
    userService.updateDocument(
      {
        'updatedAt': Timestamp.now(),
      },
      user.uid,
    );
  }

// region Apple Sign
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
      'first_name': getStringAsync(SharedPreferenceConst.APPLE_GIVE_NAME).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_GIVE_NAME) : '',
      'last_name': getStringAsync(SharedPreferenceConst.APPLE_FAMILY_NAME).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_FAMILY_NAME) : '',
      "username": getStringAsync(SharedPreferenceConst.APPLE_EMAIL).isNotEmpty ? getStringAsync(SharedPreferenceConst.APPLE_EMAIL) : getStringAsync(SharedPreferenceConst.APPLE_UID) + '@gmail.com',
      "profile_image": '',
      "social_image": '',
      'accessToken': '12345678',
      'login_type': LoginTypeConst.LOGIN_TYPE_APPLE,
      "user_type": LoginTypeConst.LOGIN_TYPE_USER,
    };

    log("Apple Login Json" + jsonEncode(req));

    await loginUser(req, isSocialLogin: true).then((value) async {
      //
    }).catchError((e) {
      log(e.toString());
      throw e;
    });
  }

//endregion
}
