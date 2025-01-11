import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../../utils/model_keys.dart';
import '../../zoom_image_screen.dart';
import '../model/product_review_data_model.dart';
import '../product_repository.dart';
import '../view/product_detail_screen.dart';

class AllReviewProductComponent extends StatefulWidget {
  final int? productId;

  AllReviewProductComponent({this.productId});

  @override
  _AllReviewProductComponentState createState() => _AllReviewProductComponentState();
}

class _AllReviewProductComponentState extends State<AllReviewProductComponent> {
  Future<List<ProductReviewDataModel>>? future;

  List<ProductReviewDataModel> allReviewList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool flag = false}) async {
    future = productAllReviews(
      productId: widget.productId.validate(),
      page: page,
      list: allReviewList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
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
    return AppScaffold(
      appBarWidget: appBarWidget(
        locale.productReviews,
        textColor: white,
        center: true,
        textSize: APPBAR_TEXT_SIZE,
        elevation: 0.0,
        color: context.primaryColor,
      ),
      body: SnapHelperWidget<List<ProductReviewDataModel>>(
        future: future,
        loadingWidget: LoaderWidget(),
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            imageWidget: ErrorStateWidget(),
            retryText: locale.reload,
            onRetry: () {
              page = 1;
              appStore.setLoading(true);

              init(flag: true);
            },
          );
        },
        onSuccess: (reviewListData) {
          return AnimatedListView(
            slideConfiguration: SlideConfiguration(duration: 400.milliseconds, delay: 50.milliseconds),
            shrinkWrap: true,
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            padding: EdgeInsets.all(16),
            itemCount: reviewListData.length,
            physics: AlwaysScrollableScrollPhysics(),
            emptyWidget: NoDataWidget(
              title: locale.noReviewsFound,
              imageWidget: EmptyStateWidget(),
            ),
            itemBuilder: (context, index) {
              ProductReviewDataModel reviewData = reviewListData[index];

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 8),
                width: context.width(),
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              alignment: Alignment.center,
                              decoration: boxDecorationWithRoundedCorners(backgroundColor: context.scaffoldBackgroundColor),
                              child: TextIcon(
                                text: reviewData.rating.validate().toString(),
                                edgeInsets: EdgeInsets.only(left: 0),
                                textStyle: boldTextStyle(size: 14, color: primaryColor),
                                prefix: Icon(Icons.star, size: 10, color: getRatingBarColor(reviewData.rating.validate().toInt())),
                              ),
                            ),
                            8.width,
                            Marquee(child: Text(reviewData.userName.validate(), style: primaryTextStyle(size: 14))).flexible(),
                          ],
                        ).expand(),
                        8.width,
                        reviewData.createdAt.validate().isNotEmpty ? Text(formatDate(reviewData.createdAt.validate(), format: DateFormatConst.DATE_FORMAT_4), style: secondaryTextStyle()) : SizedBox(),
                      ],
                    ),
                    14.height,
                    ReadMoreText(reviewData.reviewMsg.validate(), style: boldTextStyle(size: 12)),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedWrap(
                          spacing: 10,
                          runSpacing: 10,
                          itemCount: reviewData.reviewGallary.validate().take(3).length,
                          itemBuilder: (ctx, index) {
                            ReviewGallaryData galleryData = reviewData.reviewGallary.validate()[index];

                            return CachedImageWidget(
                              url: '${galleryData.fullUrl.validate()}',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                              radius: defaultRadius,
                            ).onTap(() {
                              if (galleryData.fullUrl.validate().isNotEmpty)
                                ZoomImageScreen(
                                  galleryImages: reviewData.reviewGallary.validate().map((e) => e.fullUrl.validate()).toList(),
                                  index: index,
                                ).launch(context);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  icon: reviewData.isUserLike == 1 ? ic_fill_like.iconImage(size: 16, color: primaryColor) : ic_like.iconImage(size: 16),
                                  onPressed: () async {
                                    /// Review Like Api

                                    doIfLoggedIn(context, () async {
                                      if (reviewData.isUserLike != 1) {
                                        Map req = {
                                          ProductModelKey.reviewId: reviewData.id,
                                          ProductModelKey.isLike: 1,
                                        };

                                        await addReviewLikeOrDislike(req).then((value) {
                                          toast('${locale.thanksForVoting}!');
                                        }).catchError((error) {
                                          toast(error.toString());
                                        });

                                        onProductDetailUpdate.call();
                                        init(flag: true);
                                      }
                                    });
                                  },
                                ),
                                Text('${reviewData.reviewLikes}', style: secondaryTextStyle()),
                              ],
                            ),
                            4.width,
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: reviewData.isUserDislike == 1 ? ic_fill_dislike.iconImage(size: 16, color: secondaryColor) : ic_dislike.iconImage(size: 16),
                                  onPressed: () async {
                                    /// Review DisLike Api

                                    doIfLoggedIn(context, () async {
                                      if (reviewData.isUserDislike != 1) {
                                        Map req = {
                                          ProductModelKey.reviewId: reviewData.id,
                                          ProductModelKey.isDislike: 1,
                                        };

                                        await addReviewLikeOrDislike(req).then((value) {
                                          toast('${locale.thanksForVoting}!');
                                        }).catchError((error) {
                                          toast(error.toString());
                                        });

                                        onProductDetailUpdate.call();
                                        init(flag: true);
                                      }
                                    });
                                  },
                                ),
                                Text('${reviewData.reviewDislikes}', style: secondaryTextStyle()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    16.height,
                  ],
                ),
              );
            },
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
      ),
    );
  }
}
