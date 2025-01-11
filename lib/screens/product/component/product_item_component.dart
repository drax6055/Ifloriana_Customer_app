import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../model/product_list_response.dart';
import '../view/product_detail_screen.dart';

class ProductItemComponent extends StatefulWidget {
  final ProductData productListData;
  final bool isFromWishList;
  final bool isFromProductDetail;
  final VoidCallback? onWishlistUpdated;

  ProductItemComponent({required this.productListData, this.isFromWishList = false, this.isFromProductDetail = false,this.onWishlistUpdated});

  @override
  State<ProductItemComponent> createState() => _ProductItemComponentState();
}

class _ProductItemComponentState extends State<ProductItemComponent> {
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

  Future<void> onTapFavourite() async {
    appStore.setLoading(true);

    if (widget.isFromWishList || widget.productListData.inWishlist == 1) {
      await removeFromWishList(
        productId: widget.isFromWishList ? null : widget.productListData.id.validate(),
        wishListId: widget.isFromWishList ? widget.productListData.id.validate() : null,
        isFromProductDetail: widget.isFromProductDetail,
      ).then((value) {
        appStore.setLoading(false);
        if (value) {
          widget.productListData.inWishlist = 0;
          widget.onWishlistUpdated?.call();
          setState(() {});
        }
      });
    } else {
      await addToWishList(productId: widget.productListData.id.validate()).then((value) {
        appStore.setLoading(false);
        if (value) {
          widget.productListData.inWishlist = 1;
          widget.onWishlistUpdated?.call();
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 2 - 24,
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
                child: CachedImageWidget(
                  url: widget.productListData.productImage.validate(),
                  width: context.width(),
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                left: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationWithShadow(boxShape: BoxShape.rectangle, backgroundColor: context.cardColor, borderRadius: radius(18)),
                      child: Marquee(child: Text(locale.outOfStock, style: boldTextStyle(size: 12, color: context.primaryColor))),
                    ).visible(widget.productListData.stockQty == 0),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: context.cardColor),
                      child: widget.productListData.inWishlist == 1 ? ic_fill_heart.iconImage(color: wishListColor, size: 16) : ic_heart.iconImage(color: textSecondaryColorGlobal, size: 16),
                    ).onTap(() {
                      doIfLoggedIn(context, () async {
                        onTapFavourite();
                      });
                    }, highlightColor: Colors.transparent, splashColor: Colors.transparent, hoverColor: Colors.transparent),
                  ],
                ),
              ),
            ],
          ),
          8.height,
          Column(
            children: [
              Text(widget.isFromWishList ? widget.productListData.productName.validate() : widget.productListData.name.validate(), style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
              6.height,
              Marquee(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.productListData.isDiscount) PriceWidget(price: widget.productListData.variationData.validate().first.discountedProductPrice.validate()),
                    if (widget.productListData.isDiscount) 4.width,
                    PriceWidget(
                      price: widget.productListData.variationData.validate().first.taxIncludeProductPrice.validate(),
                      isLineThroughEnabled: widget.productListData.isDiscount ? true : false,
                      isBoldText: widget.productListData.isDiscount ? false : true,
                      size: widget.productListData.isDiscount ? 12 : 16,
                      color: widget.productListData.isDiscount ? textSecondaryColorGlobal : null,
                    ).visible(widget.productListData.variationData.validate().isNotEmpty),
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          16.height,
        ],
      ),
    ).onTap(() async {
      final isAddedToWishlist = await ProductDetailScreen(productData: widget.productListData, isFromWishList: widget.isFromWishList).launch(context);
      if (isAddedToWishlist is int) {
        widget.productListData.inWishlist = isAddedToWishlist;
        setState(() {});
      }
    }, borderRadius: radius(), splashColor: Colors.transparent, highlightColor: Colors.transparent);
  }
}
