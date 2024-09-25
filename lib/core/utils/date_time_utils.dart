import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';
const String displayDateTimeFormatPattern = 'EEEE d MMM, yy  HH:mm';
const String onlyTimeFormatPattern = 'HH:mm aa';

extension DateTimeExtension on DateTime {
  String format({
    String pattern = dateTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

Map<String, int> monthNameToNumber = {
  'JAN': 1,
  'FEB': 2,
  'MAR': 3,
  'APR': 4,
  'MAY': 5,
  'JUN': 6,
  'JUL': 7,
  'AUG': 8,
  'SEP': 9,
  'OCT': 10,
  'NOV': 11,
  'DEC': 12,
};

int getMonthNumber(String monthName) {
  return monthNameToNumber[monthName.toUpperCase()] ?? 1;
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool isLastWeek() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    return isAfter(lastWeek) && isBefore(now);
  }

  bool isLastMonth() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1, now.day);
    return isAfter(lastMonth) && isBefore(now);
  }

  bool isLastYear() {
    final now = DateTime.now();
    final lastYear = DateTime(now.year - 1, now.month, now.day);
    return isAfter(lastYear) && isBefore(now);
  }
}
