import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/auth/auth_repository.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();

  // FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> forgotPwd() async {
    if (formKey.currentState!.validate()) {
      hideKeyboard(context);
      formKey.currentState!.save();
      appStore.setLoading(true);

      Map req = {
        CommonKey.email: emailCont.text.validate(),
      };

      forgotPasswordAPI(req).then((res) {
        appStore.setLoading(false);
        finish(context);

        toast(res.message.validate());
      }).catchError((e) {
        toast(e.toString(), print: true);
      }).whenComplete(() => appStore.setLoading(false));
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: context.width(),
              decoration: boxDecorationDefault(
                color: context.primaryColor,
                borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.forgotPassword, style: boldTextStyle(color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: Icon(Icons.clear, color: Colors.white, size: 20),
                  )
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.enterYourEmailAddress, style: boldTextStyle()),
                6.height,
                Text(locale.aResetPasswordLink, style: secondaryTextStyle()),
                24.height,
                Observer(
                  builder: (_) => AppTextField(
                    textFieldType: TextFieldType.EMAIL_ENHANCED,
                    controller: emailCont,
                    autoFocus: true,
                    errorThisFieldRequired: locale.thisFieldIsRequired,
                    decoration: inputDecoration(context, hint: locale.email),
                  ).visible(!appStore.isLoading, defaultWidget: Loader()),
                ),
                24.height,
                AppButton(
                  text: locale.resetPassword,
                  color: secondaryColor,
                  textColor: Colors.white,
                  width: context.width() - context.navigationBarHeight,
                  onTap: () {
                    forgotPwd();
                  },
                ),
              ],
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
