import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/colors.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(locale.ohNoYouAreLeaving, style: boldTextStyle(size: 18)),
        16.height,
        Text(locale.doYouWantToLogout, style: secondaryTextStyle(size: 14)),
        28.height,
        Row(
          children: [
            AppButton(
              child: Text(locale.no, style: boldTextStyle()),
              elevation: 0,
              onTap: () {
                finish(context);
              },
            ).expand(),
            16.width,
            AppButton(
              child: Text(locale.yes, style: boldTextStyle(color: white)),
              color: primaryColor,
              elevation: 0,
              onTap: () async {
                finish(context, true);
              },
            ).expand(),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 24);
  }
}
