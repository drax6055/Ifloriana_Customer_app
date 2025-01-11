import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/product/component/all_review_product_component.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/dotted_line.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../../utils/model_keys.dart';
import '../../zoom_image_screen.dart';
import '../model/product_list_response.dart';
import '../model/product_review_data_model.dart';
import '../product_repository.dart';
import '../view/product_detail_screen.dart';

class ProductRatingReviewComponent extends StatelessWidget {
  final List<ProductReviewDataModel> reviewDetails;
  final ProductData productReviewData;

  ProductRatingReviewComponent({required this.reviewDetails, required this.productReviewData});

  @override
  Widget build(BuildContext context) {
    if (productReviewData.productReview.validate().isEmpty) return Text(locale.noRatingsYet, style: boldTextStyle()).paddingSymmetric(horizontal: 16);

    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewAllLabel(
            label: locale.ratingAndReviews,
            onTap: () {
              AllReviewProductComponent(productId: productReviewData.id).launch(context);
            },
          ),
          Text('${locale.totalReviewsAndRatings} : ${productReviewData.ratingCount.validate()}', style: secondaryTextStyle()),
          4.height,
          Row(
            children: [
              Text('${productReviewData.rating.validate()}', style: primaryTextStyle(size: 40)),
              8.width,
              RatingBarWidget(
                onRatingChanged: (rating) {},
                disable: true,
                activeColor: getRatingBarColor(productReviewData.rating.validate().toInt()),
                inActiveColor: ratingBarColor,
                rating: productReviewData.rating.validate().toDouble(),
                size: 20,
              ).expand(),
            ],
          ),
          4.height,
          DottedLine(dashGapLength: 0, dashColor: context.dividerColor),
          4.height,
          AnimatedWrap(
            children: List.generate(reviewDetails.take(4).length, (index) {
              ProductReviewDataModel reviewData = reviewDetails[index];

              return Column(
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
                      Text(formatDate(reviewData.createdAt.validate(), format: DateFormatConst.DATE_FORMAT_4), style: secondaryTextStyle()),
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
                            url: galleryData.fullUrl.validate(),
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
                                icon: reviewData.isUserLike == 1 ? ic_fill_like.iconImage(size: 16, color: primaryColor) : ic_like.iconImage(size: 16),
                                onPressed: () async {
                                  appStore.setLoading(true);

                                  /// Review Like Api
                                  if (reviewData.isUserLike != 1) {
                                    Map req = {
                                      ProductModelKey.reviewId: reviewData.id,
                                      ProductModelKey.isLike: 1,
                                    };

                                    doIfLoggedIn(context, () async {
                                      await addReviewLikeOrDislike(req).then((value) {
                                        appStore.setLoading(false);
                                        toast('${locale.thanksForVoting}!');
                                      }).catchError((error) {
                                        appStore.setLoading(false);
                                        toast(error.toString());
                                      });

                                      onProductDetailUpdate.call();
                                    });
                                  }
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
                                  appStore.setLoading(true);

                                  /// Review DisLike Api
                                  if (reviewData.isUserDislike != 1) {
                                    Map req = {
                                      ProductModelKey.reviewId: reviewData.id,
                                      ProductModelKey.isDislike: 1,
                                    };

                                    doIfLoggedIn(context, () async {
                                      await addReviewLikeOrDislike(req).then((value) {
                                        appStore.setLoading(false);
                                        toast('${locale.thanksForVoting}!');
                                      }).catchError((error) {
                                        appStore.setLoading(false);
                                        toast(error.toString());
                                      });

                                      onProductDetailUpdate.call();
                                    });
                                  }
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
