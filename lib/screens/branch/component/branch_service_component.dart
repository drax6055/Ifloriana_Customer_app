import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../services/models/service_response.dart';
import '../branch_repository.dart';
import '../shimmer/branch_service_shimmer.dart';

class BranchServiceComponent extends StatefulWidget {
  final int branchId;

  BranchServiceComponent({required this.branchId});

  @override
  _BranchServiceComponentState createState() => _BranchServiceComponentState();
}

class _BranchServiceComponentState extends State<BranchServiceComponent> {
  Future<List<ServiceListData>>? future;

  List<ServiceListData> branchServiceList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getBranchServiceList(
      branchId: widget.branchId,
      page: page,
      list: branchServiceList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SnapHelperWidget<List<ServiceListData>>(
          future: future,
          initialData: branchServiceListResponseCached,
          loadingWidget: BranchServiceShimmer(),
          errorBuilder: (error) {
            return SingleChildScrollView(
              child: NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              ),
            ).center();
          },
          onSuccess: (list) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: AnimatedListView(
                itemCount: list.length,
                shrinkWrap: true,
                listAnimationType: ListAnimationType.FadeIn,
                physics: NeverScrollableScrollPhysics(),
                emptyWidget: NoDataWidget(
                  title: locale.noServicesFound,
                  imageWidget: EmptyStateWidget(),
                ),
                itemBuilder: (ctx, index) {
                  ServiceListData serviceListData = list[index];

                  return Container(
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedImageWidget(url: serviceListData.serviceImage.validate(), height: 36, width: 36, circle: true),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Marquee(child: Text(serviceListData.name.validate(), style: boldTextStyle(size: 14))),
                            Text('${durationToString(serviceListData.durationMin.validate())}', style: secondaryTextStyle(size: 12)),
                          ],
                        ).expand(),
                        20.width,
                        PriceWidget(price: serviceListData.defaultPrice.validate(), color: context.primaryColor, size: 14),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
      ],
    );
  }
}
