import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String setFormattedDate(String format) {
    return DateFormat(format).format(this);
  }
}
