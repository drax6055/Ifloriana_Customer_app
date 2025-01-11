import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_row_text_widget.dart';
import '../model/order_detail_response.dart';

class OrderInformationComponent extends StatelessWidget {
  final OrderListData orderData;

  OrderInformationComponent({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.orderDetail, isShowAll: false),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonRowTextWidget(leadingText: locale.orderDate, trailingText: orderData.orderingDate),
              10.height,
              if (orderData.deliveringDate.isNotEmpty)
                CommonRowTextWidget(leadingText: locale.deliveredOn, trailingText: orderData.deliveringDate.validate()),
              2.height,
              if (orderData.deliveringDate.isNotEmpty) 10.height,
              CommonRowTextWidget(leadingText: locale.payment, trailingText: orderData.paymentMethod.validate().capitalizeFirstLetter()),
              10.height,
              CommonRowTextWidget(leadingText: locale.deliveryStatus, trailingText: getOrderBookingStatus(status: orderData.deliveryStatus.validate().capitalizeFirstLetter())),
            ],
          ),
        ),
      ],
    );
  }
}
