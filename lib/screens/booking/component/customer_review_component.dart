import 'package:flutter/material.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/add_review_dialog.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../models/review_data.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../review/review_repository.dart';
import '../../review/view/review_all_screen.dart';
import '../view/booking_detail_screen.dart';

class CustomerReviewComponent extends StatefulWidget {
  final String? bookingStatus;
  final int? staffId;
  final ReviewData? customerReview;
  final String employeeName;

  CustomerReviewComponent({this.bookingStatus, this.staffId, this.customerReview, this.employeeName = ''});

  @override
  _CustomerReviewComponentState createState() => _CustomerReviewComponentState();
}

class _CustomerReviewComponentState extends State<CustomerReviewComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.bookingStatus == BookingStatusConst.COMPLETED)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.customerReview != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    ViewAllLabel(
                      label: locale.yourReview,
                      onTap: () {
                        ReviewAllScreen(employeeId: widget.staffId).launch(context);
                      },
                    ),
                    Container(
                      decoration: boxDecorationDefault(color: context.cardColor),
                      padding: EdgeInsets.all(16),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: getRatingBarColor(widget.customerReview!.rating.validate().toInt()),
                              ),
                              4.width,
                              Text(
                                widget.customerReview!.rating.validate().toStringAsFixed(1),
                                style: boldTextStyle(
                                  color: getRatingBarColor(widget.customerReview!.rating.validate().toInt()),
                                  size: 14,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  showInDialog(
                                    context,
                                    contentPadding: EdgeInsets.zero,
                                    builder: (p0) {
                                      return AddReviewDialog(
                                        customerReview: widget.customerReview,
                                        staffId: widget.staffId,
                                      );
                                    },
                                  );
                                },
                                child: TextIcon(
                                  text: locale.edit,
                                  textStyle: secondaryTextStyle(),
                                  prefix: ic_edit_square.iconImage(size: 10),
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

                                      await deleteReview(id: widget.customerReview!.id.validate()).then((value) {
                                        toast(value.message);
                                      }).catchError((e) {
                                        toast(e.toString());
                                      });

                                      onBookingDetailUpdate.call();
                                    },
                                  );
                                },
                                child: TextIcon(
                                  text: locale.delete,
                                  textStyle: secondaryTextStyle(),
                                  prefix: ic_delete.iconImage(size: 10),
                                  edgeInsets: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                          if (widget.customerReview!.reviewMsg.validate().isNotEmpty)
                            8.height,
                          Text(
                            widget.customerReview!.reviewMsg!,
                            style: secondaryTextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                AppButton(
                  child: Text('${locale.rate} ${widget.employeeName}', style: boldTextStyle(color: Colors.white)),
                  color: context.primaryColor,
                  width: context.width(),
                  elevation: 0,
                  margin: EdgeInsets.only(top: 16),
                  onTap: () {
                    showInDialog(
                      context,
                      contentPadding: EdgeInsets.zero,
                      builder: (p0) {
                        return AddReviewDialog(staffId: widget.staffId, customerReview: widget.customerReview);
                      },
                    );
                  },
                ),
            ],
          ),
      ],
    );
  }

}
