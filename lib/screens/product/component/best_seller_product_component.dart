import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/product/component/product_item_component.dart';
import 'package:ifloriana/screens/product/view/product_list_screen.dart';
import 'package:ifloriana/screens/product/model/product_list_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';

class BestSellerProductComponent extends StatelessWidget {
  final List<ProductData> bestSellerProductList;

  BestSellerProductComponent({required this.bestSellerProductList});

  @override
  Widget build(BuildContext context) {
    if (bestSellerProductList.isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        ViewAllLabel(
          label: locale.bestSellerProduct,
          list: bestSellerProductList,
          onTap: () {
            ProductListScreen(appBarTitleText: locale.bestSellerProduct, isBestSeller: '1').launch(context);
          },
        ).paddingOnly(left: 16, right: 8),
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: bestSellerProductList.take(6).length,
          listAnimationType: ListAnimationType.FadeIn,
          scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
          itemBuilder: (_, index) {
            return ProductItemComponent(productListData: bestSellerProductList[index]);
          },
        ).paddingOnly(top: 10, left: 16, right: 16, bottom: 16)
      ],
    );
  }
}
