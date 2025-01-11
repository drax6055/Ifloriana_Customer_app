import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep1Shimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
      listAnimationType: ListAnimationType.None,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget(height: 14, width: context.width() * 0.30),
            50.height,
            AnimatedWrap(
              runSpacing: 36,
              spacing: 16,
              columnCount: 2,
              itemCount: 20,
              listAnimationType: ListAnimationType.None,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ShimmerWidget(
                      child: Container(
                        width: context.width() / 2 - 30,
                        padding: EdgeInsets.only(top: 48, left: 16, right: 16),
                        decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                        child: ShimmerWidget(height: 68, width: context.width() * 0.25),
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
            ),
          ],
        ),
      ],
    );
  }
}
