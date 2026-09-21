import 'package:intl/intl.dart';
import 'package:domina_app/app/logger/app_logger.dart';

final _log = AppLogger.get('TimeUtils');

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}

String formatDateTimeFromDataTime(DateTime now) {
  return DateFormat('dd-MM-yyyy').format(now);
}

DateTime formatStringToDataTime(String dateString) {
  try {
    DateFormat format = DateFormat("dd-MM-yyyy");
    return format.parse(dateString);
  } catch (e) {
    _log.warning('formatStringToDataTime failed for "$dateString"', e);
    return DateTime(2000, 1, 1); // قيمة افتراضية لتجنب الكراش
  }
}
