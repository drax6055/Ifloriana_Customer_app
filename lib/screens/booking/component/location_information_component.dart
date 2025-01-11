import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_row_text_widget.dart';
import '../../../main.dart';
import '../model/booking_list_response.dart';

class LocationInformationComponent extends StatefulWidget {
  final BookingListData booking;

  LocationInformationComponent({required this.booking});

  @override
  State<LocationInformationComponent> createState() => _LocationInformationComponentState();
}

class _LocationInformationComponentState extends State<LocationInformationComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.locationInformation,
          trailingTextColor: Colors.red,
          isShowAll: false,
        ),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonRowTextWidget(leadingText: locale.name, trailingText: widget.booking.branchName.validate()),
              10.height,
              CommonRowTextWidget(leadingText: locale.address, trailingText: widget.booking.addressLine1.validate()),
              10.height,
              CommonRowTextWidget(leadingText: locale.contactNumber, trailingText: widget.booking.phone.validate()),
            ],
          ),
        ),
      ],
    );
  }
}
