import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/booking/view/booking_screen.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/view/package_list_screen.dart';
import 'package:ifloriana/screens/package/view/package_screen.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ExistingPackagesComponent extends StatefulWidget {
  final List<PackageListData> packageList;
  final VoidCallback? onTap;

  const ExistingPackagesComponent({super.key, required this.packageList, this.onTap});

  @override
  State<ExistingPackagesComponent> createState() => _ExistingPackagesComponentState();
}

class _ExistingPackagesComponentState extends State<ExistingPackagesComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        ViewAllLabel(
          label: locale.existingPackages,
          trailingText: locale.upgrade,
          onTap: () {
            PackageListScreen().launch(context);
          },
        ).paddingLeft(16),
        AnimatedListView(
          itemCount: widget.packageList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            PackageListData data = widget.packageList[index];
            return GestureDetector(
              onTap: () {
                PackagesScreen().launch(context);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                decoration: BoxDecoration(borderRadius: radius(), color: quaternaryButtonColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.name.validate(), style: primaryTextStyle(size: 14, weight: FontWeight.bold)).paddingBottom(4),
                        if (formatPackageDates(date: DateTime.parse(data.endDate.validate())).contains(locale.days))
                          Text(formatPackageDates(date: DateTime.parse(data.endDate.validate())), style: primaryTextStyle(size: 12, weight: FontWeight.bold, color: wishListColor)),
                      ],
                    ),
                    CachedImageWidget(
                      url: ic_card_off,
                      height: 26,
                      width: 26,
                      color: secondaryColor,
                      fit: BoxFit.cover,
                    ),
                  ],
                ).paddingAll(16),
              ),
            );
          },
        ),
      ],
    );
  }
}
