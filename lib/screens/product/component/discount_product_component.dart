import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/product/component/product_item_component.dart';
import 'package:ifloriana/screens/product/model/product_list_response.dart';
import 'package:ifloriana/screens/product/view/product_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';

class DiscountProductComponent extends StatelessWidget {
  final List<ProductData> discountProductList;

  DiscountProductComponent({required this.discountProductList});

  @override
  Widget build(BuildContext context) {
    if (discountProductList.isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.dealsForYou,
          list: discountProductList,
          onTap: () {
            ProductListScreen(appBarTitleText: locale.dealsForYou, isBestDiscounts: '1').launch(context);
          },
        ).paddingOnly(left: 16, right: 8),
        HorizontalList(
          itemCount: discountProductList.length,
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
          crossAxisAlignment: WrapCrossAlignment.start,
          itemBuilder: (context, i) {
            return ProductItemComponent(productListData: discountProductList[i]).paddingRight(8);
          },
        )
      ],
    );
  }
}
