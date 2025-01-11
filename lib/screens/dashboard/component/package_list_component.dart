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
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      maxChildSize: 0.88,
                      minChildSize: 0.3,
                      expand: false,
                      builder: (context, scrollController) {
                        return PackageBottomSheetComponent(
                          scrollController: scrollController,
                          package: data,
                          isPurchased: data.userPackage.isNotEmpty,
                          onPurchase: () {
                            finish(context);
                            bookingRequestStore.selectedPackageList.clear();
                            bookingRequestStore.selectedPackageList.add(data);
                            bookingRequestStore.setPackagePurchase(true);
                            BookingScreen(services: [], packages: bookingRequestStore.selectedPackageList, isPackagePurchase: true).launch(context).then((value) => setState(() {}));
                          },
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: index.isEven ? quaternaryButtonColor : context.cardColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        // Ensures the overlay can extend beyond the boundaries
                        children: [
                          CachedImageWidget(
                            url: data.packageImage.toString(),
                            width: context.width(),
                            height: 100,
                            fit: BoxFit.cover,
                            radius: 12.0,
                          ).paddingOnly(top: 5, bottom: 12, left: 5, right: 5),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: PriceWidget(
                                price: data.packagePrice.validate(),
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Marquee(
                          child: Text(
                        data.name.validate(),
                        style: boldTextStyle(
                            color: index.isEven
                                ? black
                                : appStore.isDarkMode
                                    ? white
                                    : black),
                      )).paddingOnly(right: 16, left: 16, bottom: 8,top: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(locale.explore, style: primaryTextStyle(color: context.primaryColor)).onTap(() {}).paddingOnly(right: 16, left: 16, bottom: 12),
                          CachedImageWidget(
                            url: ic_card_off,
                            height: 22,
                            width: 22,
                            fit: BoxFit.cover,
                            color: index.isEven
                                ? secondaryColor
                                : appStore.isDarkMode
                                    ? white
                                    : black,
                          ).paddingOnly(right: 16, left: 16, bottom: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ).visible(data.branchId == appStore.branchId);
            }),
      ],
    );
  }
}
