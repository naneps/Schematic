import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  final String? locale;
  final DateFormat _dateFormat;

  DateFormatter({this.locale, String? format})
      : _dateFormat = DateFormat(format ?? 'dd MMMM yyyy', locale);

  String dateFromNow(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final diff = DateTime.now().difference(dateTime);
    return _formatTimeDifference(
      diff,
      'yang lalu',
    );
  }

  String dateFuture(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final diff = dateTime.difference(DateTime.now());
    return _formatTimeDifference(diff, 'lagi');
  }

  //   MAKE FORMATE LIKE SATURDAY 25 MAY
  String dayMonthYear(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final format = DateFormat('EEEE, dd MMMM yyyy', locale);
    return format.format(dateTime);
  }

  String ddMMMMyyyy(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    return _dateFormat.format(dateTime);
  }

  String ddMMyyyy(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    return _dateFormat.format(dateTime);
  }

  String ddMMyyyyHHmm(String date) {
    initialize();
    final format = DateFormat('dd MMMM yyyy HH:mm', locale);
    final dateTime = DateTime.parse(date);
    return format.format(dateTime);
  }

  String ddMMyyyyHHmmss(String date) {
    initialize();
    final format = DateFormat('dd MMMM yyyy HH:mm:ss', locale);
    final dateTime = DateTime.parse(date);
    return format.format(dateTime);
  }

  void initialize() {
    initializeDateFormatting(locale ?? 'en');
  }

  String monthFromNumber(
    int month, {
    bool isShort = false,
  }) {
    initialize();
    final format = DateFormat(isShort ? 'MMM' : 'MMMM', locale);
    final dateTime = DateTime(2000, month);
    return format.format(dateTime);
  }

  String timeFromNow(String time) {
    initialize();
    final format = DateFormat('HH:mm', locale);
    final dateTime = DateTime.parse(time);
    return format.format(dateTime);
  }

  String _formatTimeDifference(Duration difference, String label) {
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit $label';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam $label';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari $label';
    } else {
      return _dateFormat.format(DateTime.now().subtract(difference));
    }
  }
}
