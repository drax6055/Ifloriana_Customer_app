import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/screens/category/component/category_item_component.dart';
import 'package:ifloriana/screens/category/view/category_screen.dart';
import 'package:ifloriana/screens/services/view/view_all_service_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../booking/component/quick_book_component.dart';
import '../../category/model/category_response.dart';

class CategoryComponent extends StatefulWidget {
  final List<CategoryData>? categoryList;

  CategoryComponent({this.categoryList});

  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
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
    if (widget.categoryList.validate().isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.category,
          list: widget.categoryList,
          onTap: () {
            CategoryScreen().launch(context).then((value) {
              setStatusBarColor(Colors.transparent);
            });
          },
        ).paddingSymmetric(horizontal: 16),
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: widget.categoryList.validate().take(6).length,
          listAnimationType: ListAnimationType.FadeIn,
          scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
          itemBuilder: (_, index) {
            CategoryData? data = widget.categoryList.validate()[index];
            return GestureDetector(
              onTap: () {
                onQuickBookingDataUpdate?.call();
                bookingRequestStore.setCouponApplied(false);
                ViewAllServiceScreen(serviceTitle: data.name.validate(), categoryId: data.id.validate()).launch(context);
              },
              child: CategoryItemWidget(categoryData: data, width: context.width() / 3 - 22),
            );
          },
        ).paddingOnly(bottom: 16, left: 16, right: 16, top: 8),
      ],
    );
  }
}
