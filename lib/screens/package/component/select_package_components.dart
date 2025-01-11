import 'package:flutter/material.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/price_widget.dart';
import '../../../main.dart';

class SelectPackageComponents extends StatefulWidget {
  final VoidCallback? onPackageListEmpty;
  const SelectPackageComponents({super.key, this.onPackageListEmpty});

  @override
  State<SelectPackageComponents> createState() => _SelectPackageComponentsState();
}

class _SelectPackageComponentsState extends State<SelectPackageComponents> {
  num price = 0;

  @override
  void initState() {
    super.initState();
    _initializePrice();
  }

  void _initializePrice() {
    if (bookingRequestStore.isPackagePurchase && bookingRequestStore.selectedPackageList.isNotEmpty) {
      price = bookingRequestStore.selectedPackageList.first.packagePrice!;
    }
  }

  void _deletePackage(int index) {
    showConfirmDialogCustom(
      context,
      title: 'Remove Package',
      subTitle: "Do you really want to delete ${bookingRequestStore.selectedPackageList[index].name.validate()}?",
      positiveText: 'Yes',
      negativeText: 'No',
      primaryColor: context.primaryColor,
      dialogType: DialogType.CONFIRMATION,
      onAccept: (p0) {
        setState(() {
          bookingRequestStore.selectedPackageList.removeAt(index);
          if (bookingRequestStore.selectedPackageList.isEmpty) {
            bookingRequestStore.setPackagePurchase(false);
            price = 0;
            if (widget.onPackageListEmpty != null) {
              widget.onPackageListEmpty!(); 
            }
          }
      });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (bookingRequestStore.selectedPackageList.isEmpty) {
      return Center(
        child: Text('No packages selected', style: primaryTextStyle()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Package', style: boldTextStyle()),
        16.height,
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: bookingRequestStore.selectedPackageList.length,
          itemBuilder: (context, index) {
            final package = bookingRequestStore.selectedPackageList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: radius(),
                color: context.cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.name.validate(),
                          style: boldTextStyle(size: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        4.height,
                        PriceWidget(
                          price: package.packagePrice!,
                          color: secondaryColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: primaryColor),
                    onPressed: () => _deletePackage(index),
                  ),
                ],
              ),
            );
            },
        ),
      ],
    );
  }
}
