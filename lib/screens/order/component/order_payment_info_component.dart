import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/screens/order/model/order_detail_response.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/price_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';

class OrderPaymentInfoComponent extends StatelessWidget {
  final OrderListData orderData;

  OrderPaymentInfoComponent({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.priceDetails, isShowAll: false, labelSize: 14),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Subtotal
              SettingItemWidget(
                title: locale.subtotal,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                trailing: Marquee(child: PriceWidget(price: orderData.subTotalAmount.validate(), color: textPrimaryColorGlobal, size: 14)),
              ),
              10.height,

              /// Total Tax Amount
              if (orderData.totalTaxAmount != 0)
                SettingItemWidget(
                  title: locale.tax,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  trailing: Marquee(child: PriceWidget(price: orderData.totalTaxAmount.validate(), color: textPrimaryColorGlobal, size: 14)),
                ).paddingBottom(10),

              /// Delivery Charge
              if (orderData.logisticCharge != 0)
                SettingItemWidget(
                  title: locale.deliveryCharge,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  trailing: Marquee(child: PriceWidget(price: orderData.logisticCharge.validate(), color: textPrimaryColorGlobal, size: 14)),
                ).paddingBottom(10),

              /// Total Amount
              SettingItemWidget(
                title: locale.total,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                trailing: Marquee(
                  // todo : check this
                  child: PriceWidget(price: orderData.totalAmount.validate(), color: primaryColor, size: 14),
                ),
              ),
              10.height,
              /// Payment Status
              SettingItemWidget(
                title: locale.paymentStatus,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                trailing: Marquee(child: PriceWidget(price: 0, priceText: getBookingPaymentStatus(status: orderData.paymentStatus.validate()), color: orderData.paymentStatus.validate().toLowerCase() == SERVICE_PAYMENT_STATUS_PAID?greenColor:  wishListColor, size: 14)),
              ),
            ],
          ),
        ),
        8.height,
        ViewAllLabel(label: locale.shippingDetail, isShowAll: false),
        Container(
          width: context.width(),
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (orderData.userName.validate().trim().isNotEmpty) Marquee(child: Text(orderData.userName.capitalizeFirstLetter(), style: boldTextStyle())).paddingBottom(8),
              if (orderData.addressLine1.validate().trim().isNotEmpty) Marquee(child: Text(orderData.addressLine1.validate().capitalizeFirstLetter(), style: secondaryTextStyle())),
              if (orderData.addressLine2.validate().trim().isNotEmpty) Marquee(child: Text(orderData.addressLine2.validate().capitalizeFirstLetter(), style: secondaryTextStyle())),
              10.height,
              if (orderData.city.validate().trim().isNotEmpty) Marquee(child: Text(orderData.city.validate().capitalizeFirstLetter(), style: secondaryTextStyle())).paddingBottom(10),
              if (orderData.state.validate().trim().isNotEmpty) Marquee(child: Text('${orderData.state.validate().capitalizeFirstLetter()} - ${orderData.postalCode.validate()}', style: secondaryTextStyle())).paddingBottom(10),
              if (orderData.phoneNo.validate().trim().isNotEmpty)
                Marquee(
                  child: RichTextWidget(
                    list: [
                      TextSpan(text: '${locale.contactNumber}: ', style: secondaryTextStyle()),
                      TextSpan(text: orderData.phoneNo.validate(), style: boldTextStyle(size: 12)),
                    ],
                  ),
                ),
              10.height,
              if (orderData.alternativePhoneNo.validate().trim().isNotEmpty)
                Marquee(
                  child: RichTextWidget(
                    list: [
                      TextSpan(text: locale.alternativeContactNumber, style: secondaryTextStyle()),
                      TextSpan(text: orderData.alternativePhoneNo.validate(), style: boldTextStyle(size: 12)),
                    ],
                  ),
                ).paddingBottom(10),
            ],
          ),
        ),
      ],
    );
  }
}
