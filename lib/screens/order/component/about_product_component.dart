import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../cart/model/cart_list_response.dart';
import 'order_review_component.dart';

class AboutProductComponent extends StatelessWidget {
  final List<CartListData> orderList;
  final String? deliveryStatus;

  AboutProductComponent({required this.orderList, this.deliveryStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.aboutProduct, isShowAll: false),
        AnimatedWrap(
          runSpacing: 16,
          itemCount: orderList.validate().length,
          itemBuilder: (context, index) {
            CartListData orderData = orderList.validate()[index];

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
                        url: orderData.productImage.validate(),
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                        radius: defaultRadius,
                      ),
                      12.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(orderData.productName.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                          4.height,
                          Row(
                            children: [
                              Text('${locale.qty}: ', style: secondaryTextStyle(size: 13)),
                              Text(orderData.qty.validate().toString(), style: primaryTextStyle()),
                            ],
                          ),
                          if (orderData.productVariationType != null)
                            Row(
                              children: [
                                Text('${orderData.productVariationType.validate()}: ', style: primaryTextStyle(size: 13)),
                                Text(orderData.productVariationValue.validate(), style: primaryTextStyle()),
                              ],
                            ),
                          PriceWidget(price: orderData.getProductPrice.validate()),
                        ],
                      ).expand(),
                    ],
                  ),
                  OrderReviewComponent(
                    deliveryStatus: deliveryStatus,
                    productId: orderData.productId.validate(),
                    productVariationId: orderData.productVariationId.validate(),
                    productReview: orderData.productReviewData,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
