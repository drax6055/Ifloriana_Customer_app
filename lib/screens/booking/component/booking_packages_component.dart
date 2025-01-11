import 'package:flutter/material.dart';
import 'package:ifloriana/screens/booking/model/booking_list_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/common_row_text_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/constants.dart';
import '../../services/models/service_response.dart';
import '../model/booking_detail_response.dart';

class BookingPackagesComponent extends StatelessWidget {
  final List<Packages> packagesList;
  final String? bookingStatus;

  BookingPackagesComponent({super.key, required this.packagesList, this.bookingStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.package,
          style: boldTextStyle(size: LABEL_TEXT_SIZE),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 12),
          child: CommonRowTextWidget(
            leadingText: packagesList.first.isReclaim == 1 ? packagesList.first.packageName.validate() + " ( ${locale.reused} )" : packagesList.first.packageName.validate(),
            trailingText: packagesList.first.packagePrice.toString(),
            isPrice: true,
            leftWidgetFlex: 2,
            rightWidgetFlex: 1,
            package: packagesList.first,
          ),
        ),
      ],
    );
  }
}
