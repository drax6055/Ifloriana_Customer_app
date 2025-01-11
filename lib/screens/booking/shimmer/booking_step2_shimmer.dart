import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep2Shimmer extends StatelessWidget {
  final bool isFromBookingInfoDetail;

  BookingStep2Shimmer({this.isFromBookingInfoDetail = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: isFromBookingInfoDetail ? 10 : 80, bottom: isFromBookingInfoDetail ? 60 : 80),
      listAnimationType: ListAnimationType.None,
      children: [
        ShimmerWidget(height: 14, width: context.width() * 0.15),
        18.height,
        ShimmerWidget(height: 150, width: context.width()),
        30.height,
        ShimmerWidget(height: 14, width: context.width() * 0.30),
        18.height,
        Container(
          padding: EdgeInsets.all(16),
          width: context.width(),
          margin: EdgeInsets.only(bottom: 50),
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  10.height,
                  AnimatedWrap(
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: 12,
                    listAnimationType: ListAnimationType.None,
                    itemBuilder: (p0, p1) {
                      return ShimmerWidget(height: 28, width: context.width() / 3 - 35);
                    },
                  ),
                ],
              ),
              20.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  10.height,
                  AnimatedWrap(
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: 12,
                    listAnimationType: ListAnimationType.None,
                    itemBuilder: (p0, p1) {
                      return ShimmerWidget(height: 28, width: context.width() / 3 - 35);
                    },
                  ),
                ],
              ),
              20.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  10.height,
                  AnimatedWrap(
                    spacing: 16,
                    runSpacing: 16,
                    itemCount: 12,
                    listAnimationType: ListAnimationType.None,
                    itemBuilder: (p0, p1) {
                      return ShimmerWidget(height: 28, width: context.width() / 3 - 35);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
