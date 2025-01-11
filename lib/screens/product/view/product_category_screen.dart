import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../category/component/category_item_component.dart';
import '../../category/model/category_response.dart';
import '../product_repository.dart';
import 'product_list_screen.dart';

class ProductCategoryScreen extends StatefulWidget {
  @override
  _ProductCategoryScreenState createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  Future<List<CategoryData>>? future;

  List<CategoryData> productCategoryList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    future = getProductCategory(
      page: page,
      list: productCategoryList,
      isStoreCached: true,
      lastPageCallBack: (val) {
        isLastPage = val;
      },
    );

    if (flag) setState(() {});
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
        title: locale.allCategories,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: SnapHelperWidget<List<CategoryData>>(
        future: future,
        initialData: productCategoryListCached,
        loadingWidget: LoaderWidget(),
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            retryText: locale.reload,
            imageWidget: ErrorStateWidget(),
            onRetry: () {
              page = 1;
              appStore.setLoading(true);

              init(flag: true);
            },
          );
        },
        onSuccess: (list) {
          if (list.isEmpty) {
            return NoDataWidget(
              title: locale.noCategoryFound,
              subTitle: locale.thereAreNoCategories,
              imageWidget: EmptyStateWidget(),
              retryText: locale.reload,
              onRetry: () {
                page = 1;
                appStore.setLoading(true);

                init(flag: true);
              },
            ).paddingSymmetric(horizontal: 16);
          }

          return AnimatedScrollView(
            onSwipeRefresh: () async {
              page = 1;

              init(flag: true);

              return await 2.seconds.delay;
            },
            physics: AlwaysScrollableScrollPhysics(),
            listAnimationType: ListAnimationType.Scale,
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            onNextPage: () {
              if (!isLastPage) {
                page++;
                appStore.setLoading(true);

                init(flag: true);
              }
            },
            children: [
              AnimatedWrap(
                runSpacing: 16,
                spacing: 16,
                itemCount: list.length,
                listAnimationType: ListAnimationType.Scale,
                scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
                itemBuilder: (_, index) {
                  CategoryData? data = list[index];
                  return GestureDetector(
                    onTap: () {
                      ProductListScreen(productCategoryID: data.id, appBarTitleText: data.name).launch(context);
                    },
                    child: CategoryItemWidget(categoryData: data, width: context.width() / 3 - 22),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
