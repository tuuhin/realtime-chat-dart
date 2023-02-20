String _twoDigits(int n) => n.toString().padLeft(2, '0');

extension ReadableDates on DateTime {
  String get simpleFormat {
    final String timeHour = _twoDigits(hour);
    final String timeMinutes = _twoDigits(minute);
    return '$timeHour:$timeMinutes ${hour < 12 ? 'am' : 'pm'}';
  }
}
