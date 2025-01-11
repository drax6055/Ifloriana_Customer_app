import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/common_row_text_widget.dart';
import '../../../utils/constants.dart';
import '../model/order_detail_response.dart';
import 'invoice_request_dialog_component.dart';

class OrderInformationComponent extends StatelessWidget {
  final OrderListData orderData;

  OrderInformationComponent({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ViewAllLabel(label: locale.orderDetail, isShowAll: false),
            if (orderData.paymentStatus.validate() == SERVICE_PAYMENT_STATUS_PAID)
              OutlinedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => InvoiceRequestDialogComponent(bookingId: orderData.id.validate()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.primaryColor),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(0, 36),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                ),
                child: Text(
                  locale.orderInvoice,
                  style: secondaryTextStyle(color: context.primaryColor),
                ),
              ),
          ],
        ),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonRowTextWidget(leadingText: locale.orderDate, trailingText: orderData.orderingDate),
              10.height,
              if (orderData.deliveringDate.isNotEmpty) CommonRowTextWidget(leadingText: locale.deliveredOn, trailingText: orderData.deliveringDate.validate()),
              if (orderData.deliveringDate.isNotEmpty) 10.height,
              CommonRowTextWidget(leadingText: locale.payment, trailingText: orderData.paymentMethod.validate().capitalizeFirstLetter()),
              10.height,
              CommonRowTextWidget(leadingText: locale.deliveryStatus, trailingText: getOrderBookingStatus(status: orderData.deliveryStatus.validate().capitalizeFirstLetter())),
              10.height,
              if (orderData.logisticName.validate().isNotEmpty) CommonRowTextWidget(leadingText: locale.logisticPartner, trailingText: orderData.logisticName.validate().capitalizeFirstLetter()),
              if (orderData.logisticContact.validate().isNotEmpty) 10.height,
              if (orderData.logisticContact.validate().isNotEmpty) CommonRowTextWidget(leadingText: locale.logisticContactNumber, trailingText: orderData.logisticContact.validate()),
              if (orderData.logisticAddress.validate().isNotEmpty) 10.height,
              if (orderData.logisticAddress.validate().isNotEmpty) CommonRowTextWidget(leadingText: locale.logisticAddress, trailingText: orderData.logisticAddress.validate()),
            ],
          ),
        ),
      ],
    );
  }
}
