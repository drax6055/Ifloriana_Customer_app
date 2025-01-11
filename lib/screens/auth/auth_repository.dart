import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/models/base_response_model.dart';
import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/screens/auth/model/login_response.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/push_notification_service.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../network/rest_apis.dart';
import '../../utils/api_end_points.dart';
import '../../utils/model_keys.dart';
import 'model/user_data_model.dart';
import 'model/user_update_response.dart';

// region Register User
Future<BaseResponseModel> createUser(Map request) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.register, request: request, method: HttpMethodType.POST)));
}
// endregion

// region Login User
Future<LoginResponse> loginUser(Map request, {bool isSocialLogin = false, bool isRegenerateToken = false}) async {
  LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(
    isSocialLogin ? APIEndPoints.socialLogin : APIEndPoints.login,
    request: request,
    method: HttpMethodType.POST,
  )));

  if (isRegenerateToken) {
    await userStore.setToken(res.userData!.apiToken.validate());
  } else {
    if (!isSocialLogin) await userStore.setLoginType(LoginTypeConst.LOGIN_TYPE_USER);

    if (res.userData != null) {
      appStore.setLoading(false);
      saveUserData(res.userData!).then((value) {
        getAppConfigurations();
      });
    }
  }

  return res;
}
// endregion

// region Save User Data
Future<void> saveUserData(UserData data) async {
  appStore.setLoggedIn(true);

  if (data.apiToken.validate().isNotEmpty) await userStore.setToken(data.apiToken.validate());

  await userStore.setUserId(data.id.validate());
  await userStore.setFirstName(data.firstName.validate());
  await userStore.setLastName(data.lastName.validate());
  await userStore.setUserEmail(data.email.validate());
  await userStore.setUserName(data.username.validate());
  await userStore.setContactNumber(data.mobile.validate());
  await userStore.setGenderValue(data.gender.validate());
  await userStore.setLoginType(data.loginType.validate(value: userStore.loginType));

  if (data.loginType == LoginTypeConst.LOGIN_TYPE_GOOGLE) {
    await userStore.setUserProfile(data.profileImage.validate());
  } else {
    await userStore.setUserProfile(data.profileImage.validate());
  }
}
// endregion

// region Change Password
Future<UserUpdateResponse> changePasswordAPI(Map request) async {
  return UserUpdateResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.changePassword, request: request, method: HttpMethodType.POST)));
}
// endregion

// region Forgot password
Future<BaseResponseModel> forgotPasswordAPI(Map request) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.forgotPassword, request: request, method: HttpMethodType.POST)));
}
// endregion

// region Logout
Future<void> clearData({bool clearBranchData = true}) async {
  PushNotificationService().unSubScribeToTopic();
  clearPreferences();
  FirebaseAuth.instance.signOut();

  dashboardResponseCached = null;
  categoryListCached = null;
  branchReviewListResponseCached = null;
  branchStaffListResponseCached = null;
  branchGalleryListResponseCached = null;
  branchServiceListResponseCached = null;
  bookingDetailCached = [];

  if (clearBranchData) {
    appStore.setBranchAddress('');
    appStore.setBranchId(-1);
    appStore.setBranchName('');
    appStore.setBranchContactNumber('');
  }
}

Future<void> logoutApi({bool clearBranchData = true}) async {
  await clearData(clearBranchData: clearBranchData);

  return await handleResponse(await buildHttpResponse(APIEndPoints.logout, method: HttpMethodType.GET));
}
// endregion

Future<dynamic> updateProfile({File? imageFile,
  String firstName = '',
  String lastName = '',
  String email = '',
  String mobile = '', String
  gender = '', Function(dynamic)? onSuccess}) async {

  if (appStore.isLoggedIn) {
    MultipartRequest multiPartRequest = await getMultiPartRequest('${APIEndPoints.updateProfile}');

    if (firstName.isNotEmpty) multiPartRequest.fields[UserKeys.firstName] = firstName;
    if (lastName.isNotEmpty) multiPartRequest.fields[UserKeys.lastName] = lastName;
    if (mobile.isNotEmpty) multiPartRequest.fields[UserKeys.mobile] = mobile;
    if (gender.isNotEmpty) multiPartRequest.fields[UserKeys.gender] = gender;
    if (email.isNotEmpty) multiPartRequest.fields[UserKeys.email] = email;

    if (imageFile != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath(UserKeys.profileImage, imageFile.path));
    }

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        onSuccess?.call(data);
      },
      onError: (error) {
        throw error;
      },
    ).catchError((error) {
      throw error;
    });
  }
}

Future<UserUpdateResponse> viewProfile({int? id}) async {
  var res = UserUpdateResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.userDetail}?id=${id ?? userStore.userId}', method: HttpMethodType.GET)));

  if (res.data != null) saveUserData(res.data!);

  return res;
}

Future<BaseResponseModel> deleteAccountCompletely() async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.deleteUserAccount, request: {}, method: HttpMethodType.POST)));
}
