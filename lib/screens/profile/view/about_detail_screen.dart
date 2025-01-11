import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/about_model.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';

class AboutDetailScreen extends StatelessWidget {
  final String title;
  final List<AboutModel> aboutModel;

  const AboutDetailScreen({this.title = '', required this.aboutModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        context,
        title: title,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: AnimatedWrap(
        spacing: 16,
        runSpacing: 16,
        itemCount: aboutModel.length,
        listAnimationType: ListAnimationType.None,
        itemBuilder: (context, index) {
          AboutModel data = aboutModel[index];

          return Container(
            width: context.width() * 0.5 - 26,
            padding: EdgeInsets.all(16),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(),
              backgroundColor: context.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(data.icon.toString(), height: data.iconSize, width: data.iconSize, color: context.iconColor),
                8.height,
                Marquee(
                  directionMarguee: DirectionMarguee.oneDirection,
                  animationDuration: Duration(milliseconds: 500),
                  child: Text(data.title.toString(), style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                ),
              ],
            ),
          ).onTap(
            () {
              if (data.onTap != null) {
                data.onTap?.call();
              } else if (data.widget != null) {
                data.widget!.launch(context);
              }
            },
            borderRadius: radius(),
          );
        },
      ).paddingAll(16),
    );
  }
}
