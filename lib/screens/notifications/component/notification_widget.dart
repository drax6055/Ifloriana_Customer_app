import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../model/notification_model.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationData notificationData;

  NotificationWidget({required this.notificationData});

  Color _getBGColor(BuildContext context) {
    if (notificationData.readAt != null) {
      return context.scaffoldBackgroundColor;
    } else {
      return context.cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: boxDecorationDefault(
        color: _getBGColor(context),
        borderRadius: radius(0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImageWidget(url: ic_notification_user, height: 40),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notificationData.data != null && notificationData.data!.notificationDetail != null) Text('#${notificationData.data!.notificationDetail!.id.validate()}', style: boldTextStyle(size: 12)).expand(),
                  Text(formatDate(notificationData.createdAt.validate()), style: secondaryTextStyle()),
                ],
              ),
              8.height,
              Text(notificationData.data!.subject.validate(), style: secondaryTextStyle(), maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
