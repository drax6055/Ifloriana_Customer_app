import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../configs.dart';
import '../../../utils/colors.dart';
import '../component/gender_selection_component.dart';
import '../model/user_data_model.dart';

class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  final bool isOTPLogin;
  final String? uid;

  SignUpScreen({Key? key, this.phoneNumber, this.isOTPLogin = false, this.countryCode, this.uid}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();

  String? genderValue = GenderConst.MALE;
  Country selectedCountry = defaultCountry();
  ValueNotifier _valueNotifier = ValueNotifier(true);

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  Future<void> changeCountry() async {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(textStyle: secondaryTextStyle(color: textSecondaryColorGlobal)),
      showPhoneCode: true,
      onSelect: (Country country) {
        selectedCountry = country;
        setState(() {});
      },
    );

  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    //
  }

  /// region Register with OTP

  Future<void> registerWithOTP() async {
    hideKeyboard(context);
    if (appStore.isLoading) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appStore.setLoading(true);

      UserData userResponse = UserData()
        ..username = widget.phoneNumber.validate().trim()
        ..loginType = LoginTypeConst.LOGIN_TYPE_OTP
        ..email = emailCont.text.trim()
        ..userType = LoginTypeConst.LOGIN_TYPE_USER
        ..password = widget.phoneNumber.validate().trim();

      await createUser(userResponse.toJson()).then((register) async {});

      appStore.setLoading(false);
      return;
    }
  }

  /// endregion

  /// region Register User
  void registerUser() async {
    hideKeyboard(context);

    if (appStore.isLoading) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      /// Create a temporary request to send
      UserData tempRegisterData = UserData()
        // ..userType = LoginTypeConst.LOGIN_TYPE_USER
        ..firstName = firstNameCont.text.trim()
        ..lastName = lastNameCont.text.trim()
        ..email = emailCont.text.trim()
        ..password = passwordCont.text.trim()
        ..mobile = mobileCont.text.trim()
        ..gender = genderValue.validate().toLowerCase();

      await createUser(tempRegisterData.toJson()).then((registerResponse) async {
        appStore.setLoading(false);
        toast(registerResponse.message.validate());

        finish(context);
      }).catchError((e) {
        appStore.setLoading(false);

        toast(e.toString());
      });
    }
  }

  /// endregion

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: context.height() * 0.3,
                    width: context.width(),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: primaryColor,
                      borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                      decorationImage: DecorationImage(image: AssetImage(bg_pattern), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: boxDecorationDefault(shape: BoxShape.circle),
                      child: Image.asset(app_logo, height: 104, width: 104, fit: BoxFit.cover),
                    ).center(),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(locale.helloUser, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                  8.height,
                  Text(locale.createYourAccountFor, style: secondaryTextStyle(), textAlign: TextAlign.center),
                  Column(
                    children: [
                      16.height,
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              controller: firstNameCont,
                              focus: firstNameFocus,
                              nextFocus: lastNameFocus,
                              textFieldType: TextFieldType.NAME,
                              readOnly: widget.isOTPLogin.validate() ? widget.isOTPLogin : false,
                              decoration: inputDecoration(context, label: locale.firstName),
                            ),
                            16.height,
                            AppTextField(
                              controller: lastNameCont,
                              focus: lastNameFocus,
                              nextFocus: emailFocus,
                              textFieldType: TextFieldType.NAME,
                              readOnly: widget.isOTPLogin.validate() ? widget.isOTPLogin : false,
                              decoration: inputDecoration(context, label: locale.lastName),
                            ),
                            16.height,
                            AppTextField(
                              controller: emailCont,
                              focus: emailFocus,
                              nextFocus: passwordFocus,
                              textFieldType: TextFieldType.EMAIL,
                              decoration: inputDecoration(context, label: locale.email),
                            ),
                            16.height,
                            AppTextField(
                              controller: passwordCont,
                              textFieldType: TextFieldType.PASSWORD,
                              focus: passwordFocus,
                              nextFocus: mobileFocus,
                              readOnly: widget.isOTPLogin.validate() ? widget.isOTPLogin : false,
                              decoration: inputDecoration(context, label: locale.password),
                              autoFillHints: [AutofillHints.password],
                              validator: (value) {
                                if (value == null || value.length < 8 || value.length > 12) {
                                  return "Password must be between 8 and 12 characters.";
                                }
                                return null;
                              },
                              onFieldSubmitted: (s) {
                                if (widget.isOTPLogin) {
                                  registerWithOTP();
                                } else {
                                  if (passwordCont.text.length >= 8 && passwordCont.text.length <= 12) {
                                    registerUser();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Password must be between 8 and 12 characters.")),
                                    );
                                  }
                                }
                              },
                            ),

                            16.height,
                            GenderSelectionComponent(
                              onTap: (value) {
                                genderValue = value;
                                setState(() {});
                              },
                            ),
                            16.height,
                            // AppTextField(
                            //   textFieldType: TextFieldType.PHONE,
                            //   controller: mobileCont,
                            //   focus: mobileFocus,
                            //   errorThisFieldRequired: locale.thisFieldIsRequired,
                            //   decoration: inputDecoration(context, label: locale.contactNumber),
                            //   maxLength: 15,
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: context.height()*0.063,
                                  decoration: BoxDecoration(
                                    color: context.cardColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                    child: ValueListenableBuilder(
                                      valueListenable: _valueNotifier,
                                      builder: (context, value, child) => Row(
                                        children: [
                                          Text(
                                            "+${selectedCountry.phoneCode}",
                                            style: primaryTextStyle(size: 12),
                                          ),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ).paddingOnly(left: 8),
                                    ),
                                  ),
                                ).onTap(() => changeCountry()),
                                10.width,
                                Expanded(
                                  child: AppTextField(
                                    textFieldType: TextFieldType.PHONE,
                                    controller: mobileCont,
                                    focus: mobileFocus,
                                    errorThisFieldRequired: locale.thisFieldIsRequired,
                                    decoration: inputDecoration(context, label: locale.contactNumber),
                                    maxLength: 15,
                                  ),
                                ),
                              ],
                            ),
                            16.height,
                          ],
                        ),
                      ),
                      16.height,
                      AppButton(
                        child: Text(locale.signUp, style: boldTextStyle(color: white)),
                        width: context.width(),
                        color: secondaryColor,
                        onTap: () async {
                          if (genderValue == null) {
                            // todo : add languages
                            toast("Gender field is required");
                          } else {
                            if (widget.isOTPLogin) {
                              registerWithOTP();
                            } else {
                              registerUser();
                            }
                          }
                        },
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(locale.alreadyHaveAnAccount, style: secondaryTextStyle()),
                          TextButton(
                            onPressed: () {
                              hideKeyboard(context);
                              finish(context);
                            },
                            child: Text(
                              locale.signIn,
                              style: boldTextStyle(color: primaryColor, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 16),
                ],
              ).paddingOnly(top: 80),
            ],
          ),
        ),
      ),
    );
  }
}
