import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../utils/constants.dart';
import '../model/category_response.dart';

class CategoryItemWidget extends StatelessWidget {
  final double? width;
  final CategoryData categoryData;

  CategoryItemWidget({this.width, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: width ?? context.width() / 3 - 20,
        padding: EdgeInsets.zero,
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: context.cardColor,
          borderRadius: BorderRadius.circular(12), // Use BorderRadius here for the entire container
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            CachedImageWidget(
              url: categoryData.categoryImage.validate(),
              width: width ?? context.width() / 3 - 20,
              height: CATEGORY_ICON_SIZE,
              fit: BoxFit.cover,
              radius: 12.0, // Use a double value for the image's corner radius
            ),
            Marquee(
              directionMarguee: DirectionMarguee.oneDirection,
              child: Text(
                categoryData.name.validate(),
                style: primaryTextStyle(size: 14),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ).paddingSymmetric(vertical: 8, horizontal: 8),
          ],
        ),
      ),
    );
  }
}
