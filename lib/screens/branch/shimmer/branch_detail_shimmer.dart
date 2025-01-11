import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BranchDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Cover Image UI
          ShimmerWidget(
            child: Container(
              height: 350,
              width: context.width(),
              color: context.cardColor,
            ),
          ),

          /// Branch Detail UI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 16, width: context.width() * 0.25),
                  ShimmerWidget(height: 30, width: 50),
                ],
              ),
              Row(
                children: [
                  ShimmerWidget(height: 16, width: 16),
                  12.width,
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                ],
              ),
              8.height,
              Row(
                children: [
                  ShimmerWidget(height: 16, width: 16),
                  10.width,
                  ShimmerWidget(height: 12, width: context.width() * 0.15),
                  4.width,
                  ShimmerWidget(height: 10, width: context.width() * 0.25),
                ],
              ),
              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerWidget(height: 30, width: 50).expand(),
                  12.width,
                  ShimmerWidget(height: 30, width: 50).expand(),
                  12.width,
                  ShimmerWidget(height: 30, width: 50).expand(),
                  12.width,
                ],
              ),
              12.height,
            ],
          ).paddingSymmetric(vertical: 16, horizontal: 16),

          /// About Tab UI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 18, width: context.width() * 0.25),
                  10.height,
                  ShimmerWidget(height: 70, width: context.width()),
                ],
              ),
              16.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 18, width: context.width() * 0.25),
                  10.height,
                  Wrap(
                    runSpacing: 8,
                    children: List.generate(7, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerWidget(height: 12, width: context.width() * 0.35),
                          ShimmerWidget(height: 12, width: context.width() * 0.15),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 16, horizontal: 16),
        ],
      ),
    );
  }
}
