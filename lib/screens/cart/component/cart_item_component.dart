import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/model_keys.dart';
import '../../product/view/product_detail_screen.dart';
import '../cart_repository.dart';
import '../model/cart_list_response.dart';
import '../view/cart_screen.dart';

class CartItemComponent extends StatefulWidget {
  final CartListData cartListData;

  CartItemComponent({required this.cartListData});

  @override
  _CartItemComponentState createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {
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

  Future<void> removeCart() async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: '${locale.areYouSureYouWantToRemove}?',
      positiveText: locale.remove,
      negativeText: locale.cancel,
      onAccept: (ctx) async {
        appStore.setLoading(true);

        await removeFromCart(cartId: widget.cartListData.id.validate()).then((value) {
          productStore.setCartItemCount(productStore.cartItemCount - 1);
          toast(value.message);
          appStore.setLoading(false);
          productStore.selectedVariationData.inCart = 0;

          onCartListUpdate.call();
          onProductDetailUpdate.call();
        }).catchError((error) {
          appStore.setLoading(false);
          toast(error.toString());
        });
      },
    );
  }

  Future<void> updateCartAPi() async {
    appStore.setLoading(true);

    Map request = {
      ProductModelKey.productId: widget.cartListData.productId,
      ProductModelKey.cartId: widget.cartListData.id,
      ProductModelKey.productVariationId: widget.cartListData.productVariationId,
      ProductModelKey.qty: widget.cartListData.qty,
    };

    await updateCart(request).then((value) {
      String message = '${locale.you}\'${locale.veChanged} ${widget.cartListData.productName} ${locale.quantityTo} ${widget.cartListData.qty}';
      if (message.length > 50) {
        message = message.substring(0, 47) + '...';
      }
      toast(message);
      appStore.setLoading(false);

      onCartListUpdate.call();
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageWidget(
                url: widget.cartListData.productImage.validate(),
                height: 75,
                width: 75,
                fit: BoxFit.cover,
                radius: defaultRadius,
              ),
              12.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cartListData.productName.validate(),
                        style: boldTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).expand(),
                      4.width,
                      Container(
                        padding: EdgeInsets.zero,
                        height: 20,
                        width: 20,
                        decoration: boxDecorationDefault(shape: BoxShape.circle, border: Border.all(color: textSecondaryColorGlobal), color: context.cardColor),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.close_rounded, color: textSecondaryColorGlobal, size: 18),
                          onPressed: () async {
                            /// Remove Cart Api
                            await removeCart();
                          },
                        ),
                      ),
                    ],
                  ),
                  if (widget.cartListData.productDescription.validate().isNotEmpty) 4.height,
                  if (widget.cartListData.productDescription.validate().isNotEmpty)
                    Text(
                      widget.cartListData.productDescription.validate(),
                      style: secondaryTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (widget.cartListData.productVariationValue != null) 4.height,
                  if (widget.cartListData.productVariationValue != null)
                    Row(
                      children: [
                        Text(
                          '${widget.cartListData.productVariationType}: ',
                          style: secondaryTextStyle(size: 14),
                        ),
                        Text(
                          widget.cartListData.productVariationName.validate(),
                          style: primaryTextStyle(size: 14),
                        ),
                      ],
                    ),
                ],
              ).expand(),
            ],
          ),
          12.height,
          Row(
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 26,
                width: 74,
                decoration: boxDecorationDefault(
                  color: appStore.isDarkMode ? territoryButtonColor : borderColor,
                  border: Border.all(color: appStore.isDarkMode ? territoryButtonColor : textSecondaryColorGlobal),
                  borderRadius: radius(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.remove, color: appStore.isDarkMode ? secondaryColor : appTextSecondaryColor, size: 14),
                      highlightColor: Colors.transparent,
                      onPressed: () async {
                        if (widget.cartListData.qty.validate() > 1) {
                          widget.cartListData.qty = widget.cartListData.qty.validate() - 1;
                        }

                        /// update cart api
                        updateCartAPi();

                        setState(() {});
                      },
                    ).expand(),
                    Text('${widget.cartListData.qty}', style: primaryTextStyle(color: Colors.black)),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add, color: appStore.isDarkMode ? secondaryColor : appTextSecondaryColor, size: 14),
                      highlightColor: Colors.transparent,
                      onPressed: () async {
                        widget.cartListData.qty = widget.cartListData.qty.validate() + 1;

                        /// update cart api
                        updateCartAPi();

                        setState(() {});
                      },
                    ).expand(),
                  ],
                ),
              ),
              16.width,
              if (widget.cartListData.productVariation != null)
                Marquee(
                  child: Row(
                    children: [
                      if (widget.cartListData.isDiscount) PriceWidget(
                        price: widget.cartListData.productVariation!.taxIncludeProductPrice.validate(),
                        isLineThroughEnabled: widget.cartListData.isDiscount ? true : false,
                        size: widget.cartListData.isDiscount ? 12 : 16,
                        color: widget.cartListData.isDiscount ? textSecondaryColorGlobal : null,
                      ),
                      if (widget.cartListData.isDiscount) 4.width,
                      PriceWidget(price: widget.cartListData.productVariation!.discountedProductPrice.validate()),
                      if (widget.cartListData.isDiscount) 8.width,
                      if (widget.cartListData.isDiscount) Text('${widget.cartListData.discountValue}% ${locale.off}', style: primaryTextStyle(color: greenColor)),
                    ],
                  ),
                ).expand(),
            ],
          ),
        ],
      ),
    );
  }
}
