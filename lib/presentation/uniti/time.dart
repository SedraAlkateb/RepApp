import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}

String formatDateTimeFromDataTime(DateTime now){
return DateFormat('dd/MM/yyyy').format(now);
}
DateTime formatStringToDataTime(String dateString){
  DateFormat format = DateFormat("dd-MM-yyyy");
  DateTime dateTime = format.parse(dateString);
  return dateTime;
}