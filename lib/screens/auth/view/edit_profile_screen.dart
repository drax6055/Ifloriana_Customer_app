import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../components/loader_widget.dart';
import '../../../configs.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../auth_repository.dart';
import '../component/gender_selection_component.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UniqueKey genderKey = UniqueKey();

  File? imageFile;
  XFile? pickedFile;

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController genderCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();

  Country selectedCountry = defaultCountry();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
    });

    fNameCont.text = userStore.userFirstName.validate();
    lNameCont.text = userStore.userLastName.validate();
    emailCont.text = userStore.userEmail.validate();
    mobileCont.text = userStore.userContactNumber.validate();
    genderCont.text = userStore.gender.validate();
    genderKey = UniqueKey();

    /*String countryCode = userStore.userContactNumber.validate().splitBefore('-').replaceAll('+', '');
    try {
      selectedCountry = CountryParser.parsePhoneCode(countryCode);
    } on Exception catch (e) {
      log(e);
    }*/
  }

  Future<void> update() async {
    hideKeyboard(context);
    appStore.setLoading(true);

    updateProfile(
      firstName: fNameCont.text,
      lastName: lNameCont.text,
      mobile: mobileCont.text,
      gender: genderCont.text,
      imageFile: imageFile,
      onSuccess: (data) {
        appStore.setLoading(false);
        if (data != null) {
          if ((data as String).isJson()) {
            viewProfile().then((value) {}).catchError(onError);

            finish(context);
          }
        }
      },
    ).then((data) {
      toast(locale.profileUpdatedSuccessfully);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  void _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.gallery,
              leading: Icon(Icons.image, color: context.iconColor),
              onTap: () async {
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.camera,
              leading: Icon(Icons.camera, color: context.iconColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  Future<void> changeCountry() async {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(textStyle: secondaryTextStyle(color: textSecondaryColorGlobal)),
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        selectedCountry = country;
        setState(() {});
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: commonAppBarWidget(
          context,
          title: locale.editProfile,
          appBarHeight: 70,
          showLeadingIcon: true,
          roundCornerShape: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: Stack(
                        children: [
                          Container(
                            decoration: boxDecorationDefault(
                              border: Border.all(color: context.scaffoldBackgroundColor, width: 4),
                              shape: BoxShape.circle,
                            ),
                            child: imageFile != null
                                ? Image.file(imageFile!, width: 90, height: 90, fit: BoxFit.cover).cornerRadiusWithClipRRect(45)
                                : Observer(
                                    builder: (_) => CachedImageWidget(
                                      url: userStore.userProfileImage,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      radius: 64,
                                      child: DefaultUserImagePlaceholder(),
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 2,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: boxDecorationWithRoundedCorners(
                                boxShape: BoxShape.circle,
                                backgroundColor: primaryColor,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon(Icons.camera, color: Colors.white, size: 16).paddingAll(4.0),
                            ).onTap(
                              () async {
                                _showBottomSheet(context);
                              },
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                          ).visible(!isLoginTypeGoogle && !isLoginTypeApple)
                        ],
                      ),
                    ),
                    24.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: fNameCont,
                      focus: fNameFocus,
                      nextFocus: lNameFocus,
                      enabled: !isSocialLoginType,
                      textStyle: isSocialLoginType ? secondaryTextStyle() : primaryTextStyle(),
                      decoration: inputDecoration(context, label: locale.firstName),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: lNameCont,
                      focus: lNameFocus,
                      nextFocus: emailFocus,
                      enabled: !isSocialLoginType,
                      textStyle: isSocialLoginType ? secondaryTextStyle() : primaryTextStyle(),
                      decoration: inputDecoration(context, label: locale.lastName),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL_ENHANCED,
                      controller: emailCont,
                      focus: emailFocus,
                      nextFocus: mobileFocus,
                      enabled: false,
                      textStyle: secondaryTextStyle(),
                      decoration: inputDecoration(context, label: locale.email),
                    ),
                    16.height,
                    GenderSelectionComponent(
                      key: genderKey,
                      type: genderCont.text,
                      onTap: (value) {
                        genderCont.text = value;
                      },
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: mobileCont,
                      focus: mobileFocus,
                      errorThisFieldRequired: locale.thisFieldIsRequired,
                      decoration: inputDecoration(context, label: locale.contactNumber),
                    ),
                    16.height,
                    AppButton(
                      text: locale.update,
                      height: 40,
                      color: secondaryColor,
                      textStyle: primaryTextStyle(color: white),
                      width: context.width() - context.navigationBarHeight,
                      onTap: () {
                        ifNotTester(() async {
                          if (await isNetworkAvailable()) {
                            update();
                          } else {
                            toast(locale.yourInternetIsNotWorking);
                          }
                        });
                      },
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
            Observer(builder: (_) => LoaderWidget().visible(appStore.isLoading)),
          ],
        ),
      ),
    );
  }
}
