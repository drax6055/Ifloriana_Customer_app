import 'package:flutter/material.dart';
import 'package:ifloriana/screens/branch/model/branch_configuration_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

class SlotItemComponent extends StatefulWidget {
  final SlotData timeSlot;
  final bool isSelected;
  final DateTime selectedHorizontalDate;
  final VoidCallback? onTap;
  final String? selectedTime;

  SlotItemComponent({required this.timeSlot, required this.isSelected, this.onTap, required this.selectedHorizontalDate, this.selectedTime});

  @override
  State<SlotItemComponent> createState() => _SlotItemComponentState();
}

class _SlotItemComponentState extends State<SlotItemComponent> {
  @override
  Widget build(BuildContext context) {
    // Format the start time to ensure consistency for comparison
    String formattedSlotTime = formatOnlyTime(context, startTime: widget.timeSlot.startTime);
    // Compare the formatted slot time with the selected time
    bool isSelected = formattedSlotTime == widget.selectedTime &&
        widget.timeSlot.slotAvailability(widget.selectedHorizontalDate);
    return GestureDetector(
      onTap: () async {
        widget.onTap?.call();
      },
      child: Container(
        width: context.width() / 3 - 35,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(),
          backgroundColor: isSelected
              ? indicatorColor
              : widget.timeSlot.slotAvailability(widget.selectedHorizontalDate)
                  ? context.scaffoldBackgroundColor
                  : context.scaffoldBackgroundColor,
        ),
        child: Marquee(
          child: Text(
            formatOnlyTime(context, startTime: widget.timeSlot.startTime),
            style: boldTextStyle(
              size: 12,
              color: widget.isSelected ? Colors.black : textSecondaryColorGlobal,
              decoration: !widget.timeSlot.slotAvailability(widget.selectedHorizontalDate) ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
