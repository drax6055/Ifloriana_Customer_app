import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      shrinkWrap: true,
      itemCount: 20,
      padding: EdgeInsets.only(top: 8),
      physics: AlwaysScrollableScrollPhysics(),
      listAnimationType: ListAnimationType.None,
      itemBuilder: (ctx, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget(
              child: Container(
                height: 40,
                width: 40,
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, boxShape: BoxShape.circle),
              ),
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(height: 12, width: context.width() * 0.15).expand(),
                    16.width,
                    ShimmerWidget(height: 10, width: context.width() * 0.25),
                  ],
                ),
                8.height,
                ShimmerWidget(height: 10, width: context.width() * 0.30),
              ],
            ).expand(),
          ],
        ).paddingSymmetric(vertical: 10, horizontal: 16);
      },
    );
  }
}
