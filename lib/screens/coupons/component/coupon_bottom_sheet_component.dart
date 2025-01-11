import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/empty_error_state_widget.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/coupons/component/apply_coupon_card_component.dart';
import 'package:ifloriana/screens/coupons/coupon_repository.dart';
import 'package:ifloriana/screens/coupons/model/coupon_list_model.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponBottomSheetComponent extends StatefulWidget {
  final bool? isFromBooking;
  final ScrollController? scrollController;

  const CouponBottomSheetComponent({super.key, this.isFromBooking, this.scrollController});

  @override
  State<CouponBottomSheetComponent> createState() => _CouponBottomSheetComponentState();
}

class _CouponBottomSheetComponentState extends State<CouponBottomSheetComponent> {
  List<CouponListData> couponList = [];
  Future<List<CouponListData>>? future;
  String? selectedCouponCode;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getCouponList();
  }

  //region coupon list Api call
  Future<List<CouponListData>> getCouponList() async {
    setState(() {
      isLoading = true;
    });
    await getCouponListData().then((value) {
      if (value.couponListData != null) {
        couponList = value.couponListData!;
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      toast(e.toString(), print: true);
    });
    return couponList;
  }

  //endregion

  Future<void> checkCouponData(String couponCode) async {
    hideKeyboard(context);
    setState(() {
      isLoading = true;
    });
    await getCouponData(couponCode: Uri.encodeComponent(couponCode)).then((value) {
      if (value.couponListData != null) {
        if (value.couponListData!.discountType.validate() == "fixed") {
          bookingRequestStore.setFixedCouponType(true);
          bookingRequestStore.setFinalDiscountCouponAmount(value.couponListData!.discountAmount.validate());
        } else {
          bookingRequestStore.setFixedCouponType(false);
          bookingRequestStore.setCouponPercentage(value.couponListData!.discountPercentage!.toInt());
          bookingRequestStore.setFinalDiscountCouponAmount(bookingRequestStore.calculateTotalDiscountCouponAmount);
          if (bookingRequestStore.isPackagePurchase) {
            bookingRequestStore.setFinalDiscountCouponAmount(bookingRequestStore.selectedPackageList.first.packagePrice.validate() * bookingRequestStore.couponDiscountPercentage / 100);
          }
        }

        bookingRequestStore.setCouponApplied(true);
        bookingRequestStore.setDiscountCouponCode(couponCode);
        toast(locale.couponAppliedSuccessfully);
        setState(() {
          isLoading = false;
        });
        finish(context);
      }
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      toast(e.toString(), print: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: widget.scrollController,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: AnimatedScrollView(
              padding: EdgeInsets.all(16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(locale.availableCoupons, style: boldTextStyle(size: 16)),
                    CachedImageWidget(
                      url: ic_close,
                      height: 22,
                      color: Colors.grey.shade500,
                    ).onTap(() {
                      finish(context);
                    })
                  ],
                ),
                16.height,
                SnapHelperWidget<List<CouponListData>>(
                  future: future,
                  loadingWidget: Offstage(),
                  useConnectionStateForLoader: false,
                  errorBuilder: (error) {
                    return NoDataWidget(
                      title: error,
                      retryText: locale.reload,
                      imageWidget: ErrorStateWidget(),
                      onRetry: () {
                        init();
                      },
                    );
                  },
                  onSuccess: (couponList) {
                    if (couponList.isEmpty) {
                      return NoDataWidget(
                        title: '${locale.opps}! ${locale.noCouponsAvailable}',
                        imageWidget: EmptyStateWidget(),
                        onRetry: () async {
                          init();
                        },
                      ).paddingSymmetric(horizontal: 32).center();
                    }

                    return AnimatedListView(
                      itemCount: couponList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (p0, index) {
                        CouponListData data = couponList[index];
                        return ApplyCouponCardComponent(
                          couponCode: data.couponCode,
                          expiryDate: data.endDateTime,
                          isFixedCoupon: data.discountType == "fixed",
                          couponAmount: data.discountType == "fixed" ? data.discountAmount.toString() : data.discountPercentage.toString(),
                          onApply: (couponCode) async {
                            if (couponCode.trim().isNotEmpty) {
                              await checkCouponData(couponCode);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        LoaderWidget().visible(isLoading).center()
      ],
    );
  }
}
