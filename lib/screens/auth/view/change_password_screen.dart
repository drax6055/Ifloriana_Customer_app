import 'package:flutter/material.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../../utils/model_keys.dart';
import '../auth_repository.dart';
import '../component/successfully_change_password_dialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordCont = TextEditingController();
  TextEditingController newPasswordCont = TextEditingController();
  TextEditingController reenterPasswordCont = TextEditingController();

  FocusNode oldPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode reenterPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (getStringAsync(SharedPreferenceConst.USER_PASSWORD) != oldPasswordCont.text) {
        return toast(locale.oldPasswordDoesNotMatchMessage);
      }

      hideKeyboard(context);

      var request = {
        UserKeys.oldPassword: oldPasswordCont.text,
        UserKeys.newPassword: newPasswordCont.text,
      };

      appStore.setLoading(true);

      await changePasswordAPI(request).then((res) async {
        userStore.setToken(res.data!.apiToken.validate());
        await setValue(SharedPreferenceConst.USER_PASSWORD, newPasswordCont.text);
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (BuildContext context) => SuccessfullyChangePasswordDialog(),
        );
      }).catchError((e) {
        toast(e.toString(), print: true);
      });
      appStore.setLoading(false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.changePassword,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(locale.newPasswordsMustBeDifferent, style: secondaryTextStyle()),
              24.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                controller: oldPasswordCont,
                focus: oldPasswordFocus,
                nextFocus: newPasswordFocus,
                errorThisFieldRequired: locale.thisFieldIsRequired,
                suffixPasswordVisibleWidget: ic_show.iconImage(size: 10).paddingAll(14),
                suffixPasswordInvisibleWidget: ic_hide.iconImage(size: 10).paddingAll(14),
                decoration: inputDecoration(
                  context,
                  label: locale.oldPassword,
                ),
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                controller: newPasswordCont,
                focus: newPasswordFocus,
                nextFocus: reenterPasswordFocus,
                errorThisFieldRequired: locale.thisFieldIsRequired,
                suffixPasswordVisibleWidget: ic_show.iconImage(size: 10).paddingAll(14),
                suffixPasswordInvisibleWidget: ic_hide.iconImage(size: 10).paddingAll(14),
                validator: (value) {
                  if (value!.isEmpty) {
                    return locale.thisFieldIsRequired;
                  } else if (value == oldPasswordCont.text) {
                    return 'New password should not be the same as the old password';
                  }
                  return null;
                },

                decoration: inputDecoration(context, label: locale.newPassword),
              ),

              16.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                controller: reenterPasswordCont,
                focus: reenterPasswordFocus,
                errorThisFieldRequired: locale.thisFieldIsRequired,
                suffixPasswordVisibleWidget: ic_show.iconImage(size: 10).paddingAll(14),
                suffixPasswordInvisibleWidget: ic_hide.iconImage(size: 10).paddingAll(14),
                validator: (value) {
                  if (value!.isEmpty) {
                    return locale.thisFieldIsRequired;
                  } else if (value != newPasswordCont.text) {
                    return locale.thePasswordDoesNotMatch;
                  }
                  return null;
                },
                onFieldSubmitted: (s) {
                  changePassword();
                },
                decoration: inputDecoration(context, label: locale.reEnterPassword),
              ),
              24.height,
              AppButton(
                text: locale.confirm,
                color: secondaryColor,
                textColor: Colors.white,
                width: context.width() - context.navigationBarHeight,
                onTap: () {
                  ifNotTester(() {
                    changePassword();
                  });
                },
              ),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}
