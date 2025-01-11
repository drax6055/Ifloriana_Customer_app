import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/extensions/num_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/constants.dart';

class CommonBottomPriceWidget extends StatefulWidget {
  final String? title;
  final num? price;
  final String? buttonText;
  final Function? onTap;

  CommonBottomPriceWidget({this.title, this.price, this.buttonText, this.onTap});

  @override
  State<CommonBottomPriceWidget> createState() => _CommonBottomPriceWidgetState();
}

class _CommonBottomPriceWidgetState extends State<CommonBottomPriceWidget> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return !bookingRequestStore.isCouponApplied
        ? Observer(builder: (context) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(backgroundColor: secondaryColor, borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SizeTransition(child: child, sizeFactor: animation);
                    },
                    child: isSelect ? viewDetail(context).paddingBottom(16) : SizedBox.shrink(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!bookingRequestStore.isPackagePurchase) ...[
                            Marquee(child: Text(widget.title.validate(), style: boldTextStyle(size: 14, color: Colors.white))),
                            8.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PriceWidget(price: widget.price.validate(), color: Colors.white),
                                bookingRequestStore.totalTax != 0 ? 8.width : Offstage(),
                                IconButton(
                                  onPressed: () {
                                   serviceCommonBottomSheet(context, child: taxDetailsWidget(context: context));
                                  },
                                  iconSize: 16.0,
                                  color: white,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  style: const ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(Icons.info_outline_rounded),
                                ),
                                bookingRequestStore.totalTax != 0 ? 4.width : Offstage(),
                                bookingRequestStore.totalTax != 0
                                    ? Marquee(
                                        child: Text(
                                          '(${bookingRequestStore.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                                          style: primaryTextStyle(color: Colors.white70),
                                        ),
                                      ).expand()
                                    : Offstage(),
                              ],
                            ),
                          ],
                          if (bookingRequestStore.isPackagePurchase) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = !isSelect;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(locale.viewDetail, style: boldTextStyle(color: white, weight: FontWeight.w500)),
                                  8.width,
                                  CachedImageWidget(
                                    url: isSelect ? ic_caret_down : ic_caret_up,
                                    height: 14,
                                    width: 14,
                                    color: white,
                                  ),
                                ],
                              ),
                            ),
                            10.height,
                            PriceWidget(price: widget.price.validate(), color: Colors.white),
                          ]
                        ],
                      ).expand(),
                      16.width,
                      AppButton(
                        color: Colors.white,
                        child: Text(widget.buttonText.validate(), style: boldTextStyle(color: Colors.black)),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        onTap: widget.onTap,
                      ),
                    ],
                  ),
                ],
              ),
            );
          })
        : Observer(builder: (context) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(backgroundColor: secondaryColor, borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SizeTransition(child: child, sizeFactor: animation);
                    },
                    child: isSelect
                        ? viewDetail(context).paddingBottom(16)
                        : SizedBox.shrink(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!bookingRequestStore.isPackagePurchase) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${locale.subtotal} :- ', style: secondaryTextStyle(size: 12, color: Colors.white)),
                                8.width,
                                PriceWidget(price: widget.price.validate(), color: Colors.white, size: 12),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${locale.couponDiscount} :- ', style: secondaryTextStyle(size: 12, color: Colors.white)),
                                8.width,
                                Row(
                                  children: [
                                    PriceWidget(price: bookingRequestStore.finalDiscountCouponAmount.validate(), isDiscountedPrice: true, size: 12),
                                    8.width,
                                    if (!bookingRequestStore.isFixedDiscountCoupon)
                                      Marquee(
                                        child: Text('(${bookingRequestStore.couponDiscountPercentage} %)', style: secondaryTextStyle(color: Colors.white)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${locale.total} :- ', style: secondaryTextStyle(size: 14, color: Colors.white)),
                                8.width,
                                PriceWidget(price: bookingRequestStore.calculateTotalAmountWithCouponAndTaxAndTip.validate(), color: Colors.white, size: 16),
                                bookingRequestStore.totalTax != 0 ? 8.width : Offstage(),
                                IconButton(
                                  onPressed: () {
                                    serviceCommonBottomSheet(context, child: taxDetailsWidget(context: context));
                                  },
                                  iconSize: 16.0,
                                  color: white,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  style: const ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(Icons.info_outline_rounded),
                                ),
                                bookingRequestStore.totalTax != 0 ? 4.width : Offstage(),
                                bookingRequestStore.totalTax != 0
                                    ? Marquee(
                                        child: Text(
                                          '(${bookingRequestStore.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                                          style: primaryTextStyle(color: Colors.white70),
                                        ),
                                      ).expand()
                                    : Offstage(),
                              ],
                            ),
                          ],
                          if (bookingRequestStore.isPackagePurchase) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelect = !isSelect;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(locale.viewDetail, style: boldTextStyle(color: white, weight: FontWeight.w500)),
                                  8.width,
                                  CachedImageWidget(
                                    url: isSelect ? ic_caret_down : ic_caret_up,
                                    height: 14,
                                    width: 14,
                                    color: white,
                                  ),
                                ],
                              ),
                            ),
                            10.height,
                            PriceWidget(price: widget.price.validate(), color: Colors.white),
                          ]
                        ],
                      ).expand(),
                      16.width,
                      AppButton(
                        color: Colors.white,
                        child: Text(widget.buttonText.validate(), style: boldTextStyle(color: Colors.black)),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        onTap: widget.onTap,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
  }

  Widget viewDetail(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bookingRequestStore.selectedPackageList.first.name.validate(), style: secondaryTextStyle(color: white)),
              PriceWidget(price: bookingRequestStore.selectedPackageList.first.packagePrice.validate(), color: white, size: 12),
            ],
          ),
          4.height,
          if (bookingRequestStore.isCouponApplied)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.coupon, style: secondaryTextStyle(color: white)),
                PriceWidget(price: bookingRequestStore.finalDiscountCouponAmount.validate(), isDiscountedPrice: true, color: greenColor, size: 12),
              ],
            ),
          Divider(color: context.dividerColor.withOpacity(0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(locale.total, style: secondaryTextStyle(color: white)),
                  bookingRequestStore.totalTax != 0
                      ? Marquee(
                          child: Text(
                            ' (${bookingRequestStore.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                            style: secondaryTextStyle(color: white),
                          ),
                        )
                      : Offstage(),
                ],
              ),
              PriceWidget(price: bookingRequestStore.totalAmount.validate(), color: white, size: 12),
            ],
          ),
        ],
      );
    });
  }
}

//Tax Details Bottom Sheet
Widget taxDetailsWidget({required BuildContext context}) {
  return Container(
    padding: EdgeInsets.all(16),
    width: context.width(),
    decoration: boxDecorationWithRoundedCorners(backgroundColor: secondaryColor, borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(locale.appliedTaxes, style: boldTextStyle(color: white)),
        12.height,
        ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: bookingRequestStore.taxPercentage.length,
          itemBuilder: (context, index) {
            TaxPercentage taxDet = bookingRequestStore.taxPercentage[index];
            num taxAmt = 0.0;
            if(taxDet.type ==TaxType.PERCENT){
             taxAmt =num.parse(((bookingRequestStore.selectedServiceTotalAmount * taxDet.percent.validate()) / 100).toString()); 
            }else{
              taxAmt = taxDet.taxAmount ?? 0.0;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(taxDet.name.toString(), style: secondaryTextStyle(color:  Colors.white70)),
                
                PriceWidget(price: taxAmt.validate(), color: white, size: 12),
              ],
            ).paddingSymmetric(vertical: 4);
          },
        ),
      ],
    ),
  );
}
