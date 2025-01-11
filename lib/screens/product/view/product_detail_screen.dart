import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/screens/product/model/product_detail_response.dart';
import 'package:ifloriana/screens/product/view/product_wish_list_screen.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/back_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../../utils/model_keys.dart';
import '../../cart/cart_repository.dart';
import '../../cart/component/cart_icon_btn.dart';
import '../../cart/view/cart_screen.dart';
import '../component/product_description_component.dart';
import '../component/product_info_component.dart';
import '../component/product_packet_component.dart';
import '../component/product_quantity_component.dart';
import '../component/product_rating_review_component.dart';
import '../component/product_slider_component.dart';
import '../component/top_product_component.dart';
import '../model/product_list_response.dart';
import '../product_repository.dart';

late VoidCallback onProductDetailUpdate;

class ProductDetailScreen extends StatefulWidget {
  final ProductData productData;
  final bool isFromWishList;

  ProductDetailScreen({required this.productData, this.isFromWishList = false});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<ProductDetailResponse>? future;

  ProductDetailResponse productDetailRes = ProductDetailResponse();

  @override
  void initState() {
    super.initState();
    init();
    setStatusBarColor(Colors.transparent);

    onProductDetailUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false}) async {
    /// Product Detail Api
    future = getProductDetail(
      productId: widget.isFromWishList ? widget.productData.productId.validate() : widget.productData.id.validate(),
      userId: appStore.isLoggedIn ? userStore.userId : null,
      onResult: (value) {
        productDetailRes = value;
        if (productDetailRes.data!.variationData.validate().isNotEmpty) {
          productStore.setSelectedVariationData(productDetailRes.data!.variationData.validate().first);
        }
      },
    );

    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> onTapFavourite(ProductData data) async {
    appStore.setLoading(true);

    if (data.inWishlist == 1) {
      data.inWishlist = 0;
      setState(() {});

      await removeFromWishList(productId: data.id.validate()).then((value) {
        appStore.setLoading(false);
        if (!value) {
          data.inWishlist = 0;
          setState(() {});
        }
      });
    } else {
      data.inWishlist = 1;
      setState(() {});

      await addToWishList(productId: data.id.validate()).then((value) {
        appStore.setLoading(false);
        if (!value) {
          data.inWishlist = 1;
          setState(() {});
        }
      });
    }
  }

  Widget actionsWidget({required Widget widget, VoidCallback? onTap}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: context.cardColor),
      child: widget,
    ).onTap(() {
      onTap?.call();
    }, highlightColor: Colors.transparent, splashColor: Colors.transparent, hoverColor: Colors.transparent);
  }

  Future<void> addProductToCart() async {
    appStore.setLoading(true);

    Map request = {
      ProductModelKey.productId: widget.productData.id.toString(),
      ProductModelKey.productVariationId: productStore.selectedVariationData.id,
      ProductModelKey.qty: productStore.qty,
      ProductModelKey.locationId: 1,
    };

    await addToCart(request).then((value) {
      toast(value.message);
      productStore.setCartItemCount(productStore.cartItemCount + 1);
      appStore.setLoading(false);
      productStore.selectedVariationData.inCart = IN_CART;

      init(flag: true);

      CartScreen().launch(context);
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        finish(context, productDetailRes.data!.inWishlist.validate());
        return Future(() => false);
      },
      child: AppScaffold(
        showAppBar: false,
        body: SnapHelperWidget<ProductDetailResponse>(
          future: future,
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
            if (snap.data == null) {
              return NoDataWidget(
                title: locale.noDetailsFound,
                retryText: locale.reload,
                onRetry: () {
                  appStore.setLoading(true);

                  init(flag: true);
                },
              );
            }

            return Stack(
              children: [
                AnimatedScrollView(
                  listAnimationType: ListAnimationType.FadeIn,
                  padding: EdgeInsets.only(bottom: 85),
                  children: [
                    ProductSliderComponent(productGallaryData: snap.data!.productGallaryData.validate()),
                    16.height,
                    ProductInfoComponent(productData: snap.data!),
                    ProductPacketComponent(productData: snap.data!),
                    if (productStore.selectedVariationData.productStockQty != 0) ProductQuantityComponent(),
                    16.height,
                    ProductDescriptionComponent(productData: snap.data!),
                    20.height,
                    ProductRatingReviewComponent(reviewDetails: snap.data!.productReview.validate(), productReviewData: snap.data!),
                    20.height,
                    TopProductComponent(relatedProductData: snap.relatedProduct.validate()),
                    20.height,
                  ],
                  onSwipeRefresh: () async {
                    init(flag: true);

                    return await 2.seconds.delay;
                  },
                ),
                Positioned(
                  top: context.statusBarHeight + 8,
                  left: 16,
                  child: Container(
                    child: BackWidget(
                      iconColor: context.iconColor,
                      onPressed: () {
                        finish(context, productDetailRes.data!.inWishlist.validate());
                        return Future(() => false);
                      },
                    ),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.cardColor),
                  ).scale(scale: 0.86),
                ),
                Positioned(
                  top: context.statusBarHeight + 8,
                  right: 8,
                  child: Row(
                    children: [
                      actionsWidget(
                        widget: ic_heart.iconImage(size: 25, color: textSecondaryColorGlobal),
                        onTap: () {
                          doIfLoggedIn(context, () async {
                            ProductWishListScreen(isFromProductDetail: true).launch(context);
                          });
                        },
                      ),
                      8.width,
                      CartIconBtnComponent(cartIconColor: textSecondaryColorGlobal, showBGCardColor: true),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: SizedBox(
                    width: context.width(),
                    child: Row(
                      children: [
                        AppButton(
                          color: context.cardColor,
                          width: 45,
                          height: 46,
                          splashColor: context.cardColor,
                          padding: EdgeInsets.zero,
                          child: snap.data!.inWishlist == 1 ? ic_fill_heart.iconImage(color: wishListColor, size: 26, fit: BoxFit.contain) : ic_heart.iconImage(color: primaryColor, size: 26),
                          onTap: () {
                            doIfLoggedIn(context, () {
                              onTapFavourite(snap.data!);
                            });
                          },
                        ).expand(),
                        16.width,
                        Observer(builder: (context) {
                          return AppButton(
                            color: productStore.selectedVariationData.productStockQty == 0 ? null : context.primaryColor,
                            width: 45,
                            height: 47,
                            enabled: productStore.selectedVariationData.productStockQty == 0 ? false : true,
                            disabledColor: productStore.selectedVariationData.productStockQty == 0 ? context.primaryColor.withOpacity(0.8) : null,
                            splashColor: context.primaryColor,
                            padding: EdgeInsets.zero,
                            child: Text(
                              productStore.selectedVariationData.inCart == IN_CART ? locale.goToCart : locale.addToCart,
                              style: boldTextStyle(color: productStore.selectedVariationData.productStockQty == 0 ? Colors.white70 : Colors.white),
                            ),
                            onTap: () {
                              doIfLoggedIn(context, () async {
                                if (productStore.selectedVariationData.inCart == IN_CART) {
                                  CartScreen().launch(context);
                                } else {
                                  /// Add To Cart Api
                                  await addProductToCart();
                                }
                              });
                            },
                          ).expand(flex: 2);
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
