import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../experts/model/employee_detail_response.dart';

class EmployeeListComponent extends StatelessWidget {
  final EmployeeData expertData;
  final double? width;
  final Decoration? decoration;
  final Color? expertNameTextColor;

  EmployeeListComponent({required this.expertData, this.width, this.decoration, this.expertNameTextColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: width ?? (context.width() - 48) / 2,
          padding: EdgeInsets.only(top: 48, left: 16, right: 16),
          decoration: decoration ?? boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
          child: Column(
            children: [
              Marquee(child: Text(expertData.fullName.validate(), style: boldTextStyle(color: expertNameTextColor), textAlign: TextAlign.center)),
              6.height,
              if (expertData.expert.validate().isNotEmpty) Marquee(child: Text(expertData.expert.validate(), style: secondaryTextStyle())),
              6.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.scaffoldBackgroundColor),
                child: TextIcon(
                  text: expertData.ratingStar.validate().toStringAsFixed(1).toString(),
                  spacing: 4,
                  edgeInsets: EdgeInsets.only(left: 0),
                  prefix: Icon(Icons.star, size: 16, color: getRatingBarColor(expertData.ratingStar.validate().toInt())),
                ),
              ),
              16.height,
            ],
          ),
        ),
        Positioned(
          top: -24,
          child: CachedImageWidget(
            url: expertData.profileImage.validate(),
            height: 65,
            width: 65,
            circle: true,
            fit: BoxFit.cover,
            child: DefaultUserImagePlaceholder(),
          ),
        ),
      ],
    );
  }
}
