import 'package:flutter/material.dart';
import 'package:ifloriana/screens/package/component/package_card.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class YourPackageComponent extends StatelessWidget {
  const YourPackageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final package = bookingRequestStore.selectedPackageList.first;
    final DateTime endDate = DateTime.parse(package.endDate.validate());
    final bool isExpired = endDate.isBefore(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.yourPackage, style: boldTextStyle(size: LABEL_TEXT_SIZE))
            .paddingBottom(14),
        PackageCard(
          package: package,
          cardColor: context.cardColor.withOpacity(0.5),
          isSelected: true,
          showRemainingQty: true,
          onPurchase: () {
          },
          showPurchaseButton: false, // Hide the action button
    ),
    //     Container(
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: context.cardColor,
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Text(
    //                       package.name.validate(),
    //                       style: primaryTextStyle(size: 14, weight: FontWeight.bold),
    //                     ),
    //                     Text("  (${locale.reused})", style: secondaryTextStyle()),
    //                   ],
    //                 ),
    //                 SizedBox(height: 4),
    //                 Text(
    //                   formatPackageDates(date: endDate),
    //                   style: primaryTextStyle(
    //                     size: 12,
    //                     weight: FontWeight.bold,
    //                     color: isExpired ? redColor : secondaryColor,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Text(
    //               '\$${package.packagePrice}',
    //               style: boldTextStyle(color: secondaryColor),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
        ],
    );
  }
}
