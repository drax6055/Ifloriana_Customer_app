import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/screens/product/view/product_wish_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../store/product_store.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../cart/cart_repository.dart';
import '../../cart/component/cart_icon_btn.dart';
import '../../cart/model/cart_list_response.dart';
import '../component/best_seller_product_component.dart';
import '../component/discount_product_component.dart';
import '../component/featured_product_component.dart';
import '../component/product_category_component.dart';
import '../component/product_item_component.dart';
import '../model/product_dashboard_response.dart';
import '../model/product_list_response.dart';
import '../product_repository.dart';

late VoidCallback onProductDashboardUpdate;

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin {
  TextEditingController searchProductCont = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  Future<ProductDashboardResponse>? future;

  ///Search
  Future<List<ProductData>>? searchFuture;

  List<ProductData> productList = [];
  (List<CartListData>, CartListResponse) cartList = ([], CartListResponse());

  int page = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
    if (appStore.isLoggedIn) getCartList(cartList: cartList);
    onProductDashboardUpdate = () {
      init(flag: true);
    };
  }

  void handleSearch({bool flag = false}) async {
    searchFuture = getProductList(
      search: searchProductCont.text.trim(),
      page: page,
      products: productList,
      lastPageCallBack: (p) {
        isLastPage = p;
      },
    ).whenComplete(() {
      if (flag) setState(() {});
    });
  }

  void init({bool flag = false}) async {
    future = productDashboard(userId: appStore.isLoggedIn ? userStore.userId : null);

    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
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
                locale.shop,
                center: true,
                showBack: false,
                color: context.primaryColor,
                textColor: white,
                textSize: APPBAR_TEXT_SIZE,
                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite_border_outlined, color: Colors.white),
                    onPressed: () async {
                      doIfLoggedIn(context, () {
                        ProductWishListScreen().launch(context);
                      });
                    },
                  ),
                  CartIconBtnComponent(),
                ],
              ).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
            ),
            Positioned(
              bottom: -20,
              left: 20,
              right: 20,
              child: AppTextField(
                textFieldType: TextFieldType.OTHER,
                focus: searchFocusNode,
                controller: searchProductCont,
                suffix: CloseButton(
                  onPressed: () {
                    hideKeyboard(context);
                    searchProductCont.clear();

                    setState(() {});
                  },
                ).visible(searchProductCont.text.trim().isNotEmpty),
                onFieldSubmitted: (s) {
                  appStore.setLoading(true);
                  handleSearch(flag: true);
                },
                decoration: inputDecoration(context, hint: locale.searchForProduct, prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal)),
              ),
            ),
          ],
        ),
      ),
      body: searchProductCont.text.trim().isNotEmpty
          ? SnapHelperWidget<List<ProductData>>(
              future: searchFuture,
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
            )
          : SnapHelperWidget<ProductDashboardResponse>(
              future: future,
              initialData: productDashboardResponseCached,
              loadingWidget: LoaderWidget(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.reload,
                  imageWidget: ErrorStateWidget(),
                  onRetry: () {
                    appStore.setLoading(true);

                    init(flag: true);
                  },
                );
              },
              onSuccess: (snap) {
                if (snap.data == null || snap.data!.category.validate().isEmpty) {
                  return NoDataWidget(
                    title: locale.atThisTimeThere,
                    retryText: locale.reload,
                    imageWidget: EmptyStateWidget(),
                    onRetry: () {
                      appStore.setLoading(true);

                      init();
                      setState(() {});
                    },
                  );
                }

                return AnimatedScrollView(
                  padding: EdgeInsets.only(top: 30),
                  listAnimationType: ListAnimationType.FadeIn,
                  onSwipeRefresh: () async {
                    init(flag: true);

                    return await 2.seconds.delay;
                  },
                  children: [
                    /// Product Category Component
                    ProductCategoryComponent(productCategoryList: snap.data!.category.validate()),

                    /// Featured Product Component
                    FeaturedProductComponent(featuredProductList: snap.data!.featuredProduct.validate()),

                    /// Best Seller Product Component
                    BestSellerProductComponent(bestSellerProductList: snap.data!.bestsellerProduct.validate()),

                    /// Discount Product Component
                    DiscountProductComponent(discountProductList: snap.data!.discountProduct.validate()),
                  ],
                );
              },
            ),
    );
  }
}
