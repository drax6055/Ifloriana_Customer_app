import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingDetailShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      padding: EdgeInsets.all(16),
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        /// Location Information UI
        ShimmerWidget(height: 12, width: context.width() * 0.30),
        14.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.15),
                  ShimmerWidget(height: 12, width: context.width() * 0.27),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.17),
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.19),
                  ShimmerWidget(height: 12, width: context.width() * 0.29),
                ],
              ),
            ],
          ),
        ),
        30.height,

        /// Booking Information UI
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(height: 12, width: context.width() * 0.35),
            ShimmerWidget(height: 12, width: context.width() * 0.15),
          ],
        ).paddingRight(16),
        14.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                  ShimmerWidget(height: 12, width: context.width() * 0.28),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.15),
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                ],
              ),
              10.height,
            ],
          ),
        ),
        30.height,

        /// Service UI
        ShimmerWidget(height: 12, width: context.width() * 0.35),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 14),
          child: AnimatedWrap(
            runSpacing: 10,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return Row(
                children: [
                  ShimmerWidget(
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.circle),
                    ),
                  ),
                  8.width,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerWidget(height: 12).expand(flex: 2),
                      16.width,
                      ShimmerWidget(height: 12).expand(flex: 1),
                    ],
                  ).expand(),
                ],
              );
            },
          ),
        ),
        38.height,

        /// Price Details UI
        ShimmerWidget(height: 12, width: context.width() * 0.30),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 14,bottom: 16),
          child: Column(
            children: [
              /// Subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.22),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,

              /// Tax
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.18),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,

              /// Tip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.20),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,

              /// Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.22),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
            ],
          ),
        ),
        26.height,

        /// Payment Details UI
        ShimmerWidget(height: 12, width: context.width() * 0.30),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 14, bottom: 16),
          child: Column(
            children: [
              /// Transaction ID
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,

              /// Payment Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
              10.height,

              /// Payment Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 12, width: context.width() * 0.25),
                  ShimmerWidget(height: 12, width: context.width() * 0.16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
