import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/booking/model/booking_request_model.dart';
import 'package:ifloriana/screens/coupons/component/coupon_bottom_sheet_component.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ApplyCouponComponent extends StatefulWidget {
  final VoidCallback? callback;
  final BookingRequestModel? taxRequest;

  const ApplyCouponComponent({super.key, this.callback, this.taxRequest});

  @override
  State<ApplyCouponComponent> createState() => _ApplyCouponComponentState();
}

class _ApplyCouponComponentState extends State<ApplyCouponComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(16),
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        children: [
          Row(
            children: [
              CachedImageWidget(url: ic_gift_coupon, height: 22 , color: appStore.isDarkMode
              ? Colors.white
              : secondaryColor),
              16.width,
              Text(locale.coupons, style: secondaryTextStyle(size: 16)),
              Spacer(),
              Text(locale.selectCoupon, style: boldTextStyle(color: context.primaryColor)).onTap(
                () {
                  if (widget.taxRequest != null && widget.taxRequest!.selectedServiceList != null || bookingRequestStore.selectedServiceList.isNotEmpty||bookingRequestStore.selectedPackageList.isNotEmpty) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        maxChildSize: 0.8,
                        minChildSize: 0.3,
                        expand: false,
                        builder: (context, scrollController) {
                          return CouponBottomSheetComponent(scrollController: scrollController);
                        },
                      ),
                    ).then((value) => widget.callback?.call());
                  } else {
                    toast(locale.pleaseSelectService);
                  }
                },
              ),
            ],
          ),
          if (bookingRequestStore.isCouponApplied)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 30),
                Row(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: DottedBorderWidget(
                            radius: defaultRadius,
                            color: secondaryColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: Colors.transparent,
                              ),
                              child: Text(
                                bookingRequestStore.discountCouponCode.validate(),
                                style: boldTextStyle(color: secondaryColor),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(defaultRadius - 4),
                            ),
                            child: Icon(
                              Icons.close,
                              color: context.scaffoldBackgroundColor,
                              size: 12,
                            ),
                          ).onTap(
                            () {
                              bookingRequestStore.setCouponApplied(false);
                              toast(locale.couponIsRemoved, print: true);
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                    8.width,
                    Text(
                      "${locale.youSaved} ${leftCurrencyFormat()}${widget.taxRequest?.totalCouponDiscount.validate()}${rightCurrencyFormat()}",
                      style: boldTextStyle(color: greenColor),
                    )
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}
