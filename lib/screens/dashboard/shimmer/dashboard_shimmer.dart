import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';
import '../../../main.dart';
import '../../../utils/constants.dart';

class DashboardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Appbar UI
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              ShimmerWidget(height: 190, width: context.width()).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
              Positioned(
                bottom: -25,
                left: 16,
                right: 16,
                child: ShimmerWidget(height: 50, width: context.width(), backgroundColor: context.cardColor),
              ),
            ],
          ),

          /// Quick Book Appointment UI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              ShimmerWidget(height: 20, width: context.width() * 0.25),
              16.height,
              Row(
                children: [
                  ShimmerWidget(height: 50).expand(),
                  16.width,
                  ShimmerWidget(height: 50).expand(),
                ],
              ),
              16.height,
              ShimmerWidget(height: 50, width: context.width()),
              16.height,
              ShimmerWidget(height: 50, width: context.width()),
            ],
          ).paddingOnly(left: 16, right: 16, top: 25, bottom: 30),

          /// Package UI
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 20, width: context.width() * 0.25),
                  ShimmerWidget(height: 20, width: context.width() * 0.15),
                ],
              ).paddingSymmetric(horizontal: 16),
              HorizontalList(
                padding: EdgeInsets.all(16),
                itemCount: 10,
                spacing: 16,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShimmerWidget(height: 180, width: 180);
                },
              ),
            ],
          ),

          /// Category UI
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 20, width: context.width() * 0.25),
                  ShimmerWidget(height: 20, width: context.width() * 0.15),
                ],
              ).paddingSymmetric(horizontal: 16),
              AnimatedWrap(
                runSpacing: 16,
                spacing: 16,
                columnCount: 2,
                itemCount: 6,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (ctx, i) {
                  return ShimmerWidget(
                    child: Container(
                      width: context.width() / 3 - 20,
                      padding: EdgeInsets.zero,
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                      child: Column(
                        children: [
                          Container(
                            width: context.width() / 3 - 20,
                            height: CATEGORY_ICON_SIZE,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: context.cardColor, shape: BoxShape.circle),
                          ),
                          Container(
                            width: 60,
                            height: 10,
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).paddingOnly(top: 16, left: 8, right: 8, bottom: 32),
            ],
          ),

          /// Slider UI
          ShimmerWidget(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  width: context.width(),
                  color: context.cardColor,
                ),
                Positioned(
                  bottom: -24,
                  right: 16,
                  left: 16,
                  child: Container(
                    height: 60,
                    width: context.width(),
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkMode ? Colors.black12 : Colors.white30),
                  ),
                )
              ],
            ),
          ).paddingSymmetric(horizontal: 16),

          /// Top Experts UI
          Column(
            children: [
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 20, width: context.width() * 0.25),
                  ShimmerWidget(height: 20, width: context.width() * 0.15),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 16),
              30.height,
              AnimatedWrap(
                runSpacing: 42,
                spacing: 16,
                columnCount: 2,
                itemCount: 6,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (_, i) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ShimmerWidget(
                        child: Container(
                          width: (context.width() - 48) / 2,
                          padding: EdgeInsets.only(top: 48, left: 16, right: 16),
                          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                          child: Column(
                            children: [
                              ShimmerWidget(height: 20, width: context.width() * 0.25),
                              6.height,
                              ShimmerWidget(height: 20, width: context.width() * 0.25),
                              6.height,
                              Container(
                                height: 10,
                                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                              ),
                              16.height,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -30,
                        left: 46,
                        child: ShimmerWidget(
                          child: Container(
                            width: 62,
                            height: 62,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: context.cardColor, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
            ],
          ),

          /// Nearby Branches UI
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 20, width: context.width() * 0.25),
                  ShimmerWidget(height: 20, width: context.width() * 0.15),
                ],
              ).paddingOnly(left: 16, right: 16, top: 20),
              HorizontalList(
                itemCount: 5,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                spacing: 16,
                itemBuilder: (context, index) {
                  return ShimmerWidget(
                    child: Container(
                      height: 200,
                      width: context.width() * 0.91,
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                    ),
                  );
                },
              ),
            ],
          ),
          16.height,
        ],
      ),
    );
  }
}
