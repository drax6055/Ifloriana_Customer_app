import 'package:flutter/material.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/review_data.dart';
import '../../../utils/constants.dart';

class ReviewItemComponent extends StatefulWidget {
  final ReviewData reviewData;

  ReviewItemComponent({required this.reviewData});

  @override
  _ReviewItemComponentState createState() => _ReviewItemComponentState();
}

class _ReviewItemComponentState extends State<ReviewItemComponent> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    alignment: Alignment.center,
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: context.scaffoldBackgroundColor),
                    child: TextIcon(
                      text: widget.reviewData.rating.validate().toString(),
                      spacing: 8,
                      edgeInsets: EdgeInsets.only(left: 0),
                      textStyle: boldTextStyle(),
                      prefix: Icon(Icons.star, size: 12, color: widget.reviewData.ratingColor),
                    ),
                  ),
                  8.width,
                  Text(widget.reviewData.username.validate(), style: boldTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis).flexible(),
                ],
              ).expand(),
              widget.reviewData.createdAt.validate().isNotEmpty ? Text(formatDate(widget.reviewData.createdAt.validate(), format: DateFormatConst.DATE_FORMAT_4), style: secondaryTextStyle()) : SizedBox(),
            ],
          ),
          if (widget.reviewData.reviewMsg.validate().isNotEmpty)
            Column(
              children: [
                8.height,
                Text(widget.reviewData.reviewMsg!, style: secondaryTextStyle()),
              ],
            ),
        ],
      ),
    );
  }
}
