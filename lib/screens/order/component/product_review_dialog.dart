import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/getImage.dart';
import '../../product/model/product_review_data_model.dart';
import '../order_repository.dart';
import '../view/order_detail_screen.dart';

class ProductReviewDialog extends StatefulWidget {
  final ProductReviewDataModel? productReview;
  final int? productId;
  final int? productVariationId;

  ProductReviewDialog({this.productReview, this.productId, this.productVariationId});

  @override
  State<ProductReviewDialog> createState() => _ProductReviewDialogState();
}

class _ProductReviewDialogState extends State<ProductReviewDialog> {
  double selectedRating = 0;

  TextEditingController reviewCont = TextEditingController();

  bool isUpdate = false;

  List<XFile> pickedFile = [];

  @override
  void initState() {
    if (widget.productReview != null) {
      selectedRating = widget.productReview!.rating.validate().toDouble();
      reviewCont.text = widget.productReview!.reviewMsg.validate();
    }

    super.initState();
  }

  void submit() async {
    hideKeyboard(context);

    appStore.setLoading(true);

    await updateOrderReview(
      files: pickedFile.validate(),
      reviewId: widget.productReview != null ? widget.productReview!.id.validate().toString() : '',
      productId: widget.productId.validate().toString(),
      productVariationId: widget.productVariationId.validate().toString(),
      rating: selectedRating.validate().toString(),
      reviewMsg: reviewCont.text.validate(),
      onSuccess: (data) {
        appStore.setLoading(false);
        onOrderDetailUpdate.call();
        finish(context, true);
        toast(locale.thanksYouForReview);
      },
    ).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
      finish(context, false);
    });
  }

  void _getFromGallery() async {
    GetMultipleImage(path: (xFiles) async {
      debugPrint('Path Gallery : ${xFiles.length.toString()}');
      final existingNames = pickedFile.map((file) => file.name.trim().toLowerCase()).toSet();
      if (pickedFile.validate().length <= 3) {
        pickedFile.addAll(xFiles.where((file) => !existingNames.contains(file.name.trim().toLowerCase())));
        setState(() {});
      } else {
        toast(locale.selectUpToThreeImages);
      }
    });
  }

  _getFromCamera() async {
    GetImage(ImageSource.camera, path: (path, name, xFile) async {
      debugPrint('Path Camera : ${path.toString()} name $name');
      pickedFile.add(xFile);
      setState(() {});
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.gallery,
              leading: Icon(Icons.image, color: context.iconColor),
              onTap: () async {
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.camera,
              leading: Icon(Icons.camera, color: context.iconColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: boxDecorationDefault(
                  color: primaryColor,
                  borderRadius: radiusOnly(topRight: 8, topLeft: 8),
                ),
                child: Row(
                  children: [
                    Text(locale.yourReview, style: boldTextStyle(color: Colors.white)).expand(),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.white, size: 16),
                      onPressed: () {
                        finish(context);
                      },
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: boxDecorationDefault(color: context.cardColor),
                    child: Row(
                      children: [
                        Text(locale.yourReview, style: secondaryTextStyle()),
                        16.width,
                        RatingBarWidget(
                          onRatingChanged: (rating) {
                            selectedRating = rating;
                            setState(() {});
                          },
                          activeColor: getRatingBarColor(selectedRating.toInt()),
                          inActiveColor: ratingBarColor,
                          rating: selectedRating,
                          size: 18,
                        ).expand(),
                      ],
                    ),
                  ),
                  16.height,
                  AppTextField(
                    controller: reviewCont,
                    textFieldType: TextFieldType.OTHER,
                    minLines: 5,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: inputDecoration(
                      context,
                      label: locale.enterYourReviewOptional,
                    ).copyWith(fillColor: context.cardColor, filled: true),
                  ),
                  AnimatedWrap(
                    spacing: 10,
                    itemCount: pickedFile.validate().length,
                    itemBuilder: (context, index) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(height: 50, width: 50, alignment: Alignment.center, padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: primaryColor)),
                          Image.file(File(pickedFile[index].path), width: 50, height: 50, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius),
                          Positioned(
                            right: -5,
                            top: -8,
                            child: Container(
                              height: 18,
                              width: 18,
                              alignment: Alignment.center,
                              decoration: boxDecorationDefault(border: Border.all(color: primaryColor), shape: BoxShape.circle),
                              child: Icon(Icons.close, color: primaryColor, size: 10),
                            ).onTap(() {
                              showConfirmDialogCustom(
                                context,
                                title: locale.doYouWantToRemove,
                                positiveText: locale.yes,
                                negativeText: locale.no,
                                dialogType: DialogType.DELETE,
                                onAccept: (p0) async {
                                  pickedFile.removeAt(index);
                                  setState(() {});
                                },
                              );
                            }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
                          ),
                        ],
                      );
                    },
                  ).paddingTop(16).visible(pickedFile.isNotEmpty),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: boxDecorationDefault(border: Border.all(color: primaryColor)),
                    child: TextIcon(
                      text: locale.addPhoto,
                      textStyle: boldTextStyle(),
                      prefix: Icon(Icons.camera_alt_outlined, color: primaryColor, size: 16),
                      edgeInsets: EdgeInsets.zero,
                      onTap: () {
                        hideKeyboard(context);
                        _showBottomSheet(context);
                      },
                    ),
                  ).paddingTop(16),
                  32.height,
                  Row(
                    children: [
                      AppButton(
                        text: locale.cancel,
                        textColor: isUpdate ? Colors.red : textPrimaryColorGlobal,
                        color: context.cardColor,
                        onTap: () {
                          finish(context);
                        },
                      ).expand(),
                      16.width,
                      AppButton(
                        textColor: Colors.white,
                        text: locale.submit,
                        color: context.primaryColor,
                        onTap: () {
                          if (selectedRating == 0) {
                            toast(locale.ratingIsRequired);
                          } else {
                            submit();
                          }
                        },
                      ).expand(),
                    ],
                  )
                ],
              ).paddingAll(16)
            ],
          ),
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading).withSize(height: 110, width: 110))
      ],
    );
  }
}
