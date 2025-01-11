import 'package:flutter/material.dart';
import 'package:ifloriana/screens/booking/model/booking_list_response.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/common_base.dart';
import 'price_widget.dart';

class CommonRowTextWidget extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  final Color? trailingTextColor;
  final int? trailingTxtSize;
  final int? leftWidgetFlex;
  final int? rightWidgetFlex;
  final bool isPrice;
  final Packages? package;

  const CommonRowTextWidget({
    required this.leadingText,
    required this.trailingText,
    this.trailingTextColor,
    this.trailingTxtSize,
    this.leftWidgetFlex = 1,
    this.rightWidgetFlex = 2,
    this.isPrice = false,
    this.package,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Marquee(
              child: Text(leadingText, style: secondaryTextStyle(), textAlign: isRTL ? TextAlign.end : TextAlign.start),
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            ).expand(flex: leftWidgetFlex),
            16.width,
            Align(
              alignment: isRTL ? Alignment.topLeft: Alignment.topRight,
              child: Marquee(
                child: isPrice
                    ? PriceWidget(price: trailingText.toDouble(), color: appStore.isDarkMode ? Colors.white : Colors.black, size: 14)
                    : Text(trailingText.validate(), style: boldTextStyle(size: trailingTxtSize.validate(value: 12), color: trailingTextColor)),
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              ),
            ).expand(flex: rightWidgetFlex),
          ],
        ),
        if (package != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(locale.yourBookedServices, style: boldTextStyle()).paddingSymmetric(vertical: 8),
              ...package!.services!.map<Widget>((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_forward, color: appTextSecondaryColor, size: 14).paddingTop(2),
                      12.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "${item.serviceName.validate()}",
                              style: primaryTextStyle(color: appTextSecondaryColor, size: 14),
                              children: [
                                TextSpan(text: " - ${item.durationMin} ${locale.mins}", style: boldTextStyle(size: 14)),
                              ],
                            ),
                          ).paddingBottom(6),
                          RichText(
                            text: TextSpan(
                              text: "${locale.quantity}: ",
                              style: primaryTextStyle(color: appTextSecondaryColor, size: 14),
                              children: [
                                TextSpan(text: item.totalQty.toString(), style: boldTextStyle(size: 14)),
                                if (item.remainingQty != null) TextSpan(text: "  (${locale.remainingQuantity} - ${item.remainingQty.toString()}/${item.totalQty.toString()})", style: secondaryTextStyle(size: 12)),
                              ],
                            ),
                          ).paddingBottom(8)
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
      ],
    );
  }
}
