import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedWrap(
        runSpacing: 16,
        spacing: 16,
        itemCount: 20,
        listAnimationType: ListAnimationType.None,
        itemBuilder: (ctx, index) {
          return Container(
            width: context.width() / 3 - 22,
            padding: EdgeInsets.zero,
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
            child: Column(
              children: [
                ShimmerWidget(height: 85, width: context.width() / 3 - 22),
                ShimmerWidget(height: 10, width: context.width() * 0.15).paddingSymmetric(vertical: 8, horizontal: 8),
              ],
            ),
          );
        },
      ),
    ).paddingAll(16);
  }
}
