import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}

String formatDateTimeFromDataTime(DateTime now){

return DateFormat('dd/MM/yyyy').format(now);

}
DateTime formatStringToDataTime(){
  String dateString = "21-12-2023 10:00 AM";
  DateFormat format = DateFormat("dd-MM-yyyy hh:mm a");
  DateTime dateTime = format.parse(dateString);
  return dateTime;
}