import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 20,
      padding: EdgeInsets.only(left: 8, right: 8, top: 40, bottom: 12),
      listAnimationType: ListAnimationType.None,
      shrinkWrap: true,
      itemBuilder: (p0, p1) {
        return Container(
          width: context.width(),
          margin: EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    child: Container(
                      height: 24,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 26),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor,
                        borderRadius: radiusOnly(topLeft: defaultRadius),
                      ),
                    ),
                  ),
                  ShimmerWidget(
                    child: Container(
                      height: 24,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor,
                        borderRadius: radiusOnly(topRight: defaultRadius),
                      ),
                    ),
                  ),
                ],
              ),
              12.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(height: 75, width: 75),
                      12.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget(height: 16, width: context.width()),
                          8.height,
                          ShimmerWidget(height: 12, width: context.width()),
                          10.height,
                          Row(
                            children: [
                              ShimmerWidget(height: 20, width: 20).paddingRight(4),
                              ShimmerWidget(height: 12, width: context.width()).flexible(),
                            ],
                          ),
                        ],
                      ).expand(),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  Column(
                    children: [
                      Divider(color: context.dividerColor),
                      6.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ShimmerWidget(height: 14, width: 14),
                              8.width,
                              ShimmerWidget(height: 16, width: context.width() * 0.15),
                            ],
                          ),
                          Row(
                            children: [
                              ShimmerWidget(height: 14, width: 14),
                              8.width,
                              ShimmerWidget(height: 16, width: context.width() * 0.15),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
                  ShimmerWidget(
                    child: Container(
                      height: 45,
                      width: context.width(),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                    ),
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
                  8.height,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
