import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/constants.dart';

class ViewAllLabel extends StatelessWidget {
  final String? label;
  final TextStyle? labelTextStyle;
  final ButtonStyle? buttonStyle;
  final String? trailingText;
  final List? list;
  final VoidCallback? onTap;
  final int? labelSize;
  final bool isShowAll;
  final Color? trailingTextColor;
  final Widget? labelWidget;

  ViewAllLabel({
    this.label,
    this.onTap,
    this.labelSize,
    this.list,
    this.isShowAll = true,
    this.trailingText,
    this.trailingTextColor,
    this.labelWidget,
    this.labelTextStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        labelWidget ?? Text(label.validate(), style: labelTextStyle ?? boldTextStyle(size: labelSize ?? LABEL_TEXT_SIZE)),
        if (isShowAll)
          TextButton(
            style: buttonStyle,
            onPressed: (list == null ? true : isViewAllVisible(list!))
                ? () {
                    onTap?.call();
                  }
                : null,
            child: (list == null ? true : isViewAllVisible(list!))
                ? Text(trailingText ?? locale.viewAll,
                    style: secondaryTextStyle(
                      color: trailingTextColor ?? context.primaryColor,
                      size: 12,
                    ))
                : SizedBox(),
          )
        else
          46.height,
      ],
    );
  }
}

bool isViewAllVisible(List list) => list.length >= 4;
