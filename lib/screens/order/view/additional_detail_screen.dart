import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:country_picker/country_picker.dart';

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

  Country _defaultCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: "India",
    example: "9123456789",
    displayName: "India (IN) [+91]",
    displayNameNoCountryCode: "India (IN)",
    e164Key: "91-IN-0",
  );

  late Country selectedCountry;
  late Country alternateSelectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = _defaultCountry;
    alternateSelectedCountry = _defaultCountry;
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
                    _buildPhoneField(
                      controller: mobileCont,
                      focus: mobileFocus,
                      label: locale.contactNumber,
                      country: selectedCountry,
                      onCountryChanged: (country) => setState(() => selectedCountry = country),
                    ),
                    16.height,
                    _buildPhoneField(
                      controller: alternateMobileCont,
                      focus: alternateFocus,
                      label: locale.alternateContactNumber,
                      country: alternateSelectedCountry,
                      onCountryChanged: (country) => setState(() => alternateSelectedCountry = country),
                      isValidationRequired: false,
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
                productStore.setCustomerContactNumber(
                    '+${selectedCountry.phoneCode} ${mobileCont.text}');
                productStore.setCustomerAlternateContactNumber(
                    '+${alternateSelectedCountry.phoneCode} ${alternateMobileCont.text}');

                appStore.setLoading(false);
                OrderSummaryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Build the phone number field with country code
  Widget _buildPhoneField({
    required TextEditingController controller,
    required FocusNode focus,
    required String label,
    required Country country,
    required Function(Country) onCountryChanged,
    bool isValidationRequired = true,
  }) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(8),
        backgroundColor: context.cardColor,
      ),
      child: Row(
        children: [
          _buildCountrySelector(country, onCountryChanged),
          Expanded(
            child: AppTextField(
              controller: controller,
              focus: focus,
              textFieldType: TextFieldType.PHONE,
              maxLength: 15,
              isValidationRequired: isValidationRequired,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelector(Country country, Function(Country) onCountryChanged) {
    return GestureDetector(
      onTap: () => _showCountryPicker(onCountryChanged),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(country.flagEmoji, style: TextStyle(fontSize: 20)),
            // 4.width,
            Text('+${country.phoneCode}', style: primaryTextStyle()),
            8.width,
            Icon(Icons.arrow_drop_down, color: Colors.grey),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey.withOpacity(0.2),
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }

  void _showCountryPicker(Function(Country) onSelect) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['IN'],
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(8),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onSelect: onSelect,
    );
  }
}
