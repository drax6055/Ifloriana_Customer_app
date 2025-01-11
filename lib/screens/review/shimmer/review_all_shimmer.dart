import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class ReviewAllShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: 20,
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
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
                      ShimmerWidget(height: 16, width: context.width() * 0.25),
                    ],
                  ).expand(),
                  ShimmerWidget(height: 12, width: context.width() * 0.15),
                ],
              ),
              10.height,
              ShimmerWidget(height: 12, width: context.width() * 0.50),
            ],
          ),
        );
      },
    );
  }
}
