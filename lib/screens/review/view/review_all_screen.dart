import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/back_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../models/review_data.dart';
import '../../../utils/constants.dart';
import '../component/review_item_component.dart';
import '../review_repository.dart';
import '../shimmer/review_all_shimmer.dart';

class ReviewAllScreen extends StatefulWidget {
  final int? employeeId;
  final int? branchId;

  ReviewAllScreen({this.employeeId, this.branchId});

  @override
  State<ReviewAllScreen> createState() => _ReviewAllScreenState();
}

class _ReviewAllScreenState extends State<ReviewAllScreen> {
  Future<List<ReviewData>>? future;

  List<ReviewData> allReviewList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = employeeReviews(
      empId: widget.employeeId.validate(),
      branId: widget.branchId.validate(),
      page: page,
      list: allReviewList,
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
    return AppScaffold(
      appBarWidget: appBarWidget(
        locale.reviews,
        textColor: white,
        center: true,
        textSize: APPBAR_TEXT_SIZE,
        elevation: 0.0,
        color: context.primaryColor,
        backWidget: BackWidget(),
      ),
      body: Stack(
        children: [
          SnapHelperWidget<List<ReviewData>>(
            future: future,
            loadingWidget: ReviewAllShimmer(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                imageWidget: ErrorStateWidget(),
                retryText: locale.reload,
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              );
            },
            onSuccess: (data) {
              return AnimatedListView(
                itemBuilder: (context, index) => ReviewItemComponent(reviewData: data[index]),
                slideConfiguration: SlideConfiguration(duration: 400.milliseconds, delay: 50.milliseconds),
                shrinkWrap: true,
                listAnimationType: ListAnimationType.FadeIn,
                fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
                padding: EdgeInsets.all(16),
                itemCount: data.length,
                physics: AlwaysScrollableScrollPhysics(),
                emptyWidget: NoDataWidget(
                  title: locale.noReviewsFound,
                  imageWidget: EmptyStateWidget(),
                ),
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  }
                },
                onSwipeRefresh: () async {
                  page = 1;

                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
