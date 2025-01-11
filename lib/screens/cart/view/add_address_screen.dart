import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/screens/cart/cart_repository.dart';
import 'package:ifloriana/screens/cart/model/logistic_zone_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/address_list_response.dart';
import '../model/country_list_response.dart';
import '../model/state_list_response.dart';

class AddAddressScreen extends StatefulWidget {
  final UserAddress? address;

  AddAddressScreen({this.address});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  List<CountryData> countryList = [];
  List<StateData> stateList = [];
  List<CityData> cityList = [];

  CountryData? selectedCountry;
  StateData? selectedState;
  CityData? selectedCity;

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pinCodeCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode addressLine1FocusNode = FocusNode();
  FocusNode addressLine2FocusNode = FocusNode();
  FocusNode pinCodeFocus = FocusNode();

  bool isEdit = false;
  bool isPrimary = false;

  int countryId = 0;
  int stateId = 0;
  int cityId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      isEdit = true;
      firstNameCont.text = widget.address!.firstName.validate();
      lastNameCont.text = widget.address!.lastName.validate();
      addressLine1Controller.text = widget.address!.addressLine1.validate();
      addressLine2Controller.text = widget.address!.addressLine2.validate();
      pinCodeCont.text = widget.address!.postalCode.validate().toString();
      cityId = widget.address!.city.validate().toInt();
      stateId = widget.address!.state.validate().toInt();
      countryId = widget.address!.country.validate().toInt();
      isPrimary = widget.address!.isPrimary.validate().getBoolInt();
      setState(() {});
    }
    init();
  }

  void init() async {
    if (countryId != 0) {
      await getCountry();
      await getStates(countryId);
      if (stateId != 0) {
        await getCity(stateId);
      }

      setState(() {});
    } else {
      await getCountry();
    }
  }

  Future<void> getCountry() async {
    appStore.setLoading(true);

    await getCountryList().then((value) async {
      countryList.clear();
      countryList.addAll(value);
      setState(() {});
      value.forEach((e) {
        if (e.id == countryId) {
          selectedCountry = e;
        }
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> getStates(int countryId) async {
    appStore.setLoading(true);

    await getStateList(countryId: countryId).then((value) async {
      stateList.clear();
      stateList.addAll(value);
      value.forEach((e) {
        if (e.id == stateId) {
          selectedState = e;
        }
      });
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> getCity(int stateId) async {
    appStore.setLoading(true);

    await getCityList(stateId: stateId).then((value) async {
      cityList.clear();
      cityList.addAll(value);
      value.forEach((e) {
        if (e.id == cityId) {
          selectedCity = e;
        }
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
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
        title: isEdit ? locale.editAddress : locale.addNewAddress,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: Stack(
        children: [
          AnimatedScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 60, top: 30),
            children: [
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
                      decoration: inputDecoration(context, label: locale.firstName),
                    ),
                    16.height,
                    AppTextField(
                      controller: lastNameCont,
                      focus: lastNameFocus,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.done,
                      decoration: inputDecoration(context, label: locale.lastName),
                    ),
                    16.height,
                    Row(
                      children: [
                        DropdownButtonFormField<CountryData>(
                          decoration: inputDecoration(context, label: locale.selectCountry),
                          isExpanded: true,
                          value: (selectedCountry != null && selectedCountry!.id.validate() > 0) ? selectedCountry : null,
                          dropdownColor: context.cardColor,
                          items: countryList.map((CountryData e) {
                            return DropdownMenuItem<CountryData>(
                              value: e,
                              child: Text(e.name!, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (CountryData? value) async {
                            hideKeyboard(context);
                            countryId = value!.id!;
                            selectedCountry = value;
                            selectedState = null;
                            selectedCity = null;
                            getStates(value.id!);

                            setState(() {});
                          },
                        ).expand(),
                        if (stateList.isNotEmpty) 12.width,
                        if (stateList.isNotEmpty)
                          DropdownButtonFormField<StateData>(
                            decoration: inputDecoration(context, label: locale.selectState),
                            isExpanded: true,
                            dropdownColor: context.cardColor,
                            value: (selectedState != null && selectedState!.id.validate() > 0) ? selectedState : null,
                            items: stateList.map((StateData e) {
                              return DropdownMenuItem<StateData>(
                                value: e,
                                child: Text(e.name!, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (StateData? value) async {
                              hideKeyboard(context);
                              selectedCity = null;
                              selectedState = value;
                              stateId = value!.id!;
                              await getCity(value.id!);
                              setState(() {});
                            },
                          ).expand(),
                      ],
                    ),
                    16.height,
                    Row(
                      children: [
                        if (cityList.isNotEmpty)
                          DropdownButtonFormField<CityData>(
                            decoration: inputDecoration(context, label: locale.selectCity),
                            isExpanded: true,
                            value: (selectedCity != null && selectedCity!.id.validate() > 0) ? selectedCity : null,
                            dropdownColor: context.cardColor,
                            items: cityList.map((CityData e) {
                              return DropdownMenuItem<CityData>(
                                value: e,
                                child: Text(e.name!, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (CityData? value) async {
                              hideKeyboard(context);
                              selectedCity = value;
                              cityId = value!.id!;
                              setState(() {});
                            },
                          ).expand(),
                        if (cityList.isNotEmpty) 12.width,
                        AppTextField(
                          textFieldType: TextFieldType.NUMBER,
                          controller: pinCodeCont,
                          focus: pinCodeFocus,
                          nextFocus: addressLine1FocusNode,
                          isValidationRequired: false,
                          decoration:
                              inputDecoration(context, label: locale.pincode),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${locale.addressLine} 1 is required';
                            }
                            return null;
                          },
                          onTap: () {
                            scrollController.animToBottom();
                          },
                          onChanged: (p0) {
                            scrollController.animToBottom();
                          },
                        ).expand(),
                      ],
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.OTHER,
                      controller: addressLine1Controller,
                      nextFocus: addressLine2FocusNode,
                      focus: addressLine1FocusNode,
                      decoration: inputDecoration(context,
                          label: '${locale.addressLine} 1',
                          hint: '${locale.writeAddressHere}...'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${locale.addressLine} 1 is required';
                        }
                        return null;
                      },
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.OTHER,
                      controller: addressLine2Controller,
                      focus: addressLine2FocusNode,
                      isValidationRequired: false,
                      decoration: inputDecoration(context,
                          label: '${locale.addressLine} 2',
                          hint: '${locale.writeLandmarkHere}...'),
                    ),
                    8.height,
                    setAsPrimaryWidget(),
                    16.height,
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
              child: Text(isEdit ? locale.saveChanges : locale.save,
                  style: boldTextStyle(color: white)),
              width: context.width(),
              color: secondaryColor,
              onTap: () async {
                if (!appStore.isLoading) {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    appStore.setLoading(true);
                    hideKeyboard(context);
                    Map req = {
                      "first_name": firstNameCont.text.trim(),
                      "last_name": lastNameCont.text.trim(),
                      "address_line_1": addressLine1Controller.text.trim(),
                      "address_line_2": addressLine2Controller.text.trim(),
                      "postal_code": pinCodeCont.text.trim(),
                      "city": cityId,
                      "state": stateId,
                      "country": countryId,
                      "is_primary": isPrimary.getIntBool(),
                    };
                    if (isEdit) {
                      req.putIfAbsent(
                          "id", () => widget.address!.id.validate());
                    }

                    /// Add Or Edit Address Api Call
                    addEditAddress(request: req, isEdit: isEdit).then((value) {
                      finish(context, true);
                      appStore.setLoading(false);
                    }).catchError(onError);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// region Service List Widget
  Widget setAsPrimaryWidget() {
    return CheckboxListTile(
      value: isPrimary,
      title: Text('Set as primary',
          style: boldTextStyle(
              color:
                  appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor,
              size: 14)),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
      side: BorderSide(color: textSecondaryColorGlobal),
      dense: true,
      activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
      onChanged: (value) {
        isPrimary = !isPrimary;
        setState(() {});
      },
    );
  }
}
