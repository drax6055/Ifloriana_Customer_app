import 'package:flutter/material.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class PackageCard extends StatefulWidget {
  final PackageListData package;
  final bool isSelected;
  final bool showReclaimButton;
  final VoidCallback? onPurchase;
  final Color? cardColor;
  final bool showRemainingQty;
  final bool showPurchaseButton;
  final bool? isViewAll;
  final bool isPurchased;

  const PackageCard({
    super.key,
    this.showRemainingQty = false,
    this.cardColor,
    this.onPurchase,
    required this.package,
    required this.isSelected,
    this.showReclaimButton = false,
    this.isViewAll,
    this.showPurchaseButton = true,
    this.isPurchased = false,
  });

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final DateTime endDate = DateTime.parse(widget.package.endDate.validate());
    final bool isExpired = endDate.isBefore(DateTime.now());

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: radius(),
          color: widget.cardColor ?? (widget.isSelected ? territoryButtonColor : context.cardColor),
          border: Border.all(
            color: isHovered ? secondaryColor : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isHovered ? [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 1)] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: quaternaryButtonColor,
                  ),
                  child: Text(
                    widget.package.branchName.validate(),
                    style: boldTextStyle(color: secondaryColor, size: 12),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PriceWidget(
                      price: widget.package.packagePrice.validate(),
                    ),
                    Text(
                      formatPackageDates(
                        date: DateTime.parse(widget.package.endDate.validate()),
                      ),
                      style: secondaryTextStyle(
                          color: isExpired
                              ? Colors.red
                              : appStore.isDarkMode
                                  ? territoryButtonColor
                                  : secondaryColor),
                    )
                  ],
                ),
              ],
            ),
            Text(
              widget.package.name.validate(),
              style: boldTextStyle(
                  size: 16,
                  color: widget.isSelected
                      ? blackColor
                      : appStore.isDarkMode
                          ? Colors.white
                          : secondaryColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            8.height,
            ReadMoreText(
              widget.package.description.validate(),
              style: primaryTextStyle(size: 12, color: appTextSecondaryColor),
              trimLines: 6,
              trimMode: TrimMode.Line,
            ),
            Divider(height: 32),
            Text('${locale.whatSIncluded}:',
                style: boldTextStyle(
                    color: widget.isSelected
                        ? blackColor
                        : appStore.isDarkMode
                            ? Colors.white
                            : secondaryColor)),
            8.height,
            ...widget.package.services.map<Widget>((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_forward, color: appTextSecondaryColor, size: 14).paddingTop(2),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "${item.serviceName.validate()}",
                            style: primaryTextStyle(color: appTextSecondaryColor, size: 14),
                            children: [
                              TextSpan(
                                  text: " (${item.durationMin} ${locale.mins})",
                                  style: boldTextStyle(
                                      size: 14,
                                      color: widget.isSelected
                                          ? blackColor
                                          : appStore.isDarkMode
                                              ? Colors.white
                                              : secondaryColor)),
                            ],
                          ),
                        ).paddingBottom(6),
                        RichText(
                          text: TextSpan(
                            text: "${locale.quantity}: ",
                            style: primaryTextStyle(color: appTextSecondaryColor, size: 14),
                            children: [
                              if (!widget.showRemainingQty)
                                TextSpan(
                                    text: item.qty.toString(),
                                    style: boldTextStyle(
                                        size: 14,
                                        color: widget.isSelected
                                            ? blackColor
                                            : appStore.isDarkMode
                                                ? Colors.white
                                                : secondaryColor)),
                              if (widget.showRemainingQty)
                                TextSpan(
                                    text: item.totalQty.toString(),
                                    style: boldTextStyle(
                                        size: 14,
                                        color: widget.isSelected
                                            ? blackColor
                                            : appStore.isDarkMode
                                                ? Colors.white
                                                : secondaryColor)),
                              if (widget.showRemainingQty)
                                TextSpan(
                                    text: "  (${locale.remainingQuantity} - ${item.remainingQty.toString()}/${item.totalQty.toString()})",
                                    style: secondaryTextStyle(
                                        size: 12,
                                        color: widget.isSelected
                                            ? blackColor
                                            : appStore.isDarkMode
                                                ? Colors.white
                                                : secondaryColor)),
                            ],
                          ),
                        ).paddingBottom(8)
                      ],
                    ).expand()
                  ],
                ),
              );
            }).toList(),
            if (widget.showPurchaseButton || (widget.isPurchased && widget.showReclaimButton))
              AppButton(
                width: double.infinity,
                text: widget.showReclaimButton ? locale.useNow : locale.purchaseNow,
                textStyle: primaryTextStyle(color: white),
                color: secondaryColor,
                onTap: () {
                  widget.onPurchase?.call();
                },
              ).paddingTop(8),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
