import 'package:intl/intl.dart';

String formatTimeTo12Hour({required String timeString}) {
  try {
    final inputFormat = DateFormat("HH:mm:ss");
    final outputFormat = DateFormat("h:mm a");
    final dateTime = inputFormat.parse(timeString);
    return outputFormat.format(dateTime);
  } catch (e) {
    return timeString;
  }
}
