extension IntExt on int {
  String get getWeekDayName {
    String day = '';

    if (this == 1) {
      return 'monday';
    } else if (this == 2) {
      return 'tuesday';
    } else if (this == 3) {
      return 'wednesday';
    } else if (this == 4) {
      return 'thursday';
    } else if (this == 5) {
      return 'friday';
    } else if (this == 6) {
      return 'saturday';
    } else if (this == 7) {
      return 'sunday';
    }

    return day;
  }
}