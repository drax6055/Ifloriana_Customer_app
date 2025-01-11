import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

extension strEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color: color ?? (appStore.isDarkMode ? Colors.white : appTextSecondaryColor),
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(ic_no_photo, height: size ?? 24, width: size ?? 24);
      },
    );
  }

  String getTimeInAmPM() {
    return TimeOfDay(hour: this.split(":").first.toInt(), minute: this.split(":").last.toInt()).format(getContext);
  }

  String get getBookingStatusLabel {
    String status = '';

    if (this == BookingStatusConst.PENDING) {
      return locale.pending;
    } else if (this == BookingStatusConst.CONFIRMED) {
      return locale.confirmed;
    } else if (this == BookingStatusConst.CANCELLED) {
      return locale.cancelled;
    } else if (this == BookingStatusConst.CHECK_IN) {
      return locale.checkIn;
    } else if (this == BookingStatusConst.CHECKOUT) {
      return locale.checkOut;
    } else if (this == BookingStatusConst.COMPLETED) {
      return locale.completed;
    }

    return status;
  }

  int get getWeekDayCount {
    int day = -1;

    if (this == 'monday') {
      return 1;
    } else if (this == 'tuesday') {
      return 2;
    } else if (this == 'wednesday') {
      return 3;
    } else if (this == 'thursday') {
      return 4;
    } else if (this == 'friday') {
      return 5;
    } else if (this == 'saturday') {
      return 6;
    } else if (this == 'sunday') {
      return 7;
    }

    return day;
  }

  TimeOfDay getTimeOfDay(){
    return TimeOfDay(hour: this.split(":").first.toInt(), minute:  this.split(":")[1].toInt());
  }
}
