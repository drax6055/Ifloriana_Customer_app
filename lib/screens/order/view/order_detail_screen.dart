import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/screens/booking/booking_repository.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../component/about_product_component.dart';
import '../component/order_information_component.dart';
import '../component/order_payment_info_component.dart';
import '../model/order_detail_response.dart';
import '../order_repository.dart';

late VoidCallback onOrderDetailUpdate;

class OrderDetailScreen extends StatefulWidget {
  final int orderId;
  final String orderCode;

  OrderDetailScreen({required this.orderId, required this.orderCode});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Future<OrderDetailResponse>? future;

  @override
  void initState() {
    super.initState();
    init();

    onOrderDetailUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false}) async {
    /// Booking Detail API
    future = getOrderDetail(orderId: widget.orderId.validate());

    if (flag) setState(() {});
  }

  OrderDetailResponse? getInitialData() {
    if (orderDetailCached.any((element) => element.id == widget.orderId)) {
      return OrderDetailResponse(data: orderDetailCached.firstWhere((element) => element.id == widget.orderId));
    } else {
      return null;
    }
  }

  Future<void> getOrderInvoice(String? id) async {
    appStore.setLoading(true);
    await getOrderInvoiceLink(orderId: id.validate()).then((value) {
      appStore.setLoading(false);
      viewFiles(value.link.validate());
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: widget.orderCode,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: SnapHelperWidget<OrderDetailResponse>(
        future: future,
        initialData: getInitialData(),
        loadingWidget: LoaderWidget(),
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            retryText: locale.reload,
            imageWidget: ErrorStateWidget(),
            onRetry: () {
              appStore.setLoading(true);
              init(flag: true);
            },
          );
        },
        onSuccess: (snap) {
          if (snap.data == null) {
            return NoDataWidget(
              title: locale.noDetailsFound,
              retryText: locale.reload,
              onRetry: () {
                appStore.setLoading(true);
                init(flag: true);
              },
            );
          }

          return AnimatedScrollView(
            padding: EdgeInsets.all(16),
            listAnimationType: ListAnimationType.FadeIn,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              OrderInformationComponent(orderData: snap.data!),
              16.height,
              AboutProductComponent(orderList: snap.data!.productDetails.validate(), deliveryStatus: snap.data!.deliveryStatus.validate()),
              16.height,
              OrderPaymentInfoComponent(orderData: snap.data!),
              16.height,
              if (snap.data!.deliveryStatus == OrderStatusConst.DELIVERED)
                AppButton(
                  child: Text(locale.downloadInvoice, style: boldTextStyle(color: Colors.white)),
                  color: primaryColor,
                  width: context.width(),
                  elevation: 0,
                  margin: EdgeInsets.only(top: 16),
                  onTap: () async {
                    await getOrderInvoice(snap.data?.id.toString());
                  },
                ),
            ],
            onSwipeRefresh: () async {
              init(flag: true);
              return await 2.seconds.delay;
            },
          );
        },
      ),
    );
  }
}
