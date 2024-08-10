import 'package:intl/intl.dart';

int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  final readTime = wordCount / 225;
  return readTime.ceil();
}

String convertDateFormat(String inputDate) {
  final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  final dateTime =
      dateFormat.parse(inputDate.substring(0, 19)); // Get the date part only

  final outputFormat = DateFormat("d MMM, yyyy");
  return outputFormat.format(dateTime);
}
