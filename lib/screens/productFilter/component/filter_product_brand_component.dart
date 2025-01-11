import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../utils/colors.dart';

class FilterProductBrandComponent extends StatefulWidget {
  @override
  _FilterProductBrandComponentState createState() => _FilterProductBrandComponentState();
}

class _FilterProductBrandComponentState extends State<FilterProductBrandComponent> {
  TextEditingController searchProductCont = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  List<String> brandImageList = [brand_1, brand_2, brand_3, brand_4, brand_5, brand_6, brand_7, brand_8, brand_1, brand_2];

  int selectBrandIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: '${locale.productBrands}:', labelTextStyle: boldTextStyle(), isShowAll: false).paddingSymmetric(horizontal: 16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: boxDecorationDefault(color: context.cardColor),
          child: Column(
            children: [
              AppTextField(
                textFieldType: TextFieldType.OTHER,
                focus: searchFocusNode,
                controller: searchProductCont,
                decoration: InputDecoration(
                    label: Text(locale.searchBrand, style: secondaryTextStyle()).paddingLeft(8),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal),
                    prefixIconConstraints: BoxConstraints.loose(Size.fromWidth(22))),
                suffix: CloseButton(
                  onPressed: () {
                    hideKeyboard(context);
                    searchProductCont.clear();
                    setState(() {});
                  },
                ).visible(searchProductCont.text.isNotEmpty),
                onFieldSubmitted: (s) {
                  //
                },
              ),
              22.height,
              AnimatedWrap(
                runSpacing: 16,
                spacing: 16,
                children: List.generate(brandImageList.length, (index) {
                  if (index == 8) {
                    return TextButton(
                      onPressed: () {},
                      style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                      child: Text('+36 ${locale.more}', style: boldTextStyle(color: primaryColor, decoration: TextDecoration.underline))
                    );
                  } else if (index >= 9) {
                    return Offstage();
                  } else {
                    return Container(
                      width: context.width() / 3 - 32,
                      decoration: boxDecorationDefault(
                        color: appStore.isDarkMode ? lavender.withOpacity(0.6) : lavender,
                        border: Border.all(color: selectBrandIndex == index ? context.primaryColor : Colors.transparent, width: appStore.isDarkMode ? 2 : 1),
                      ),
                      child: CachedImageWidget(url: brandImageList[index], width: context.width(), height: 35),
                    ).onTap(() {
                      selectBrandIndex = index;
                      setState(() {});
                    });
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
