import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/empty_error_state_widget.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/coupons/component/coupon_card_component.dart';
import 'package:ifloriana/screens/coupons/coupon_repository.dart';
import 'package:ifloriana/screens/coupons/model/coupon_list_model.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key});

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  List<CouponListData> couponList = [];
  Future<List<CouponListData>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getCouponList();
  }

  Future<List<CouponListData>> getCouponList() async {
    appStore.setLoading(true);
    await getCouponListData().then((value) {
      if (value.couponListData != null) {
        couponList = value.couponListData!;
      }

      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
    return couponList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        context,
        title: locale.coupons,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: Stack(
        children: [
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
                  title: '${locale.opps}! ${locale.noCouponLeftIn}',
                  imageWidget: EmptyStateWidget(),
                  onRetry: () async {
                    init();
                  },
                ).paddingSymmetric(horizontal: 32).center();
              }
              return AnimatedList(
                initialItemCount: couponList.length,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shrinkWrap: true,
                itemBuilder: (context, index, animation) => CouponCardComponent(
                  couponCode: couponList[index].couponCode,
                  couponDiscount: couponList[index].discountPercentage.toString(),
                  couponImage: couponList[index].couponImage,
                  couponTitle: couponList[index].name,
                  expiryDate: couponList[index].endDateTime,
                  isFixDiscount: couponList[index].discountType=="fixed",
                  discountAmount:  couponList[index].discountAmount.toString(),
                ).onTap(() {
                  //
                }),
              );
            },
          ),
          Observer(
            builder: (context) => LoaderWidget().visible(appStore.isLoading).center(),
          ),
        ],
      ),
    );
  }
}
