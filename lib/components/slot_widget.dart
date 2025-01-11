import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/booking/component/slot_item_component.dart';
import '../screens/branch/model/branch_configuration_response.dart';
import '../utils/common_base.dart';

class SlotWidget extends StatefulWidget {
  final String slotDuration;
  final String startTime;
  final String endTime;
  final DateTime selectedHorizontalDate;
  final bool isFromQuickBooking;

  SlotWidget({
    required this.slotDuration,
    required this.startTime,
    required this.endTime,
    required this.selectedHorizontalDate,
    this.isFromQuickBooking = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SlotWidget> createState() => _SlotWidgetState();
}

class _SlotWidgetState extends State<SlotWidget> {
  Future<List<SlotData>>? future;
  Future<bool> checkIfSlotsFullForDate(DateTime date) async {
    List<SlotData> slots = await init();
    return !slots.any((slot) => slot.isAvailable);
  }

  int selectedIndex = -1;

  String selectedSession = '';

  @override
  void initState() {
    super.initState();
    future = init();
  }

  Future<List<SlotData>> init() async {
    List<SlotData> slots = [];

    String startTimeString = widget.startTime.validate();
    String endTimeString = widget.endTime.validate();
    String timeDuration = widget.slotDuration;

    DateTime temp = DateTime.now();

    startTimeString = '${temp.year}-${temp.month < 10 ? '0${temp.month}' : temp.month}-${temp.day < 10 ? '0${temp.day}' : temp.day} $startTimeString';
    endTimeString = '${temp.year}-${temp.month < 10 ? '0${temp.month}' : temp.month}-${temp.day < 10 ? '0${temp.day}' : temp.day} $endTimeString';

    DateTime startTime = DateTime.parse(startTimeString);
    DateTime endTime = DateTime.parse(endTimeString);

    Duration duration = Duration(hours: int.parse(timeDuration.split(':')[0]), minutes: int.parse(timeDuration.split(':')[1]));

    while (startTime.isBefore(endTime)) {
      SlotData slotData = SlotData();
      slotData.startTime = formatDate(startTime.toString(), format: DateFormatConst.HOUR_24_FORMAT);
      slotData.previousTimeSlot = startTime;

      // Determine time slot
      int hour = startTime.hour;
      String timeSlot;
      if (hour >= 20 && hour < 24) {
        timeSlot = "Night";
      } else if (hour >= 6 && hour < 12) {
        timeSlot = "Morning";
      } else if (hour >= 12 && hour < 17) {
        timeSlot = "Afternoon";
      } else {
        timeSlot = "Evening";
      }
      slotData.sessionText = timeSlot;

      slots.add(slotData);
      startTime = startTime.add(duration);
    }

    return slots;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snap) {
        if (snap.hasData) {
          List<SlotData> slots = snap.data as List<SlotData>;

          Map<String, List<SlotData>> categorizedSlots = {};

          for (SlotData slot in slots) {
            if (!categorizedSlots.containsKey(slot.sessionText)) {
              categorizedSlots[slot.sessionText.validate()] = [];
            }

            categorizedSlots[slot.sessionText]!.add(slot);
          }

          return Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            margin: EdgeInsets.only(bottom: 50),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categorizedSlots.entries.map((entry) {
                String sessionText = entry.key;
                List<SlotData> sessionSlots = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sessionText, style: boldTextStyle()),
                    10.height,
                    AnimatedWrap(
                      spacing: 16,
                      runSpacing: 16,
                      itemCount: sessionSlots.length,
                      listAnimationType: ListAnimationType.None,
                      itemBuilder: (context, index) {
                        SlotData timeSlot = sessionSlots[index];
                        bool isSelected = selectedIndex == index && selectedSession == timeSlot.sessionText;

                        return SlotItemComponent(
                          timeSlot: timeSlot,
                          isSelected: isSelected,
                          selectedHorizontalDate: widget.selectedHorizontalDate,
                          onTap: () {
                            /// check if time slot is available or not
                            if (timeSlot.slotAvailability(widget.selectedHorizontalDate)) {
                              if (isSelected) {
                                selectedIndex = -1;
                                bookingRequestStore.setTimeInRequest('');
                              } else {
                                bookingRequestStore.setTimeInRequest(timeSlot.startTime.validate());

                                selectedIndex = index;
                                selectedSession = timeSlot.sessionText.validate();

                                if (widget.isFromQuickBooking) {
                                  finish(context, bookingRequestStore.time);
                                }

                              }
                            } else {
                              toast(locale.youCannotBookPrevious);
                            }

                            setState(() {});
                          },
                        );
                      },
                    ),
                    20.height,
                  ],
                );
              }).toList(),
            ),
          );
        } else {
          return snapWidgetHelper(snap, loadingWidget: Offstage());
        }
      },
    );
  }
}
