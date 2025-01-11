import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/booking/view/booking_screen.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/view/package_list_screen.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package_bottom_sheet_component.dart';

class PackageListComponent extends StatefulWidget {
  final List<PackageListData> packagesList;

  const PackageListComponent({super.key, required this.packagesList});

  @override
  State<PackageListComponent> createState() => _PackageListComponentState();
}

class _PackageListComponentState extends State<PackageListComponent> {
  List<PackageListData> filteredPackagesList = [];
  @override
  void initState() {
    super.initState();
    filteredPackagesList = widget.packagesList.where((data) => data.branchId == appStore.branchId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.ourPackages,
          list: widget.packagesList,
          onTap: () {
            PackageListScreen().launch(context).then((value) {
              setStatusBarColor(Colors.transparent);
            });
          },
        ).paddingSymmetric(horizontal: 16).visible(filteredPackagesList.isNotEmpty),
        HorizontalList(
            itemCount: widget.packagesList.length > 10 ? widget.packagesList.take(10).length : widget.packagesList.length,
            spacing: widget.packagesList.where((data) => data.branchId == appStore.branchId).length == 1 ? 2 : 14,
            itemBuilder: (context, index) {
              PackageListData data = widget.packagesList[index];
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    builder: (context) {
                      final itemCount = data.userPackage.length;
                      final maxItemsToShow = 10;
                      final childSize = itemCount <= maxItemsToShow
                          ? (0.3 + (itemCount * 0.1)) 
                          : 0.88;
                          return SingleChildScrollView(
                            child: PackageBottomSheetComponent(
                              // scrollController: scrollController,
                              package: data,
                              isPurchased: data.userPackage.isNotEmpty,
                              onPurchase: () {
                                finish(context);
                                bookingRequestStore.selectedPackageList.clear();
                                bookingRequestStore.selectedPackageList.add(data);
                                bookingRequestStore.setPackagePurchase(true);
                                BookingScreen(services: [], packages: bookingRequestStore.selectedPackageList, isPackagePurchase: true).launch(context).then((value) => setState(() {}));
                              },
                            ),
                          );
                    },
                  );
                },
                child: Container(
                  width: 180,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: index.isEven ? quaternaryButtonColor : context.cardColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedImageWidget(
                        url: ic_card_off,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        color: index.isEven
                            ? secondaryColor
                            : appStore.isDarkMode
                                ? white
                                : black,
                      ).paddingBottom(16),
                      Marquee(
                          child: Text(
                        data.name.validate(),
                        style: boldTextStyle(
                            color: index.isEven
                                ? black
                                : appStore.isDarkMode
                                    ? white
                                    : black),
                      )).paddingBottom(8),
                      PriceWidget(
                        price: data.packagePrice.validate(),
                        size: 16,
                      ).paddingBottom(12),
                      Text(locale.explore, style: primaryTextStyle(color: context.primaryColor)).onTap(() {})
                    ],
                  ),
                ),
              ).visible(data.branchId == appStore.branchId);
            }),
      ],
    );
  }
}
