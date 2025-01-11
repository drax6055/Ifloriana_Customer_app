import 'package:flutter/material.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_row_text_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../cart/model/cart_list_response.dart';
import '../../dashboard/component/booking_list_component.dart';
import '../model/booking_list_response.dart';
import '../view/booking_detail_screen.dart';
import '../view/complete_payment_screen.dart';

class PaymentInformationComponent extends StatefulWidget {
  final BookingListData booking;

  PaymentInformationComponent({required this.booking});

  @override
  State<PaymentInformationComponent> createState() => _PaymentInformationComponentState();
}

class _PaymentInformationComponentState extends State<PaymentInformationComponent> {
  bool isPackage = false;
  double subtotal = 0.0;

  void initState() {
    super.initState();
    if (widget.booking.packages != null && widget.booking.packages!.isNotEmpty) {
      isPackage = widget.booking.packages!.isNotEmpty;
    }
    subtotal = isPackage
        ? widget.booking.sumOfPackagesPrices.validate() - widget.booking.couponAmount.validate().toDouble()
        : widget.booking.sumOfServicePrices.validate() - widget.booking.couponAmount.validate().toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllLabel(
          label: locale.priceDetails,
          trailingTextColor: Colors.red,
          isShowAll: false,
          onTap: () {
            //
          },
        ),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              /// Discount coupon amount
              if (widget.booking.couponAmount.validate() != 0)
                SettingItemWidget(
                  title: locale.couponDiscount,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  paddingBeforeTrailing: 16,
                  trailing: Marquee(child: PriceWidget(price: widget.booking.couponAmount.validate(), color: Colors.red, isDiscountedPrice: true, size: 14)),
                ).paddingBottom(10),

              /// Subtotal if package
              if (!isPackage)
                SettingItemWidget(
                  title: locale.subtotal,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  trailing: Marquee(
                    child: PriceWidget(
                        price: isPackage
                            ? widget.booking.sumOfPackagesPrices.validate() - widget.booking.couponAmount.validate()
                            : widget.booking.sumOfServicePrices.validate() - widget.booking.couponAmount.validate(),
                        color: textPrimaryColorGlobal,
                        size: 16),
                  ),
                ),
              10.height,

              /// Product Amount
              if (widget.booking.sumOfProductPrices != 0)
                SettingItemWidget(
                  title: locale.productAmount,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  trailing: Marquee(
                    child: PriceWidget(price: widget.booking.sumOfProductPrices.validate(), color: textPrimaryColorGlobal, size: 14),
                  ),
                ).paddingBottom(10),

              /// Tax
              if (widget.booking.taxDetails != null)
                Column(
                  children: List.generate(
                    widget.booking.taxDetails.validate().length,
                    (index) {
                      TaxDetail tax = widget.booking.taxDetails.validate()[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${tax.taxName.validate()}: ${tax.taxType == TaxType.FIXED ? appStore.currencySymbol : ''}${tax.taxType == TaxType.FIXED ? tax.taxAmount.validate() : tax.taxValue.validate()}${tax.taxType == TaxType.PERCENT ? '%' : ''}',
                            style: secondaryTextStyle(),
                          ),
                          16.width,
                          if (tax.taxType == TaxType.PERCENT) PriceWidget(price: subtotal != 0 ? tax.taxAmount.validate() : 0.0, color: textPrimaryColorGlobal, size: 14),
                          if (tax.taxType == TaxType.FIXED) PriceWidget(price: subtotal != 0 ? tax.taxAmount.validate() : 0.0, color: textPrimaryColorGlobal, size: 14),
                        ],
                      ).paddingBottom(10);
                    },
                  ),
                ),

              /// TIP
              if (widget.booking.tip != 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(locale.tip, style: secondaryTextStyle()),
                    16.width,
                    PriceWidget(price: widget.booking.tip.validate(), color: textPrimaryColorGlobal, size: 14),
                  ],
                ).paddingBottom(10),

              /// Total Amount
                SettingItemWidget(
                title: subtotal == 0 ? locale.total + " ( ${locale.reused} )" : locale.total,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                paddingBeforeTrailing: 16,
                trailing: Marquee(
                    child: PriceWidget(price: subtotal == 0 ? widget.booking.packages!.first.packagePrice.validate() : widget.booking.totalAmount.validate(), color: context.primaryColor, size: 16)),
              ),
            ],
          ),
        ),
        if (widget.booking.payment != null)
          Column(
            children: [
              ViewAllLabel(
                label: locale.paymentDetails,
                trailingTextColor: Colors.red,
                isShowAll: false,
                onTap: () {
                  //
                },
              ),
              Container(
                decoration: boxDecorationDefault(color: context.cardColor),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (widget.booking.payment!.externalTransactionId.validate().isNotEmpty)
                      Column(
                        children: [
                          CommonRowTextWidget(
                            leadingText: locale.transactionId,
                            trailingText: widget.booking.payment!.externalTransactionId.validate(),
                            leftWidgetFlex: 3,
                            rightWidgetFlex: 7,
                          ),
                          10.height,
                        ],
                      ),
                    if (widget.booking.payment!.transactionType != null)
                      SettingItemWidget(
                        title: locale.paymentMethod,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: Text(widget.booking.payment!.transactionType.validate().capitalizeFirstLetter(), style: boldTextStyle(size: 14)),
                        ),
                      ).paddingBottom(10),
                    SettingItemWidget(
                      title: locale.paymentStatus,
                      titleTextStyle: secondaryTextStyle(),
                      padding: EdgeInsets.zero,
                      trailing: Marquee(
                        child: Text(widget.booking.payment!.paymentStatus == 1 ? locale.paid : locale.pending, style: boldTextStyle(size: 14)),
                      ),
                    ),
                    10.height,
                  ],
                ),
              ),
            ],
          )
        else if (widget.booking.status == BookingStatusConst.COMPLETED && (widget.booking.payment == null || (widget.booking.payment != null && widget.booking.payment!.paymentStatus == 0)))
          Column(
            children: [
              16.height,
              AppButton(
                text: locale.payNow,
                textColor: white,
                color: secondaryColor,
                width: context.width(),
                onTap: () async {
                  bool? res = await CompletePaymentScreen(widget.booking).launch(context);

                  if (res ?? false) {
                    onBookingDetailUpdate.call();
                    onBookingListUpdate.call('');
                  }
                },
              ),
            ],
          ),
      ],
    );
  }
}
