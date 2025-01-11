import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/branch/model/branch_response.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/extensions/text_icons.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/status_widget.dart';
import '../../../utils/common_base.dart';

class BranchInformationComponent extends StatefulWidget {
  final BranchData branchData;

  BranchInformationComponent({required this.branchData});

  @override
  State<BranchInformationComponent> createState() => _BranchInformationComponentState();
}

class _BranchInformationComponentState extends State<BranchInformationComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Widget shopInfoWidget({Color? color, String? title, String? icon, VoidCallback? callback}) {
    return Container(
      decoration: boxDecorationDefault(color: color ?? context.cardColor),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            icon.iconImage(size: 16, color: secondaryColor),
          if (icon != null && title != null) SizedBox(width: 8),
          if (title != null)
            Flexible(
              child: Marquee(
                child: Text(
                  title.validate(),
                  style: primaryTextStyle(color: secondaryColor, size: 14),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ).onTap(callback),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                Text(widget.branchData.name.validate(), style: boldTextStyle(size: 16)),
                6.width,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: quaternaryButtonColor),
                  child: Text(widget.branchData.branchFor.validate().capitalizeFirstLetter(), style: primaryTextStyle(color: secondaryColor, size: 12)),
                ),
              ],
            ).expand(),
            if (widget.branchData.todayTime != null)
              StatusWidget(
                text: getBranchIsOpen(startTime: widget.branchData.todayTime!.startTime.validate(), endTime: widget.branchData.todayTime!.endTime.validate(), isHoliday: widget.branchData.todayTime!.isHoliday.validate().getBoolInt()).$1.validate(),
                color: getBranchIsOpen(startTime: widget.branchData.todayTime!.startTime.validate(), endTime: widget.branchData.todayTime!.endTime.validate(), isHoliday: widget.branchData.todayTime!.isHoliday.validate().getBoolInt()).$2,
              ),
          ],
        ),
        if (widget.branchData.addressLine1.validate().isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextIcon(
                text: widget.branchData.addressLine1.validate(),
                spacing: 12,
                textStyle: primaryTextStyle(),
                maxLine: 2,
                expandedText: true,
                edgeInsets: EdgeInsets.only(left: 0),
                prefix: ic_location.iconImage(color: textSecondaryColorGlobal, size: 16),
              ),
              8.height,
            ],
          ),
        Row(
          children: [
            Icon(Icons.star, size: 18, color: getRatingBarColor(widget.branchData.ratingStar.validate().toInt())),
            12.width,
            Text(widget.branchData.ratingStar.validate().toStringAsFixed(1), style: primaryTextStyle()),
            if (widget.branchData.totalReview.validate() >= 1)
              Text(
                '(${locale.basedOn} ${widget.branchData.totalReview.validate()} ${locale.review}${widget.branchData.totalReview.validate() > 1 ? '${locale.s}' : ''})',
                style: secondaryTextStyle(),
              ).paddingLeft(4),
          ],
        ),
        24.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shopInfoWidget(
              color: territoryButtonColor,
              icon: ic_call,
              title: locale.call,
              callback: () {
                launchCall(appStore.branchContactNumber);
              },
            ).expand(),
            12.width,
            shopInfoWidget(
              color: quaternaryButtonColor,
              icon: ic_direction,
              title: locale.direction,
              callback: () {
                commonLaunchUrl('https://www.google.com/maps/search/?api=1&query=${widget.branchData.latitude},${widget.branchData.longitude}', launchMode: LaunchMode.externalApplication);
              },
            ).expand(),
            12.width,
            shopInfoWidget(
              color: territoryButtonColor,
              icon: ic_share,
              title: locale.share,
              callback: () async {
                String shareBranch = "${locale.branchName}: ${widget.branchData.name}";

                if (widget.branchData.addressLine1.validate().isNotEmpty) shareBranch = '$shareBranch\n${locale.place}: ${widget.branchData.addressLine1}';
                if (widget.branchData.contactNumber.validate().isNotEmpty) shareBranch = '$shareBranch\n${locale.contactNumber}: ${widget.branchData.contactNumber}';

                Share.share(shareBranch);
              },
            ).expand(),
          ],
        ),
      ],
    ).paddingSymmetric(vertical: 16, horizontal: 16);
  }
}
