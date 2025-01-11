import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeSocialAccountsComponent extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;

  EmployeeSocialAccountsComponent({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: territoryButtonColor),
        child: CachedImageWidget(url: icon, height: 12, width: 12, fit: BoxFit.cover, color: context.primaryColor).paddingAll(6),
      ),
    );
  }
}
