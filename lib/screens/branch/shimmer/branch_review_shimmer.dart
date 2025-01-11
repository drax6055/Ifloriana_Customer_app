import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BranchReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ShimmerWidget(height: 16, width: context.width() * 0.25),
                  4.width,
                  ShimmerWidget(height: 14, width: context.width() * 0.15),
                ],
              ),
              ShimmerWidget(height: 16, width: context.width() * 0.15),
            ],
          ),
          8.height,
          AnimatedListView(
            itemCount: 20,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            listAnimationType: ListAnimationType.None,
            itemBuilder: (p0, index) {
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
                            ShimmerWidget(height: 22, width: 35),
                            8.width,
                            ShimmerWidget(height: 14, width: context.width() * 0.25),
                          ],
                        ).expand(),
                        ShimmerWidget(height: 12, width: context.width() * 0.12),
                      ],
                    ),
                    10.height,
                    ShimmerWidget(height: 10, width: context.width() * 0.50),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
