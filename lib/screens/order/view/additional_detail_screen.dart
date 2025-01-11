import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import 'order_summary_screen.dart';

class AdditionalDetailScreen extends StatefulWidget {
  @override
  _AdditionalDetailScreenState createState() => _AdditionalDetailScreenState();
}

class _AdditionalDetailScreenState extends State<AdditionalDetailScreen> {
  final GlobalKey<FormState> _additionalFormKey = GlobalKey<FormState>();

  TextEditingController fullNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController alternateMobileCont = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode alternateFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    fullNameCont.text = userStore.userFullName.validate();
    emailCont.text = userStore.userEmail.validate();
    mobileCont.text = userStore.userContactNumber.validate();
    alternateMobileCont.text = productStore.alternateContactNumber.validate();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.customerDetail,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: Stack(
        children: [
          AnimatedScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 60, top: 30),
            children: [
              Form(
                key: _additionalFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: fullNameCont,
                      focus: fullNameFocus,
                      nextFocus: mobileFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(context, label: locale.fullName),
                      suffix: ic_unselected_profile.iconImage(fit: BoxFit.contain, size: 14).paddingAll(16),
                    ),
                    16.height,
                    AppTextField(
                      controller: emailCont,
                      focus: emailFocus,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(context, label: locale.email),
                      suffix: ic_message.iconImage(fit: BoxFit.contain, size: 14).paddingAll(16),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: mobileCont,
                      focus: mobileFocus,
                      maxLength: 15,
                      decoration: inputDecoration(context, label: locale.contactNumber),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: alternateMobileCont,
                      focus: alternateFocus,
                      maxLength: 15,
                      isValidationRequired: false,
                      decoration: inputDecoration(context, label: locale.alternateContactNumber),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: context.width(),
              child: Text(locale.confirm, style: boldTextStyle(color: Colors.white)),
              color: secondaryColor,
              onTap: () async {
                appStore.setLoading(true);
                await 1.seconds.delay;

                productStore.setCustomerFullName(fullNameCont.text);
                productStore.setCustomerEmail(emailCont.text);
                productStore.setCustomerContactNumber(mobileCont.text);
                productStore.setCustomerAlternateContactNumber(alternateMobileCont.text);

                appStore.setLoading(false);
                OrderSummaryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
              },
            ),
          ),
        ],
      ),
    );
  }
}
