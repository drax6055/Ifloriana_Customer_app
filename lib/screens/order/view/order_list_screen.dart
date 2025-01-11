import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/screens/order/order_repository.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../component/order_list_component.dart';
import '../model/order_status_response.dart';

class OrderListScreen extends StatefulWidget {
  final bool showBack;
  OrderListScreen({required this.showBack});
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  TextEditingController searchProductCont = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  Future<List<OrderStatusData>>? future;

  @override
  void initState({bool flag = false}) {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    //
    if (flag) setState(() {});
  }

  Future<List<OrderStatusData>>? fetchOrderStatusApi() {
    future = getOrderStatus();

    return future;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: PreferredSize(
        preferredSize: Size(context.width(), 100),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: context.width(),
              height: 150,
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                backgroundColor: context.primaryColor,
              ),
              child: appBarWidget(
                locale.orders,
                center: true,
                showBack: widget.showBack,
                color: context.primaryColor,
                textColor: white,
                textSize: APPBAR_TEXT_SIZE,
              ).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
            ),
            Positioned(
              bottom: -20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  AppTextField(
                    controller: searchProductCont,
                    textFieldType: TextFieldType.OTHER,
                    focus: searchFocusNode,
                    suffix: CloseButton(
                      onPressed: () {
                        hideKeyboard(context);
                        searchProductCont.clear();

                        appStore.setLoading(true);
                        onOrderListUpdate.call(searchProductCont.text);
                        setState(() {});
                      },
                    ).visible(searchProductCont.text.isNotEmpty),
                    onFieldSubmitted: (s) {
                      appStore.setLoading(true);
                      onOrderListUpdate.call(searchProductCont.text);
                      setState(() {});
                    },
                    decoration: inputDecoration(context, hint: locale.searchOrder, prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal)),
                  ).expand(),
                  16.width,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: boxDecorationDefault(color: secondaryColor),
                    child: CachedImageWidget(
                      url: ic_filter,
                      height: 26,
                      width: 26,
                      color: Colors.white,
                    ),
                  ).onTap(() {
                    handleFilterClick(context);
                  }, borderRadius: radius()),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          OrderListComponent(),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Container(
          width: context.width(),
          constraints: BoxConstraints(minWidth: context.height() * 0.65, maxHeight: context.height() * 0.45),
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          ),
          child: SnapHelperWidget<List<OrderStatusData>>(
            future: fetchOrderStatusApi(),
            initialData: orderStatusListCached,
            loadingWidget: LoaderWidget(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);

                  fetchOrderStatusApi();
                  setState(() {});
                },
              );
            },
            onSuccess: (statusList) {
              if (statusList.isEmpty) {
                return NoDataWidget(
                  title: locale.noTimeSlots,
                  retryText: locale.reload,
                  onRetry: () {
                    appStore.setLoading(true);

                    fetchOrderStatusApi();
                    setState(() {});
                  },
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(locale.filterBy, style: primaryTextStyle(size: 18)).paddingOnly(left: 25),
                      CloseButton(
                        onPressed: () {
                          hideKeyboard(context);
                          finish(context);
                        },
                      ).paddingOnly(right: 16),
                    ],
                  ),
                  10.height,
                  Divider(color: context.dividerColor, height: 0).paddingSymmetric(horizontal: 16),
                  22.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.deliveryStatus, style: secondaryTextStyle()).paddingSymmetric(horizontal: 16),
                      16.height,
                      AnimatedWrap(
                        runSpacing: 10,
                        spacing: 10,
                        itemCount: statusList.length,
                        listAnimationType: ListAnimationType.None,
                        itemBuilder: (context, index) {
                          OrderStatusData statusData = statusList[index];

                          return Observer(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                if (productStore.selectedOrderStatusList.contains(statusData.name)) {
                                  productStore.selectedOrderStatusList.remove(statusData.name);
                                } else {
                                  productStore.selectedOrderStatusList.add(statusData.name.validate());
                                }
                              },
                              child: Container(
                                width: context.width() / 3.7,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: boxDecorationDefault(
                                  color: productStore.selectedOrderStatusList.contains(statusData.name)
                                      ? appStore.isDarkMode
                                          ? primaryColor
                                          : lightPrimaryColor
                                      : appStore.isDarkMode
                                          ? primaryColor.withOpacity(0.1)
                                          : Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    ).visible(productStore.selectedOrderStatusList.contains(statusData.name)),
                                    4.width.visible(productStore.selectedOrderStatusList.contains(statusData.name)),
                                    Text(
                                      getOrderBookingStatus(status: statusData.name.validate()),
                                      style: secondaryTextStyle(
                                        color: productStore.selectedOrderStatusList.contains(statusData.name) ? Colors.white : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ).paddingSymmetric(horizontal: 16).expand(),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppButton(
                            text: locale.clearFilter,
                            textStyle: boldTextStyle(color: Colors.white),
                            color: secondaryColor,
                            onTap: () {
                              productStore.selectedOrderStatusList.clear();
                              finish(context);
                              appStore.setLoading(true);
                              onOrderListUpdate.call('');
                            },
                          ).expand(),
                          16.width,
                          AppButton(
                            text: locale.apply,
                            textStyle: boldTextStyle(color: Colors.white),
                            color: primaryColor,
                            onTap: () {
                              finish(context);
                              appStore.setLoading(true);
                              onOrderListUpdate.call('');
                            },
                          ).expand(),
                        ],
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ).expand(),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
