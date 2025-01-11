import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: context.cardColor,
            child: Column(
              children: [
                ShimmerWidget(
                  height: 70,
                  child: AppBar(
                    backgroundColor: context.cardColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                  ),
                ),
                16.height,
                ShimmerWidget(height: 98, width: 98).cornerRadiusWithClipRRect(150),
                Column(
                  children: [
                    14.height,
                    ShimmerWidget(height: 18, width: context.width() * 0.25),
                    4.height,
                    ShimmerWidget(height: 14, width: context.width() * 0.20),
                    16.height,
                    ShimmerWidget(height: 32, width: context.width() * 0.20),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerWidget(height: 40, width: 40),
                        16.width,
                        ShimmerWidget(height: 40, width: 40),
                        16.width,
                        ShimmerWidget(height: 40, width: 40),
                        16.width,
                        ShimmerWidget(height: 40, width: 40),
                      ],
                    ),
                    20.height,
                  ],
                ),
              ],
            ),
          ),
          10.height,
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// About self UI
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(height: 18, width: context.width() * 0.25),
                    10.height,
                    ShimmerWidget(height: 70, width: context.width()),
                  ],
                ),
                30.height,

                /// Contact Info UI
                ShimmerWidget(height: 18, width: context.width() * 0.25),
                16.height,
                Column(
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(height: 35, width: 35),
                        16.width,
                        ShimmerWidget(height: 14, width: context.width() * 0.25),
                      ],
                    ),
                    16.height,
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(height: 35, width: 35),
                        16.width,
                        ShimmerWidget(height: 14, width: context.width() * 0.25),
                      ],
                    ),
                    16.height,
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(height: 35, width: 35),
                        16.width,
                        ShimmerWidget(height: 14, width: context.width() * 0.25),
                      ],
                    ),
                    16.height,
                  ],
                ),
                12.height,

                /// Reviews UI
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(height: 20, width: context.width() * 0.25),
                        4.width,
                        ShimmerWidget(height: 20, width: context.width() * 0.15),
                      ],
                    ),
                    ShimmerWidget(height: 20, width: context.width() * 0.15),
                  ],
                ),
                8.height,
                AnimatedListView(
                  itemCount: 10,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
