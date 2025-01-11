import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/package/component/package_card.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class PackageBottomSheetComponent extends StatefulWidget {
  final ScrollController? scrollController;
  final PackageListData package;
  final VoidCallback? onPurchase;
  final bool isPurchased;

  const PackageBottomSheetComponent({super.key,this.onPurchase, this.scrollController, required this.package,required this.isPurchased});

  @override
  State<PackageBottomSheetComponent> createState() => _PackageBottomSheetComponentState();
}

class _PackageBottomSheetComponentState extends State<PackageBottomSheetComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(color: context.cardColor),
        child: AnimatedScrollView(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.packageDetail, style: boldTextStyle(size: 16)),
                CachedImageWidget(
                  url: ic_close,
                  height: 22,
                  color: Colors.grey.shade500,
                ).onTap(() {
                  finish(context);
                })
              ],
            ).paddingOnly(top: 16, right: 16, left: 16),
            PackageCard(
              package: widget.package,
              cardColor: quaternaryButtonColor,
              isSelected: true,
              onPurchase:() {
                widget.onPurchase?.call();
              },
              showPurchaseButton: !widget.isPurchased,
              showReclaimButton: widget.isPurchased,
              isPurchased: widget.isPurchased,
            ),
          ],
        ),
      ),
    );
  }
}