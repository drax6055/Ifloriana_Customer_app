import 'package:flutter/material.dart';
import 'package:ifloriana/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BranchGalleryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      child: AnimatedWrap(
        runSpacing: 16,
        spacing: 16,
        itemCount: 20,
        listAnimationType: ListAnimationType.None,
        itemBuilder: (context, index) {
          return ShimmerWidget(height: 100, width: context.width() / 3 - 22).cornerRadiusWithClipRRect(defaultRadius);
        },
      ),
    );
  }
}
