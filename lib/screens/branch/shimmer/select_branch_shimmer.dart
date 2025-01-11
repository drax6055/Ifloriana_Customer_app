import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectBranchShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 150, width: context.width()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.30),
                  12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShimmerWidget(height: 16, width: 16),
                      12.width,
                      ShimmerWidget(height: 10, width: context.width() * 0.16),
                    ],
                  ),
                  6.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShimmerWidget(height: 16, width: 16),
                      12.width,
                      ShimmerWidget(height: 10, width: context.width() * 0.40),
                    ],
                  ),
                  8.height,
                  Row(
                    children: [
                      Row(
                        children: [
                          ShimmerWidget(height: 16, width: 16),
                          10.width,
                          ShimmerWidget(height: 10, width: context.width() * 0.30),
                        ],
                      ).expand(),
                      ShimmerWidget(
                        child: Container(
                          height: 30,
                          width: 50,
                          decoration: boxDecorationDefault(color: context.cardColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingAll(16),
            ],
          ),
        );
      },
    );
  }
}
