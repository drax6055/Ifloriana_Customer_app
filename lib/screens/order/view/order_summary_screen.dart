import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/dotted_line.dart';
import '../../../components/price_widget.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../cart/model/cart_list_response.dart';
import '../../product/view/product_payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(context, title: locale.orderSummary, appBarHeight: 70, showLeadingIcon: true, roundCornerShape: true),
      body: Stack(
        children: [
          AnimatedScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
            children: [
              Container(
                width: context.width(),
                decoration: boxDecorationDefault(color: context.cardColor),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.shippingAddress, style: secondaryTextStyle(size: 14)),
                    8.height,
                    Text(productStore.fullName.validate(), style: boldTextStyle()),
                    Text(
                      '${productStore.addressData.addressLine1.validate()} ${productStore.addressData.addressLine2.validate()} ${productStore.addressData.cityName.validate()} - ${productStore.addressData.postalCode.validate()}',
                      style: primaryTextStyle(size: 12),
                    ),
                    Text(productStore.addressData.stateName.validate(), style: primaryTextStyle(size: 12)),
                    Text(productStore.addressData.countryName.validate(), style: primaryTextStyle(size: 12)),
                    Text(productStore.contactNumber.validate().trim(), style: primaryTextStyle()),
                    if (productStore.alternateContactNumber.trim().isNotEmpty) Text(productStore.alternateContactNumber.validate().trim(), style: primaryTextStyle()),
                  ],
                ),
              ),
              16.height,
              AnimatedWrap(
                runSpacing: 16,
                itemCount: productStore.productCartListData.length,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (context, index) {
                  CartListData productData = productStore.productCartListData.validate()[index];

                  return Container(
                    decoration: boxDecorationDefault(color: context.cardColor),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImageWidget(
                              url: productData.productImage.validate(),
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              radius: defaultRadius,
                            ),
                            12.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productData.productName.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                4.height,
                                Row(
                                  children: [
                                    Text('${locale.qty}: ', style: primaryTextStyle(size: 13)),
                                    Text(productData.qty.validate().toString(), style: primaryTextStyle()),
                                  ],
                                ),
                                if (productData.productVariationType.validate().isNotEmpty)
                                  Row(
                                    children: [
                                      Text('${productData.productVariationType.validate()}: ', style: primaryTextStyle(size: 13)),
                                      Text(productData.productVariationValue.validate(), style: primaryTextStyle()),
                                    ],
                                  ),
                                if (productData.productVariation != null)
                                  Marquee(
                                    child: Row(
                                      children: [
                                        PriceWidget(
                                          price: productData.productVariation!.taxIncludeProductPrice.validate(),
                                          isLineThroughEnabled: productData.isDiscount ? true : false,
                                          size: productData.isDiscount ? 12 : 16,
                                          color: productData.isDiscount ? textSecondaryColorGlobal : null,
                                        ),
                                        4.width,
                                        if (productData.isDiscount) PriceWidget(price: productData.productVariation!.discountedProductPrice.validate()),
                                        if (productData.isDiscount) 8.width,
                                        if (productData.isDiscount) Text('${productData.discountValue}% ${locale.off}', style: primaryTextStyle(color: greenColor)),
                                      ],
                                    ),
                                  ),
                              ],
                            ).expand(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              16.height,
              Container(
                decoration: boxDecorationDefault(color: context.cardColor),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewAllLabel(label: locale.priceDetails, isShowAll: false, labelSize: 14),

                    /// Subtotal
                    SettingItemWidget(
                      title: locale.subtotal,
                      titleTextStyle: secondaryTextStyle(),
                      padding: EdgeInsets.zero,
                      trailing: Marquee(
                        child: PriceWidget(
                          price: productStore.cartPriceData.taxIncludedAmount.validate(),
                          color: textPrimaryColorGlobal,
                          size: 14,
                        ),
                      ),
                    ),
                    10.height,

                    /// Discount
                    if (productStore.cartPriceData.discountAmount != 0)
                      SettingItemWidget(
                        title: locale.discount,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: PriceWidget(
                            price: productStore.cartPriceData.discountAmount.validate(),
                            color: Colors.green,
                            size: 14,
                            isBoldText: true,
                            isDiscountedPrice: true,
                          ),
                        ),
                      ).paddingBottom(10),

                    /// Discount Amount
                    if (productStore.cartPriceData.taxIncludedAmount != productStore.cartPriceData.totalAmount)
                      SettingItemWidget(
                        title: locale.discountedAmount,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: PriceWidget(
                            price: productStore.cartPriceData.totalAmount.validate(),
                            color: textPrimaryColorGlobal,
                            size: 14,
                            isBoldText: true,
                          ),
                        ),
                      ).paddingBottom(10),

                    /// Total Tax Amount
                    if (productStore.cartPriceData.taxAmount != 0)
                      SettingItemWidget(
                        title: locale.tax,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: PriceWidget(
                            price: productStore.cartPriceData.taxAmount.validate(),
                            size: 14,
                            color: textPrimaryColorGlobal,
                            isBoldText: true,
                          ),
                        ),
                      ),
                    if (productStore.cartPriceData.taxAmount != 0) 10.height,

                    /// Delivery Charge
                    if (productStore.logisticZoneData.standardDeliveryCharge != 0)
                      SettingItemWidget(
                        title: locale.deliveryCharge,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: PriceWidget(
                            price: productStore.logisticZoneData.standardDeliveryCharge.validate(),
                            size: 14,
                            color: textPrimaryColorGlobal,
                            isBoldText: true,
                          ),
                        ),
                      ),
                    if (productStore.logisticZoneData.standardDeliveryCharge != 0) 10.height,
                    8.height,

                    DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
                    10.height,

                    /// Total Amount
                    SettingItemWidget(
                      title: locale.total,
                      titleTextStyle: secondaryTextStyle(),
                      padding: EdgeInsets.zero,
                      trailing: Marquee(
                        child: PriceWidget(price: productStore.totalAmount, color: primaryColor, size: 14),
                      ),
                    ),
                    16.height,
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: context.width(),
              child: Text(locale.proceed, style: boldTextStyle(color: Colors.white)),
              color: secondaryColor,
              onTap: () {
                ProductPaymentScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
              },
            ),
          ),
        ],
      ),
    );
  }
}
