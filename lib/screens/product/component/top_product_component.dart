import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../model/product_list_response.dart';

class TopProductComponent extends StatefulWidget {
  final List<ProductData> relatedProductData;

  TopProductComponent({required this.relatedProductData});

  @override
  State<TopProductComponent> createState() => _TopProductComponentState();
}

class _TopProductComponentState extends State<TopProductComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> onTapFavourite(ProductData relatedProductData) async {
    appStore.setLoading(true);

    if (relatedProductData.inWishlist == 1) {
      relatedProductData.inWishlist = 0;
      setState(() {});

      await removeFromWishList(productId: relatedProductData.id.validate()).then((value) {
        appStore.setLoading(false);
        if (!value) {
          relatedProductData.inWishlist = 0;
          setState(() {});
        }
      });
    } else {
      relatedProductData.inWishlist = 1;
      setState(() {});

      await addToWishList(productId: relatedProductData.id.validate()).then((value) {
        appStore.setLoading(false);
        if (!value) {
          relatedProductData.inWishlist = 1;
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.relatedProductData.isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.ourMostLoveChewTreats, isShowAll: false).paddingSymmetric(horizontal: 16),
        10.height,
        HorizontalList(
          padding: EdgeInsets.symmetric(horizontal: 16),
          runSpacing: 16,
          spacing: 16,
          itemCount: widget.relatedProductData.take(6).length,
          itemBuilder: (context, index) {
            ProductData data = widget.relatedProductData[index];
            return Container(
              width: context.width() / 2 - 24,
              decoration: boxDecorationDefault(color: context.cardColor),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          if (data.productImage.validate().isNotEmpty)
                            Container(
                              height: 120,
                              width: context.width(),
                              decoration: boxDecorationDefault(
                                image: DecorationImage(image: NetworkImage(data.productImage.validate()), fit: BoxFit.cover),
                              ),
                              child: ClipRRect(
                                borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                  child: Container(height: 120, width: context.width(), color: Colors.black.withOpacity(0.1)),
                                ),
                              ),
                            ),
                          Positioned(
                            child: ClipRRect(
                              borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
                              child: CachedImageWidget(
                                url: data.productImage.validate(),
                                width: context.width(),
                                height: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: context.cardColor),
                          child: data.inWishlist == 1 ? ic_fill_heart.iconImage(color: wishListColor, size: 18) : ic_heart.iconImage(color: textSecondaryColorGlobal, size: 18),
                        ).onTap(() {
                          doIfLoggedIn(context, () {
                            onTapFavourite(data);
                          });
                        }, highlightColor: Colors.transparent, splashColor: Colors.transparent, hoverColor: Colors.transparent),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(data.name.validate(), style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      6.height,
                      Marquee(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (data.isDiscount) PriceWidget(price: data.variationData.validate().first.discountedProductPrice.validate()),
                            if (data.isDiscount) 4.width,
                            PriceWidget(
                              price: data.variationData.validate().first.taxIncludeProductPrice.validate(),
                              isLineThroughEnabled: data.isDiscount ? true : false,
                              isBoldText: data.isDiscount ? false : true,
                              size: data.isDiscount ? 12 : 16,
                              color: data.isDiscount ? textSecondaryColorGlobal : null,
                            ).visible(data.variationData.validate().isNotEmpty),
                          ],
                        ),
                      ),
                      6.height,
                      RatingBarWidget(
                        onRatingChanged: (rating) {},
                        activeColor: getRatingBarColor(data.rating.validate().toInt()),
                        inActiveColor: ratingBarColor,
                        disable: true,
                        rating: data.rating.validate().toDouble(),
                        size: 12,
                      ),
                    ],
                  ).paddingAll(16),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
