import 'package:flutter/material.dart';
import 'package:ifloriana/screens/product/view/product_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../category/component/category_item_component.dart';
import '../../category/model/category_response.dart';
import '../view/product_category_screen.dart';

class ProductCategoryComponent extends StatelessWidget {
  final List<CategoryData> productCategoryList;

  ProductCategoryComponent({required this.productCategoryList});

  @override
  Widget build(BuildContext context) {
    if (productCategoryList.isEmpty)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: NoDataWidget(title: locale.noCategoryFound, imageWidget: EmptyStateWidget()),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.category,
          list: productCategoryList,
          onTap: () {
            ProductCategoryScreen().launch(context).then((value) {
              setStatusBarColor(Colors.transparent);
            });
          },
        ).paddingOnly(left: 16, right: 8),
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: productCategoryList.take(6).length,
          listAnimationType: ListAnimationType.FadeIn,
          scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
          itemBuilder: (_, index) {
            CategoryData? data = productCategoryList[index];
            return GestureDetector(
              onTap: () {
                ProductListScreen(productCategoryID: data.id, appBarTitleText: data.name).launch(context);
              },
              child: CategoryItemWidget(categoryData: data, width: context.width() / 3 - 22),
            );
          },
        ).paddingOnly(top: 10, left: 16, right: 16, bottom: 32)
      ],
    );
  }
}
