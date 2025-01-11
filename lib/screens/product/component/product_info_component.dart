import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/product_list_response.dart';

class ProductInfoComponent extends StatelessWidget {
  final ProductData productData;

  ProductInfoComponent({required this.productData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(productData.name.validate(), style: boldTextStyle(size: 18)),
          4.height,
          if (productData.shortDescription.validate().isNotEmpty) Text(productData.shortDescription.validate(), style: secondaryTextStyle()),
          8.height,
          Text('${productData.brandName.validate()} ${locale.brand}', style: boldTextStyle(color: appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor)),
          16.height,
          Observer(builder: (context) {
            return Row(
              children: [
                if (productData.isDiscount)
                  PriceWidget(
                    price: productStore.selectedVariationData.discountedProductPrice.validate(),
                  ),
                if (productData.isDiscount) 4.width,
                PriceWidget(
                  price: productStore.selectedVariationData.taxIncludeProductPrice.validate(),
                  isLineThroughEnabled: productData.isDiscount ? true : false,
                  isBoldText: productData.isDiscount ? false : true,
                  size: productData.isDiscount ? 14 : 16,
                  color: productData.isDiscount ? textSecondaryColorGlobal : null,
                ),
                if (productData.isDiscount) 8.width,
                if (productData.isDiscount)
                  Text(productData.discountType == TaxType.FIXED ? "${leftCurrencyFormat()}${productData.discountValue}${rightCurrencyFormat()} off" : '${productData.discountValue}% off', style: primaryTextStyle(color: greenColor)),
              ],
            );
          }),
          16.height,
          Row(
            children: [
              RatingBarWidget(
                onRatingChanged: (rating) {},
                disable: true,
                activeColor: getRatingBarColor(productData.rating.validate().toInt()),
                inActiveColor: ratingBarColor,
                rating: productData.rating.validate().toDouble(),
                size: 18,
              ),
              if (productData.rating != 0) 8.width,
              if (productData.rating != 0) Text(productData.rating.toString(), style: primaryTextStyle()),
            ],
          ),
          if (productStore.selectedVariationData.productStockQty == 0) 16.height,
          if (productStore.selectedVariationData.productStockQty == 0) Text(locale.outOfStock, style: boldTextStyle(color: wishListColor)),
        ],
      ),
    );
  }
}
