import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/screens/review/view/review_all_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../models/review_data.dart';
import '../../../utils/constants.dart';
import '../../review/component/review_item_component.dart';
import '../branch_repository.dart';
import '../shimmer/branch_review_shimmer.dart';

class BranchReviewComponent extends StatefulWidget {
  final int branchId;
  final int? branchTotalReview;

  const BranchReviewComponent({super.key, required this.branchId, this.branchTotalReview});

  @override
  _BranchReviewComponentState createState() => _BranchReviewComponentState();
}

class _BranchReviewComponentState extends State<BranchReviewComponent> {
  Future<List<ReviewData>>? future;

  List<ReviewData> branchReviewList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getBranchReviewList(
      branchId: widget.branchId,
      page: page,
      list: branchReviewList,
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
        SnapHelperWidget<List<ReviewData>>(
          future: future,
          initialData: branchReviewListResponseCached,
          loadingWidget: BranchReviewShimmer(),
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
            if (list.isEmpty) {
              return SingleChildScrollView(
                child: NoDataWidget(
                  title: locale.noReviewsFound,
                  subTitle: locale.yourReviewsWillBeAppearedHere,
                  imageWidget: EmptyStateWidget(),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ViewAllLabel(
                    labelWidget: Row(
                      children: [
                        Text(locale.reviews, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                        if (widget.branchTotalReview.validate() >= 1)
                          Text(
                            '(${locale.basedOn} ${widget.branchTotalReview.validate()} ${locale.review}${widget.branchTotalReview.validate() > 1 ? '${locale.s}' : ''})',
                            style: secondaryTextStyle(),
                          ).paddingLeft(4),
                      ],
                    ),
                    list: list,
                    onTap: () {
                      ReviewAllScreen(branchId: widget.branchId).launch(context);
                    },
                  ),
                  AnimatedListView(
                    itemCount: list.take(10).length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    listAnimationType: ListAnimationType.FadeIn,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) => ReviewItemComponent(reviewData: list[i]),
                  ),
                ],
              ),
            );
          },
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
      ],
    );
  }
}
