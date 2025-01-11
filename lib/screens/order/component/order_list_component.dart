import 'package:flutter/material.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../model/order_detail_response.dart';
import '../order_repository.dart';
import 'order_item_component.dart';

late Function(String) onOrderListUpdate;

class OrderListComponent extends StatefulWidget {
  @override
  _OrderListComponentState createState() => _OrderListComponentState();
}

class _OrderListComponentState extends State<OrderListComponent> {
  Future<List<OrderListData>>? future;

  List<OrderListData> orders = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();

    onOrderListUpdate = (search) {
      init(flag: true, search: search);
    };
  }

  void init({bool flag = false, String search = ''}) async {
    future = getOrderList(
      status: productStore.selectedOrderStatusList.join(","),
      page: page,
      orders: orders,
      lastPageCallBack: (p) {
        isLastPage = p;
      },
    );
    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<List<OrderListData>>(
      future: future,
      loadingWidget: LoaderWidget(),
      errorBuilder: (error) {
        return NoDataWidget(
          title: error,
          retryText: locale.reload,
          imageWidget: ErrorStateWidget(),
          onRetry: () {
            page = 1;
            appStore.setLoading(true);

            init(flag: true);
          },
        );
      },
      onSuccess: (orderList) {
        return AnimatedListView(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: orderList.length,
          padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 16),
          shrinkWrap: true,
          emptyWidget: NoDataWidget(
            title: locale.noOrdersFound,
            subTitle: locale.thereAreNoOrders,
            imageWidget: EmptyStateWidget(),
            retryText: locale.reload,
            onRetry: () {
              page = 1;
              appStore.setLoading(true);

              init(flag: true);
            },
          ).paddingSymmetric(horizontal: 16),
          itemBuilder: (_, i) => OrderItemComponent(getOrderData: orderList[i]),
          onNextPage: () {
            if (!isLastPage) {
              page++;
              appStore.setLoading(true);

              init(flag: true);
            }
          },
          onSwipeRefresh: () async {
            page = 1;

            init(flag: true);

            return await 2.seconds.delay;
          },
        );
      },
    );
  }
}
