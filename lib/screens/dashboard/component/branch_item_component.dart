import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/status_widget.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../branch/model/branch_response.dart';

class BranchItemComponent extends StatefulWidget {
  final BranchData branchData;
  final int? selectedBranchId;
  final int? currentBranchIndex;
  final bool isFormSignIn;
  final Position? position;

  BranchItemComponent({
    required this.branchData,
    this.selectedBranchId,
    this.currentBranchIndex,
    this.isFormSignIn = false,
    this.position,
  });

  @override
  State<BranchItemComponent> createState() => _BranchItemComponentState();
}

class _BranchItemComponentState extends State<BranchItemComponent> {
  double? cardSize;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  double get getDistance {
    if (widget.position == null) return 0;
    if (widget.branchData.latitude == null || widget.branchData.longitude == null) return 0;

    return calculateDistance(
      widget.branchData.latitude!.toDouble(),
      widget.branchData.longitude!.toDouble(),
      widget.position!.latitude,
      widget.position!.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizeListener(
          onSizeChange: (s) {
            cardSize = s.height - 16;
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
                  child: CachedImageWidget(url: widget.branchData.branchImg.validate(), height: 150, width: context.width(), fit: BoxFit.cover),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Marquee(child: Text(widget.branchData.name.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis)).expand(),
                        6.width,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: boxDecorationWithRoundedCorners(backgroundColor: quaternaryButtonColor),
                          child: Text(widget.branchData.branchFor.validate().capitalizeFirstLetter(), style: primaryTextStyle(color: secondaryColor, size: 11)),
                        ),
                      ],
                    ),
                    12.height,
                    TextIcon(
                      text: widget.branchData.addressLine1.validate(),
                      spacing: 12,
                      textStyle: primaryTextStyle(),
                      maxLine: 2,
                      expandedText: true,
                      onTap: () {
                        launchMap('${widget.branchData.addressLine1.validate()}');
                      },
                      edgeInsets: EdgeInsets.only(left: 0),
                      prefix: ic_location.iconImage(color: textSecondaryColorGlobal, size: 16),
                    ),
                    6.height,
                    Row(
                      children: [
                        ic_direction.iconImage(color: textSecondaryColorGlobal, size: 16),
                        12.width,
                        RichTextWidget(
                          list: [
                            if (widget.position != null) TextSpan(text: '$getDistance ${locale.kms} ', style: boldTextStyle(size: 14)),
                            TextSpan(text: locale.fromYourLocation, style: secondaryTextStyle()),
                          ],
                        ).expand(),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Row(
                          children: [
                            TextIcon(
                              text: widget.branchData.ratingStar.validate().toString(),
                              spacing: 10,
                              edgeInsets: EdgeInsets.only(left: 0),
                              prefix: Icon(Icons.star, size: 18, color: getRatingBarColor(widget.branchData.ratingStar.validate().toInt())),
                            ),
                            if (widget.branchData.totalReview.validate() >= 1)
                              Text(
                                '(${locale.basedOn} ${widget.branchData.totalReview.validate()} ${locale.review}${widget.branchData.totalReview.validate() > 1 ? '${locale.s}' : ''})',
                                style: secondaryTextStyle(),
                              ).paddingLeft(4),
                          ],
                        ).expand(),
                        if (widget.branchData.todayTime != null)
                          StatusWidget(
                            text: getBranchIsOpen(startTime: widget.branchData.todayTime!.startTime.validate(), endTime: widget.branchData.todayTime!.endTime.validate(), isHoliday: widget.branchData.todayTime!.isHoliday.validate().getBoolInt())
                                .$1
                                .validate(),
                            color: getBranchIsOpen(startTime: widget.branchData.todayTime!.startTime.validate(), endTime: widget.branchData.todayTime!.endTime.validate(), isHoliday: widget.branchData.todayTime!.isHoliday.validate().getBoolInt()).$2,
                          )
                        else
                          StatusWidget(text: locale.closed, color: Colors.red),
                      ],
                    ),
                  ],
                ).paddingAll(16),
              ],
            ),
          ),
        ),
        if (((widget.currentBranchIndex == widget.selectedBranchId) && widget.isFormSignIn))
          Container(
            height: cardSize,
            width: context.width(),
            margin: EdgeInsets.only(bottom: 16),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.primaryColor.withOpacity(0.4), borderRadius: radius()),
            child: Icon(Icons.check_circle_outline_outlined, size: 40, color: white),
          ),
      ],
    );
  }
}
