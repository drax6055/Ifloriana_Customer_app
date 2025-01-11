import 'package:flutter/material.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

class ApplyCouponCardComponent extends StatelessWidget {
  final String? couponCode;
  final String? couponAmount;
  final bool? isFixedCoupon;
  final String? expiryDate;
  final Function(String)? onApply;

  const ApplyCouponCardComponent({super.key, this.couponAmount, this.couponCode, this.isFixedCoupon, this.expiryDate, this.onApply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedBorderWidget(
            radius: defaultRadius,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                couponCode.validate(),
                style: boldTextStyle(),
              ),
            ),
          ),
          16.height,
          RichText(
            text: TextSpan(
              text: "${locale.useThisCodeToGet} ",
              style: secondaryTextStyle(size: 14),
              children: [
                TextSpan(
                  text: isFixedCoupon == true ? "${leftCurrencyFormat()}$couponAmount${rightCurrencyFormat()}" : "$couponAmount% Off",
                  style: boldTextStyle(size: 14),
                ),
              ],
            ),
          ),
          16.height,
          Row(
            children: [
              AppButton(
                text: locale.apply,
                textStyle: boldTextStyle(color: context.scaffoldBackgroundColor),
                color: context.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onTap: () async {
                  onApply?.call(couponCode.validate());
                },
              ),
              16.width,
              RichText(
                text: TextSpan(
                  text: "${locale.validTill}: ",
                  style: secondaryTextStyle(size: 16),
                  children: [
                    TextSpan(text: expiryDate, style: boldTextStyle(size: 16)),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ).expand(),
            ],
          )
        ],
      ),
    );
  }
}
