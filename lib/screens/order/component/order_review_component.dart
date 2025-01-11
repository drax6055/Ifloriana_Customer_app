import 'package:flutter/material.dart';
import 'package:ifloriana/screens/order/component/product_review_dialog.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/dotted_line.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../product/model/product_review_data_model.dart';
import '../../zoom_image_screen.dart';
import '../order_repository.dart';
import '../view/order_detail_screen.dart';

class OrderReviewComponent extends StatelessWidget {
  final String? deliveryStatus;
  final int? productId;
  final int? productVariationId;
  final ProductReviewDataModel? productReview;

  OrderReviewComponent({this.deliveryStatus, this.productId, this.productVariationId, this.productReview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (deliveryStatus == OrderStatusConst.DELIVERED)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (productReview != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
                    10.height,
                    Text(locale.yourReview, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    Row(
                      children: [
                        ...[
                          Icon(Icons.star, size: 14, color: getRatingBarColor(productReview!.rating.validate().toInt())),
                          4.width,
                          Text(
                            productReview!.rating.validate().toStringAsFixed(1).toString(),
                            style: boldTextStyle(color: getRatingBarColor(productReview!.rating.validate().toInt()), size: 14),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              showInDialog(
                                context,
                                contentPadding: EdgeInsets.zero,
                                builder: (p0) {
                                  return ProductReviewDialog(
                                    productReview: productReview,
                                    productId: productId.validate(),
                                    productVariationId: productVariationId.validate(),
                                  );
                                },
                              );
                            },
                            child: TextIcon(
                              text: locale.edit,
                              textStyle: secondaryTextStyle(),
                              prefix: ic_edit_square.iconImage(size: 16),
                              edgeInsets: EdgeInsets.zero,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showConfirmDialogCustom(
                                context,
                                title: locale.deleteReview,
                                subTitle: locale.doYouWantToDeleteReview,
                                positiveText: locale.yes,
                                negativeText: locale.no,
                                dialogType: DialogType.DELETE,
                                onAccept: (p0) async {
                                  appStore.setLoading(true);

                                  await deleteOrderReview(id: productReview!.id.validate()).then((value) {
                                    toast(value.message);
                                  }).catchError((e) {
                                    toast(e.toString(), print: true);
                                  });

                                  onOrderDetailUpdate.call();
                                },
                              );
                            },
                            child: TextIcon(
                              text: locale.delete,
                              textStyle: secondaryTextStyle(color: wishListColor),
                              prefix: ic_delete.iconImage(size: 16, color: wishListColor),
                              edgeInsets: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (productReview!.reviewMsg.validate().isNotEmpty)
                      Text(
                        productReview!.reviewMsg!,
                        style: secondaryTextStyle(),
                      ).paddingBottom(16),
                    AnimatedWrap(
                      spacing: 10,
                      runSpacing: 10,
                      itemCount: productReview!.gallery.validate().take(3).length,
                      itemBuilder: (ctx, index) {
                        ReviewGallaryData galleryData = productReview!.gallery.validate()[index];

                        return CachedImageWidget(
                          url: '${galleryData.fullUrl.validate()}',
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                          radius: defaultRadius,
                        ).onTap(() {
                          if (galleryData.fullUrl.validate().isNotEmpty)
                            ZoomImageScreen(
                              galleryImages: productReview!.gallery.validate().map((e) => e.fullUrl.validate()).toList(),
                              index: index,
                            ).launch(context);
                        });
                      },
                    ),
                  ],
                )
              else
                AppButton(
                  child: Text(locale.addReview, style: boldTextStyle(color: Colors.white)),
                  color: context.primaryColor,
                  width: context.width(),
                  elevation: 0,
                  margin: EdgeInsets.only(top: 16),
                  onTap: () {
                    showInDialog(
                      context,
                      contentPadding: EdgeInsets.zero,
                      builder: (p0) {
                        return ProductReviewDialog(productId: productId.validate(), productVariationId: productVariationId.validate());
                      },
                    );
                  },
                ),
              8.height,
            ],
          ),
      ],
    );
  }
}
