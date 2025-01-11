import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/dash_line.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponCardComponent extends StatelessWidget {
  final String? couponImage;
  final String? couponTitle;
  final String? couponCode;
  final String? expiryDate;
  final String? couponDiscount;
  final bool? isFixDiscount;
  final String? discountAmount;
  const CouponCardComponent({super.key, this.isFixDiscount, this.discountAmount, this.expiryDate, this.couponDiscount, this.couponCode, this.couponImage, this.couponTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      height: 130,
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Row(
        children: [
          CachedImageWidget(url: couponImage.validate(), height: 80, width: 80, fit: BoxFit.fill).cornerRadiusWithClipRRect(defaultRadius),
          16.width,
          DashLineView(fillRate: 0.7, direction: Axis.vertical, dashColor: Colors.grey.shade400),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: isFixDiscount == true ? "${leftCurrencyFormat()}$discountAmount${rightCurrencyFormat()}" : "$couponDiscount% Off",
                  style: primaryTextStyle(color: context.primaryColor),
                  children: [
                    TextSpan(text: " on $couponTitle", style: primaryTextStyle()),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              8.height,
              RichText(
                text: TextSpan(
                  text: "${locale.valid}: ",
                  style: secondaryTextStyle(),
                  children: [
                    TextSpan(text: expiryDate, style: secondaryTextStyle()),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              8.height,
              DottedBorderWidget(
                radius: defaultRadius,
                color: Colors.grey.shade400,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.primaryColor.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        couponCode.validate(),
                        style: boldTextStyle(),
                      ),
                      8.width,
                      Icon(Icons.copy_rounded, size: 22).onTap(() async {
                        await Clipboard.setData(ClipboardData(text: couponCode.validate()));
                        toast(locale.couponCodeCopied);
                      })
                    ],
                  ),
                ),
              )
            ],
          ).expand()
        ],
      ),
    );
  }
}
