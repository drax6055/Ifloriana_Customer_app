import 'package:flutter/material.dart';
import 'package:ifloriana/screens/booking/shimmer/booking_list_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';
import '../../../utils/colors.dart';

class BookingStatusListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
        children: [
          Container(
            color: context.scaffoldBackgroundColor,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: primaryColor,
              tabs: List.generate(6, (index) {
                return Tab(child: ShimmerWidget(height: 25, width: context.width() * 0.14));
              }),
            ),
          ),
          TabBarView(
            children: List.generate(6, (index) {
              return BookingListShimmer();
            }),
          ).expand(),
        ],
      ),
    );
  }
}
