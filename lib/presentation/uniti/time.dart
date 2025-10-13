import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}

String formatDateTimeFromDataTime(DateTime now){
return DateFormat('dd-MM-yyyy').format(now);
}
DateTime formatStringToDataTime(String dateString) {
  try {
    DateFormat format = DateFormat("dd-MM-yyyy");
    return format.parse(dateString);
  } catch (e) {
    print("خطأ في تحليل التاريخ: $e");
    return DateTime(2000, 1, 1); // قيمة افتراضية لتجنب الكراش
  }
}
