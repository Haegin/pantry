import 'package:intl/intl.dart';

class Timer {
  String name;
  DateTime when;

  Timer(this.name, this.when);

  bool expired() {
    return DateTime.now().isAfter(when);
  }

  String deadline() {
    final formatter = DateFormat("h:m a 'on' d MMM, y");
    return formatter.format(when);
  }

  String remaining() {
    final now = DateTime.now();
    final remaining = when.difference(now);
    return "${remaining.inHours}:" +
        "${remaining.inMinutes.remainder(Duration.minutesPerHour)}: " +
        "${remaining.inSeconds.remainder(Duration.secondsPerMinute)}";
  }
}
