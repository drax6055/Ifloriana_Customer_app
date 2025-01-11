import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BranchServiceShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: AnimatedListView(
        itemCount: 20,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget(height: 36, width: 36).cornerRadiusWithClipRRect(18),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(height: 12, width: context.width() * 0.20),
                    4.height,
                    ShimmerWidget(height: 10, width: context.width() * 0.15),
                  ],
                ).expand(),
                20.width,
                ShimmerWidget(height: 12, width: context.width() * 0.10),
              ],
            ),
          );
        },
      ),
    );
  }
}
