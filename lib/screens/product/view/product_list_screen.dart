import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/screens/product/component/product_item_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/back_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../model/product_list_response.dart';
import '../product_repository.dart';

late VoidCallback onProductListUpdate;

class ProductListScreen extends StatefulWidget {
  final int? productCategoryID;
  final String? appBarTitleText;
  final String isFeatured;
  final String isBestSeller;
  final String isBestDiscounts;

  ProductListScreen({this.productCategoryID, this.appBarTitleText, this.isFeatured = '', this.isBestSeller = '', this.isBestDiscounts = ''});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController searchProductCont = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  Future<List<ProductData>>? future;

  List<ProductData> productList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();

    onProductListUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false, String search = ''}) async {
    future = getProductList(
      categoryId: widget.productCategoryID != null ? widget.productCategoryID.toString() : '',
      isFeatured: widget.isFeatured,
      bestSeller: widget.isBestSeller,
      bestDiscount: widget.isBestDiscounts,
      search: searchProductCont.text.trim(),
      page: page,
      products: productList,
      lastPageCallBack: (p) {
        isLastPage = p;
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
      appBarWidget: PreferredSize(
        preferredSize: Size(context.width(), 100),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: context.width(),
              height: 150,
              decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20), backgroundColor: context.primaryColor),
              child: appBarWidget(
                widget.appBarTitleText.validate(),
                textColor: white,
                backWidget: BackWidget(),
                center: true,
                color: context.primaryColor,
                textSize: APPBAR_TEXT_SIZE,
              ).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
            ),
            Positioned(
              bottom: -20,
              left: 20,
              right: 20,
              child: AppTextField(
                textFieldType: TextFieldType.OTHER,
                focus: myFocusNode,
                controller: searchProductCont,
                suffix: CloseButton(
                  onPressed: () {
                    page = 1;
                    searchProductCont.clear();

                    appStore.setLoading(true);
                    init(flag: true);
                  },
                ).visible(searchProductCont.text.isNotEmpty),
                onFieldSubmitted: (s) {
                  page = 1;

                  appStore.setLoading(true);

                  init(flag: true);
                },
                decoration: inputDecoration(context, hint: locale.searchForProduct, prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal)),
              ),
            ),
          ],
        ),
      ),
      body: SnapHelperWidget<List<ProductData>>(
        future: future,
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
        loadingWidget: LoaderWidget(),
        onSuccess: (productList) {
          if (productList.isEmpty) {
            return NoDataWidget(
              title: locale.noProductsFound,
              retryText: locale.reload,
              onRetry: () {
                page = 1;
                appStore.setLoading(true);

                init(flag: true);
              },
            );
          }

          return AnimatedScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30),
            onSwipeRefresh: () async {
              page = 1;

              init(flag: true);

              return await 2.seconds.delay;
            },
            onNextPage: () {
              if (!isLastPage) {
                page++;
                appStore.setLoading(true);

                init(flag: true);
              }
            },
            children: [
              AnimatedWrap(
                itemCount: productList.length,
                spacing: 16,
                runSpacing: 16,
                itemBuilder: (context, index) {
                  return ProductItemComponent(productListData: productList[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
