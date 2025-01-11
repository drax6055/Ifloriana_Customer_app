import 'package:flutter/material.dart';
import 'package:ifloriana/screens/product/component/product_item_component.dart';
import 'package:ifloriana/screens/product/model/product_list_response.dart';
import 'package:ifloriana/screens/product/view/product_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';

class FeaturedProductComponent extends StatelessWidget {
  final List<ProductData> featuredProductList;

  FeaturedProductComponent({required this.featuredProductList});

  @override
  Widget build(BuildContext context) {
    if (featuredProductList.isEmpty)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: NoDataWidget(title: locale.noProductsFound, imageWidget: EmptyStateWidget()),
      );

    return Container(
      padding: EdgeInsets.only(bottom: 16),
      width: context.width(),
      decoration: BoxDecoration(color: appStore.isDarkMode ? context.cardColor : context.primaryColor.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          ViewAllLabel(
            label: locale.featured,
            list: featuredProductList,
            onTap: () {
              ProductListScreen(appBarTitleText: locale.featured, isFeatured: '1').launch(context);
            },
          ).paddingOnly(left: 16, right: 8),
          HorizontalList(
            itemCount: featuredProductList.take(6).length,
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
            crossAxisAlignment: WrapCrossAlignment.start,
            itemBuilder: (_, i) {
              return ProductItemComponent(productListData: featuredProductList[i]).paddingRight(8);
            },
          ),
        ],
      ),
    );
  }
}
