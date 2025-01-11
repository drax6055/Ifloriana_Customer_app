import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class CommonAppComponent extends StatefulWidget {
  final String? subTitle;
  final Widget? innerWidget;
  final Widget? cardWidget;
  final Widget? subWidget;
  final Widget? profileCircleWidget;
  final double? mainWidgetHeight;
  final double? subWidgetHeight;
  final RefreshCallback? onSwipeRefresh;
  final VoidCallback? onNextPage;

  CommonAppComponent({
    this.subTitle,
    this.innerWidget,
    this.cardWidget,
    this.subWidget,
    this.mainWidgetHeight,
    this.subWidgetHeight,
    this.profileCircleWidget,
    this.onSwipeRefresh,
    this.onNextPage,
  });

  @override
  State<CommonAppComponent> createState() => _CommonAppComponentState();
}

class _CommonAppComponentState extends State<CommonAppComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 24),
      onSwipeRefresh: widget.onSwipeRefresh,
      onNextPage: widget.onNextPage,
      listAnimationType: ListAnimationType.None,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: context.width(),
              height: widget.mainWidgetHeight ?? 150,
              decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20), backgroundColor: primaryColor),
              child: widget.innerWidget,
            ),
            Column(
              children: [
                widget.profileCircleWidget ??
                    Container(
                      margin: EdgeInsets.only(top: widget.subWidgetHeight ?? 120, left: 24, bottom: 24, right: 24),
                      decoration: appStore.isDarkMode
                          ? boxDecorationWithRoundedCorners(backgroundColor: context.cardColor)
                          : boxDecorationWithRoundedCorners(
                              backgroundColor: context.cardColor,
                              boxShadow: [
                                BoxShadow(spreadRadius: 0.4, blurRadius: 3, color: gray.withOpacity(0.1), offset: Offset(1, 6)),
                              ],
                            ),
                      child: widget.cardWidget.validate(),
                    ),
                widget.subWidget.validate(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
