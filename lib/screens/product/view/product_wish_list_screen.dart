import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../cart/component/cart_icon_btn.dart';
import '../component/product_item_component.dart';
import '../model/product_list_response.dart';
import '../product_repository.dart';

late VoidCallback onWishListUpdate;

class ProductWishListScreen extends StatefulWidget {
  final bool isFromProductDetail;

  ProductWishListScreen({this.isFromProductDetail = false});

  @override
  _ProductWishListScreenState createState() => _ProductWishListScreenState();
}

class _ProductWishListScreenState extends State<ProductWishListScreen> {
  Future<List<ProductData>>? future;

  List<ProductData> wishList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();

    onWishListUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false}) async {
    future = getWishList(
        userId: userStore.userId,
        page: page,
        list: wishList,
        lastPageCallBack: (p) {
          isLastPage = p;
        });

    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        finish(
          context,
        );
        return Future(() => false);
      },
      child: AppScaffold(
        appBarWidget: commonAppBarWidget(
          context,
          title: locale.wishlist,
          appBarHeight: 70,
          roundCornerShape: true,
          showLeadingIcon: true,
          actions: [
            CartIconBtnComponent(),
          ],
        ),
        body: SnapHelperWidget<List<ProductData>>(
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
          onSuccess: (wishlist) {
            if (wishlist.isEmpty) {
              return NoDataWidget(
                title: locale.noProductsFound,
                imageWidget: EmptyStateWidget(),
                subTitle: locale.thereAreCurrentlyNoItemsInYourWishlist,
                retryText: locale.reload,
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init(flag: true);
                },
              ).paddingSymmetric(horizontal: 16);
            }

            return AnimatedScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
              crossAxisAlignment: CrossAxisAlignment.start,
              physics: AlwaysScrollableScrollPhysics(),
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
                10.height,
                AnimatedWrap(
                  runSpacing: 16,
                  spacing: 16,
                  listAnimationType: ListAnimationType.FadeIn,
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    return ProductItemComponent(
                      productListData: wishlist[index],
                      isFromWishList: true,
                      isFromProductDetail: widget.isFromProductDetail,
                      // Pass a callback to update the state when wishlist changes
                      onWishlistUpdated: () {
                        setState(() {
                          wishList.removeAt(index); // Remove the item from the list
                        });
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
