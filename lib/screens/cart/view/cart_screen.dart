import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/price_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../cart_repository.dart';
import '../component/cart_item_component.dart';
import '../model/cart_list_response.dart';
import 'select_address_screen.dart';

late VoidCallback onCartListUpdate;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<(List<CartListData>, CartListResponse)>? future;

  (List<CartListData>, CartListResponse) cartList = ([], CartListResponse());

  int page = 1;

  bool isLastPage = false;

  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    init(flag: true);

    onCartListUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false}) async {
    future = getCartList(
      page: page,
      cartList: cartList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    ).whenComplete(() {
      if (flag) setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(context, title: locale.cart, appBarHeight: 70, showLeadingIcon: true, roundCornerShape: true),
      body: SnapHelperWidget(
        future: future,
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
        onSuccess: (cartList) {
          if (cartList.$1.isEmpty) {
            return NoDataWidget(
              title: locale.yourCartIsEmpty,
              subTitle: locale.thereAreCurrentlyNoItems,
              imageWidget: EmptyStateWidget(),
              retryText: locale.reload,
              onRetry: () {
                page = 1;
                appStore.setLoading(true);

                init(flag: true);
              },
            ).paddingSymmetric(horizontal: 16);
          }

          return Stack(
            children: [
              AnimatedScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 225, top: 20),
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
                  AnimatedListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartList.$1.length,
                    itemBuilder: (context, index) {
                      productStore.setCartListData(cartList.$1);
                      return CartItemComponent(cartListData: cartList.$1[index]);
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  decoration: boxDecorationDefault(
                    color: context.cardColor,
                    borderRadius: radiusOnly(topLeft: 20, topRight: 20),
                    boxShadow: [
                      BoxShadow(spreadRadius: 6, blurRadius: 10, offset: Offset(0, -1), color: context.dividerColor),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewAllLabel(label: locale.productPriceDetails, isShowAll: false),

                      /// Subtotal
                      if (cartList.$2.cartPriceData!.discountAmount != 0)
                        SettingItemWidget(
                          title: locale.subtotal,
                          titleTextStyle: secondaryTextStyle(),
                          padding: EdgeInsets.zero,
                          trailing: Marquee(
                            child: PriceWidget(
                              price: cartList.$2.cartPriceData!.taxIncludedAmount.validate(),
                              color: textPrimaryColorGlobal,
                              size: 14,
                            ),
                          ),
                        ),
                      10.height,

                      /// Discount
                      if (cartList.$2.cartPriceData!.discountAmount != 0)
                        SettingItemWidget(
                          title: locale.discount,
                          titleTextStyle: secondaryTextStyle(),
                          padding: EdgeInsets.zero,
                          trailing: Marquee(
                            child: PriceWidget(
                              price: cartList.$2.cartPriceData!.discountAmount.validate(),
                              color: Colors.green,
                              size: 14,
                              isBoldText: true,
                              isDiscountedPrice: true,
                            ),
                          ),
                        ).paddingBottom(10),

                      /// Total Amount
                      SettingItemWidget(
                        title: locale.totalAmount,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: PriceWidget(
                            price: cartList.$2.cartPriceData!.totalAmount.validate(),
                            color: textPrimaryColorGlobal,
                            size: 14,
                          ),
                        ),
                      ),
                      20.height,
                      AppButton(
                        width: context.width(),
                        child: Text(locale.next, style: boldTextStyle(color: Colors.white)),
                        color: secondaryColor,
                        onTap: () {
                          productStore.setCartPriceData(cartList.$2.cartPriceData!);
                          SelectAddressScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                        },
                      ),
                      20.height,
                    ],
                  ),
                ),
              ).visible(cartList.$1.isNotEmpty),
            ],
          );
        },
      ),
    );
  }
}
