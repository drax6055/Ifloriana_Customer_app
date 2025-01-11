import 'package:flutter/material.dart';
import 'package:ifloriana/screens/order/component/order_list_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../cart/model/cart_list_response.dart';
import '../model/order_detail_response.dart';
import '../order_repository.dart';
import '../view/order_detail_screen.dart';

class OrderItemComponent extends StatelessWidget {
  final OrderListData getOrderData;

  OrderItemComponent({required this.getOrderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: getOrderData.orderCode != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
            children: [
              if (getOrderData.orderCode != null)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: getOrderData.deliveryStatus == OrderStatusConst.DELIVERED ? primaryColor : territoryButtonColor,
                    borderRadius: radiusOnly(topLeft: defaultRadius),
                  ),
                  child: Text(
                    getOrderData.orderCode.validate(),
                    style: boldTextStyle(color: getOrderData.deliveryStatus == OrderStatusConst.DELIVERED ? Colors.white : secondaryColor, size: 12),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: getOrderData.deliveryStatus == OrderStatusConst.DELIVERED ? secondaryColor : territoryButtonColor,
                  borderRadius: radiusOnly(topRight: defaultRadius),
                ),
                child: PriceWidget(
                  price: getOrderData.totalAmount.validate(),
                  color: getOrderData.deliveryStatus == OrderStatusConst.DELIVERED ? Colors.white : secondaryColor,
                  size: 14,
                ),
              ),
            ],
          ),
          12.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedWrap(
                itemCount: getOrderData.productDetails.validate().length,
                itemBuilder: (context, index) {
                  CartListData orderListData = getOrderData.productDetails.validate()[index];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedImageWidget(
                        url: orderListData.productImage.validate(),
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                        radius: defaultRadius,
                      ),
                      12.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(orderListData.productName.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                          if (orderListData.productVariationType != null)
                            Row(
                              children: [
                                Text('${orderListData.productVariationType}: ', style: secondaryTextStyle()),
                                Text(orderListData.productVariationValue.validate(), style: primaryTextStyle(size: 14)),
                              ],
                            ),
                          Row(
                            children: [
                              Text('Qty: ', style: secondaryTextStyle()),
                              Text(orderListData.qty.validate().toString(), style: primaryTextStyle(size: 14)),
                            ],
                          ),
                          Marquee(
                            child: Row(
                              children: [
                                PriceWidget(
                                  price: orderListData.taxIncludeProductPrice.validate(),
                                  isLineThroughEnabled: orderListData.isDiscount ? true : false,
                                  size: orderListData.isDiscount ? 12 : 16,
                                  color: orderListData.isDiscount ? textSecondaryColorGlobal : null,
                                ),
                                4.width,
                                if (orderListData.isDiscount) PriceWidget(price: orderListData.getProductPrice.validate()),
                                if (orderListData.isDiscount) 8.width,
                                if (orderListData.isDiscount) Text('${orderListData.discountValue.validate()}% off', style: primaryTextStyle(color: greenColor)),
                              ],
                            ),
                          ),
                        ],
                      ).expand(),
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 16);
                },
              ),
            ],
          ),
          8.height,
          Divider(color: context.dividerColor),
          2.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.payment, style: secondaryTextStyle()),
              Text('${getOrderData.paymentStatus.capitalizeFirstLetter()}', style: boldTextStyle(color: wishListColor)),
            ],
          ).paddingSymmetric(horizontal: 16),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.deliveryStatus, style: secondaryTextStyle()),
              Text('${getOrderBookingStatus(status: getOrderData.deliveryStatus.validate()).capitalizeFirstLetter()}', style: boldTextStyle(color: Colors.green)),
            ],
          ).paddingSymmetric(horizontal: 16),
          10.height,
          if ((getOrderData.deliveryStatus == OrderStatusConst.ORDER_PLACED || getOrderData.deliveryStatus == OrderStatusConst.PROCESSING || getOrderData.deliveryStatus == OrderStatusConst.PENDING) &&
              getOrderData.paymentStatus == SERVICE_PAYMENT_STATUS_UNPAID)
            AppButton(
              text: locale.cancelOrder,
              padding: EdgeInsets.symmetric(vertical: 12),
              width: context.width(),
              textColor: secondaryColor,
              color: quaternaryButtonColor,
              elevation: 0,
              onTap: () {
                showConfirmDialogCustom(
                  context,
                  title: '${locale.doYouWantToCancel}?',
                  primaryColor: context.primaryColor,
                  positiveText: locale.yes,
                  negativeText: locale.cancel,
                  dialogType: DialogType.DELETE,
                  onAccept: (_) {
                    appStore.setLoading(true);

                    orderUpdate(orderId: getOrderData.id.validate()).then((value) {
                      onOrderListUpdate.call('');
                      appStore.setLoading(false);
                      toast(locale.theOrderHasBeenCancelled);
                    }).catchError((e) {
                      appStore.setLoading(false);
                      toast(e.toString());
                    });
                  },
                );
              },
            ).paddingSymmetric(horizontal: 16, vertical: 8)
          else
            Offstage(),
          16.height,
        ],
      ),
    ).onTap(() {
      hideKeyboard(context);
      OrderDetailScreen(orderId: getOrderData.id.validate(), orderCode: getOrderData.orderCode.validate()).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    }, borderRadius: radius(), highlightColor: Colors.transparent, splashColor: Colors.transparent).paddingOnly(bottom: 16);
  }
}
