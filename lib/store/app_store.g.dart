// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<bool>? _$isBranchSelectedComputed;

  @override
  bool get isBranchSelected => (_$isBranchSelectedComputed ??= Computed<bool>(
          () => super.isBranchSelected,
          name: '_AppStore.isBranchSelected'))
      .value;

  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isDarkModeAtom =
      Atom(name: '_AppStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isSpeechActivatedAtom =
      Atom(name: '_AppStore.isSpeechActivated', context: context);

  @override
  bool get isSpeechActivated {
    _$isSpeechActivatedAtom.reportRead();
    return super.isSpeechActivated;
  }

  @override
  set isSpeechActivated(bool value) {
    _$isSpeechActivatedAtom.reportWrite(value, super.isSpeechActivated, () {
      super.isSpeechActivated = value;
    });
  }

  late final _$selectedLanguageCodeAtom =
      Atom(name: '_AppStore.selectedLanguageCode', context: context);

  @override
  String get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String value) {
    _$selectedLanguageCodeAtom.reportWrite(value, super.selectedLanguageCode,
        () {
      super.selectedLanguageCode = value;
    });
  }

  late final _$currencyCodeAtom =
      Atom(name: '_AppStore.currencyCode', context: context);

  @override
  String get currencyCode {
    _$currencyCodeAtom.reportRead();
    return super.currencyCode;
  }

  @override
  set currencyCode(String value) {
    _$currencyCodeAtom.reportWrite(value, super.currencyCode, () {
      super.currencyCode = value;
    });
  }

  late final _$countryIdAtom =
      Atom(name: '_AppStore.countryId', context: context);

  @override
  int get countryId {
    _$countryIdAtom.reportRead();
    return super.countryId;
  }

  @override
  set countryId(int value) {
    _$countryIdAtom.reportWrite(value, super.countryId, () {
      super.countryId = value;
    });
  }

  late final _$stateIdAtom = Atom(name: '_AppStore.stateId', context: context);

  @override
  int get stateId {
    _$stateIdAtom.reportRead();
    return super.stateId;
  }

  @override
  set stateId(int value) {
    _$stateIdAtom.reportWrite(value, super.stateId, () {
      super.stateId = value;
    });
  }

  late final _$cityIdAtom = Atom(name: '_AppStore.cityId', context: context);

  @override
  int get cityId {
    _$cityIdAtom.reportRead();
    return super.cityId;
  }

  @override
  set cityId(int value) {
    _$cityIdAtom.reportWrite(value, super.cityId, () {
      super.cityId = value;
    });
  }

  late final _$currencyCountryIdAtom =
      Atom(name: '_AppStore.currencyCountryId', context: context);

  @override
  String get currencyCountryId {
    _$currencyCountryIdAtom.reportRead();
    return super.currencyCountryId;
  }

  @override
  set currencyCountryId(String value) {
    _$currencyCountryIdAtom.reportWrite(value, super.currencyCountryId, () {
      super.currencyCountryId = value;
    });
  }

  late final _$currencySymbolAtom =
      Atom(name: '_AppStore.currencySymbol', context: context);

  @override
  String get currencySymbol {
    _$currencySymbolAtom.reportRead();
    return super.currencySymbol;
  }

  @override
  set currencySymbol(String value) {
    _$currencySymbolAtom.reportWrite(value, super.currencySymbol, () {
      super.currencySymbol = value;
    });
  }

  late final _$privacyPolicyAtom =
      Atom(name: '_AppStore.privacyPolicy', context: context);

  @override
  String get privacyPolicy {
    _$privacyPolicyAtom.reportRead();
    return super.privacyPolicy;
  }

  @override
  set privacyPolicy(String value) {
    _$privacyPolicyAtom.reportWrite(value, super.privacyPolicy, () {
      super.privacyPolicy = value;
    });
  }

  late final _$termConditionsAtom =
      Atom(name: '_AppStore.termConditions', context: context);

  @override
  String get termConditions {
    _$termConditionsAtom.reportRead();
    return super.termConditions;
  }

  @override
  set termConditions(String value) {
    _$termConditionsAtom.reportWrite(value, super.termConditions, () {
      super.termConditions = value;
    });
  }

  late final _$inquiryEmailAtom =
      Atom(name: '_AppStore.inquiryEmail', context: context);

  @override
  String get inquiryEmail {
    _$inquiryEmailAtom.reportRead();
    return super.inquiryEmail;
  }

  @override
  set inquiryEmail(String value) {
    _$inquiryEmailAtom.reportWrite(value, super.inquiryEmail, () {
      super.inquiryEmail = value;
    });
  }

  late final _$helplineNumberAtom =
      Atom(name: '_AppStore.helplineNumber', context: context);

  @override
  String get helplineNumber {
    _$helplineNumberAtom.reportRead();
    return super.helplineNumber;
  }

  @override
  set helplineNumber(String value) {
    _$helplineNumberAtom.reportWrite(value, super.helplineNumber, () {
      super.helplineNumber = value;
    });
  }

  late final _$branchIdAtom =
      Atom(name: '_AppStore.branchId', context: context);

  @override
  int get branchId {
    _$branchIdAtom.reportRead();
    return super.branchId;
  }

  @override
  set branchId(int value) {
    _$branchIdAtom.reportWrite(value, super.branchId, () {
      super.branchId = value;
    });
  }

  late final _$branchAddressAtom =
      Atom(name: '_AppStore.branchAddress', context: context);

  @override
  String get branchAddress {
    _$branchAddressAtom.reportRead();
    return super.branchAddress;
  }

  @override
  set branchAddress(String value) {
    _$branchAddressAtom.reportWrite(value, super.branchAddress, () {
      super.branchAddress = value;
    });
  }

  late final _$branchNameAtom =
      Atom(name: '_AppStore.branchName', context: context);

  @override
  String get branchName {
    _$branchNameAtom.reportRead();
    return super.branchName;
  }

  @override
  set branchName(String value) {
    _$branchNameAtom.reportWrite(value, super.branchName, () {
      super.branchName = value;
    });
  }

  late final _$branchContactNumberAtom =
      Atom(name: '_AppStore.branchContactNumber', context: context);

  @override
  String get branchContactNumber {
    _$branchContactNumberAtom.reportRead();
    return super.branchContactNumber;
  }

  @override
  set branchContactNumber(String value) {
    _$branchContactNumberAtom.reportWrite(value, super.branchContactNumber, () {
      super.branchContactNumber = value;
    });
  }

  late final _$isUserAuthorizedAtom =
      Atom(name: '_AppStore.isUserAuthorized', context: context);

  @override
  bool get isUserAuthorized {
    _$isUserAuthorizedAtom.reportRead();
    return super.isUserAuthorized;
  }

  @override
  set isUserAuthorized(bool value) {
    _$isUserAuthorizedAtom.reportWrite(value, super.isUserAuthorized, () {
      super.isUserAuthorized = value;
    });
  }

  late final _$setISUserAuthorizedAsyncAction =
      AsyncAction('_AppStore.setISUserAuthorized', context: context);

  @override
  Future<void> setISUserAuthorized(bool val) {
    return _$setISUserAuthorizedAsyncAction
        .run(() => super.setISUserAuthorized(val));
  }

  late final _$setBranchAddressAsyncAction =
      AsyncAction('_AppStore.setBranchAddress', context: context);

  @override
  Future<void> setBranchAddress(String val, {bool isInitializing = false}) {
    return _$setBranchAddressAsyncAction
        .run(() => super.setBranchAddress(val, isInitializing: isInitializing));
  }

  late final _$setBranchNameAsyncAction =
      AsyncAction('_AppStore.setBranchName', context: context);

  @override
  Future<void> setBranchName(String val, {bool isInitializing = false}) {
    return _$setBranchNameAsyncAction
        .run(() => super.setBranchName(val, isInitializing: isInitializing));
  }

  late final _$setBranchContactNumberAsyncAction =
      AsyncAction('_AppStore.setBranchContactNumber', context: context);

  @override
  Future<void> setBranchContactNumber(String val,
      {bool isInitializing = false}) {
    return _$setBranchContactNumberAsyncAction.run(() =>
        super.setBranchContactNumber(val, isInitializing: isInitializing));
  }

  late final _$setBranchIdAsyncAction =
      AsyncAction('_AppStore.setBranchId', context: context);

  @override
  Future<void> setBranchId(int val, {bool isInitializing = false}) {
    return _$setBranchIdAsyncAction
        .run(() => super.setBranchId(val, isInitializing: isInitializing));
  }

  late final _$setHelplineNumberAsyncAction =
      AsyncAction('_AppStore.setHelplineNumber', context: context);

  @override
  Future<void> setHelplineNumber(String val, {bool isInitializing = false}) {
    return _$setHelplineNumberAsyncAction.run(
        () => super.setHelplineNumber(val, isInitializing: isInitializing));
  }

  late final _$setInquiryEmailAsyncAction =
      AsyncAction('_AppStore.setInquiryEmail', context: context);

  @override
  Future<void> setInquiryEmail(String val, {bool isInitializing = false}) {
    return _$setInquiryEmailAsyncAction
        .run(() => super.setInquiryEmail(val, isInitializing: isInitializing));
  }

  late final _$setTermConditionsAsyncAction =
      AsyncAction('_AppStore.setTermConditions', context: context);

  @override
  Future<void> setTermConditions(String val, {bool isInitializing = false}) {
    return _$setTermConditionsAsyncAction.run(
        () => super.setTermConditions(val, isInitializing: isInitializing));
  }

  late final _$setPrivacyPolicyAsyncAction =
      AsyncAction('_AppStore.setPrivacyPolicy', context: context);

  @override
  Future<void> setPrivacyPolicy(String val, {bool isInitializing = false}) {
    return _$setPrivacyPolicyAsyncAction
        .run(() => super.setPrivacyPolicy(val, isInitializing: isInitializing));
  }

  late final _$setCurrencySymbolAsyncAction =
      AsyncAction('_AppStore.setCurrencySymbol', context: context);

  @override
  Future<void> setCurrencySymbol(String val, {bool isInitializing = false}) {
    return _$setCurrencySymbolAsyncAction.run(
        () => super.setCurrencySymbol(val, isInitializing: isInitializing));
  }

  late final _$setCurrencyCountryIdAsyncAction =
      AsyncAction('_AppStore.setCurrencyCountryId', context: context);

  @override
  Future<void> setCurrencyCountryId(String val, {bool isInitializing = false}) {
    return _$setCurrencyCountryIdAsyncAction.run(
        () => super.setCurrencyCountryId(val, isInitializing: isInitializing));
  }

  late final _$setCountryIdAsyncAction =
      AsyncAction('_AppStore.setCountryId', context: context);

  @override
  Future<void> setCountryId(int val, {bool isInitializing = false}) {
    return _$setCountryIdAsyncAction
        .run(() => super.setCountryId(val, isInitializing: isInitializing));
  }

  late final _$setStateIdAsyncAction =
      AsyncAction('_AppStore.setStateId', context: context);

  @override
  Future<void> setStateId(int val, {bool isInitializing = false}) {
    return _$setStateIdAsyncAction
        .run(() => super.setStateId(val, isInitializing: isInitializing));
  }

  late final _$setCityIdAsyncAction =
      AsyncAction('_AppStore.setCityId', context: context);

  @override
  Future<void> setCityId(int val, {bool isInitializing = false}) {
    return _$setCityIdAsyncAction
        .run(() => super.setCityId(val, isInitializing: isInitializing));
  }

  late final _$setCurrencyCodeAsyncAction =
      AsyncAction('_AppStore.setCurrencyCode', context: context);

  @override
  Future<void> setCurrencyCode(String val, {bool isInitializing = false}) {
    return _$setCurrencyCodeAsyncAction
        .run(() => super.setCurrencyCode(val, isInitializing: isInitializing));
  }

  late final _$setLoggedInAsyncAction =
      AsyncAction('_AppStore.setLoggedIn', context: context);

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('_AppStore.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool val) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(val));
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_AppStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String val) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(val));
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpeechStatus(bool val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setSpeechStatus');
    try {
      return super.setSpeechStatus(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isDarkMode: ${isDarkMode},
isLoading: ${isLoading},
isSpeechActivated: ${isSpeechActivated},
selectedLanguageCode: ${selectedLanguageCode},
currencyCode: ${currencyCode},
countryId: ${countryId},
stateId: ${stateId},
cityId: ${cityId},
currencyCountryId: ${currencyCountryId},
currencySymbol: ${currencySymbol},
privacyPolicy: ${privacyPolicy},
termConditions: ${termConditions},
inquiryEmail: ${inquiryEmail},
helplineNumber: ${helplineNumber},
branchId: ${branchId},
branchAddress: ${branchAddress},
branchName: ${branchName},
branchContactNumber: ${branchContactNumber},
isUserAuthorized: ${isUserAuthorized},
isBranchSelected: ${isBranchSelected}
    ''';
  }
}

