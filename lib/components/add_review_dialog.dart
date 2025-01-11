import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/screens/booking/view/booking_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../models/review_data.dart';
import '../screens/review/review_repository.dart';
import '../utils/colors.dart';
import '../utils/common_base.dart';
import 'loader_widget.dart';

class AddReviewDialog extends StatefulWidget {
  final ReviewData? customerReview;
  final int? staffId;

  AddReviewDialog({
    this.staffId,
    this.customerReview,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double selectedRating = 0;

  TextEditingController reviewCont = TextEditingController();

  bool isUpdate = false;

  @override
  void initState() {
    if (widget.customerReview != null) {
      selectedRating = widget.customerReview!.rating.validate().toDouble();
      reviewCont.text = widget.customerReview!.reviewMsg.validate();
    }

    super.initState();
  }

  void submit() async {
    hideKeyboard(context);
    Map<String, dynamic> req = {};

    req = {
      "id": widget.customerReview != null ? widget.customerReview!.id.validate() : null,
      "employee_id": widget.staffId.validate(),
      "rating": selectedRating.validate(),
      "review_msg": reviewCont.text.validate(),
    };

    appStore.setLoading(true);

    await updateReview(req).then((value) {
      onBookingDetailUpdate.call();
      finish(context, true);
      toast(value.message);
    }).catchError((e) {
      toast(e.toString());
      finish(context, false);
    });

    appStore.setLoading(false);
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
                    ).copyWith(fillColor: context.scaffoldBackgroundColor, filled: true),
                  ),
                  32.height,
                  Row(
                    children: [
                      AppButton(
                        text: locale.cancel,
                        textColor: isUpdate ? Colors.red : Colors.blue,
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
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading).withSize(height: 80, width: 80))
      ],
    );
  }
}
