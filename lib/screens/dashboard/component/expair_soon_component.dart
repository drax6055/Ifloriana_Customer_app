import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/view/package_screen.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ExpiringSoonComponent extends StatefulWidget {
  final List<PackageListData>? expiringPackageList;

  const ExpiringSoonComponent({super.key, this.expiringPackageList});

  @override
  State<ExpiringSoonComponent> createState() => _ExpiringSoonComponentState();
}

class _ExpiringSoonComponentState extends State<ExpiringSoonComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.packageExpiringSoon, style: boldTextStyle()),
        16.height,
        if(widget.expiringPackageList.validate().isNotEmpty)
        GestureDetector(
          onTap: () {
            PackagesScreen().launch(context);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: radius(), color: quaternaryButtonColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.expiringPackageList.validate().first.name.validate(), style: primaryTextStyle(size: 14, weight: FontWeight.bold, color: textPrimaryColor)),
                    4.height,
                    Text(
                      formatPackageDates(date: DateTime.parse(widget.expiringPackageList.validate().first.endDate.validate())),
                      style: primaryTextStyle(size: 12, weight: FontWeight.bold, color: wishListColor),
                    ),
                  ],
                ),
                CachedImageWidget(
                  url: ic_card_off,
                  height: 30,
                  width: 30,
                  color: secondaryColor,
                  fit: BoxFit.cover,
                ),
              ],
            ).paddingAll(16),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
