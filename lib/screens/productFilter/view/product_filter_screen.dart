import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../component/filter_category_component.dart';
import '../component/filter_gender_component.dart';
import '../component/filter_price_component.dart';
import '../component/filter_product_brand_component.dart';
import '../component/filter_rating_component.dart';
import '../component/filter_weight_component.dart';

class ProductFilterScreen extends StatefulWidget {
  @override
  _ProductFilterScreenState createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
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
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: 'Filter By',
        showLeadingIcon: true,
        roundCornerShape: true,
        appBarHeight: 70,
      ),
      body: Stack(
        children: [
          AnimatedScrollView(
            padding: EdgeInsets.only(bottom: 80, top: 16),
            children: [
              FilterGenderComponent(),
              16.height,
              FilterWeightComponent(),
              16.height,
              FilterCategoryComponent(),
              16.height,
              FilterPriceComponent(),
              8.height,
              FilterRatingComponent(),
              16.height,
              FilterProductBrandComponent(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                AppButton(
                  text: locale.clearFilter,
                  textColor: context.primaryColor,
                  shapeBorder: RoundedRectangleBorder(side: BorderSide(color: context.primaryColor), borderRadius: radius()),
                  onTap: () {
                    //
                  },
                ).expand(),
                16.width,
                AppButton(
                  text: locale.applyFilter,
                  textColor: Colors.white,
                  color: secondaryColor,
                  onTap: () {
                    hideKeyboard(context);
                  },
                ).expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
