import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  int userId = -1;

  @observable
  String uid = '';

  @observable
  String loginType = '';

  @observable
  String userFirstName = '';

  @observable
  String userLastName = '';

  @computed
  String get userFullName => '$userFirstName $userLastName'.trim();

  @observable
  String userEmail = '';

  @observable
  String userProfileImage = '';

  @observable
  String userContactNumber = '';

  @observable
  String gender = '';

  @observable
  String userName = '';

  @observable
  String token = '';

  @observable
  String userType = '';

  @action
  Future<void> setUId(String val, {bool isInitializing = false}) async {
    uid = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.UID, val);
  }

  @action
  Future<void> setUserType(String val, {bool isInitializing = false}) async {
    userType = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.USER_TYPE, val);
  }

  @action
  Future<void> setUserProfile(String val, {bool isInitializing = false}) async {
    userProfileImage = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.PROFILE_IMAGE, val);
  }

  @action
  Future<void> setLoginType(String val, {bool isInitializing = false}) async {
    loginType = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.LOGIN_TYPE, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitializing = false}) async {
    token = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.TOKEN, val);
  }

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.USER_ID, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitializing = false}) async {
    userEmail = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.USER_EMAIL, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitializing = false}) async {
    userFirstName = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.FIRST_NAME, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitializing = false}) async {
    userLastName = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.LAST_NAME, val);
  }

  @action
  Future<void> setContactNumber(String val, {bool isInitializing = false}) async {
    userContactNumber = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.CONTACT_NUMBER, val);
  }

  @action
  Future<void> setGenderValue(String val, {bool isInitializing = false}) async {
    gender = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.GENDER, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitializing = false}) async {
    userName = val;
    if (!isInitializing) await setValue(SharedPreferenceConst.USERNAME, val);
  }
}
