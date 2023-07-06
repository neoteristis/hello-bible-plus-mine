import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(this);
    return isAtSameMomentAs | isAfter(dateTime);
  }

  String? get formatToCasualStringDate {
    return DateFormat('EEEE, MMM d, yyyy').format(this);
  }

  DateTime? get takeOnlyDate {
    return DateTime(
      year,
      month,
      day,
    );
  }

  bool get isAtSameDateAsNow {
    return formatToCasualStringDate == DateTime.now().formatToCasualStringDate;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(this);
    return isAtSameMomentAs | isBefore(dateTime);
  }

  bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final isAfter = isAfterOrEqualTo(fromDateTime) ?? false;
    final isBefore = isBeforeOrEqualTo(toDateTime) ?? false;
    return isAfter && isBefore;
  }

  String get delayPassed {
    final currentTime = DateTime.now();
    final String delay;

    final diffDy = currentTime.difference(this).inDays;
    final diffHr = currentTime.difference(this).inHours;
    final diffMn = currentTime.difference(this).inMinutes;
    final diffSc = currentTime.difference(this).inSeconds;

    if (diffSc < 60) {
      delay = 'A l\'instant';
    } else if (diffMn < 60) {
      delay = '$diffMn mn';
    } else if (diffHr < 24) {
      delay = '$diffHr h';
    } else if (diffDy < 30) {
      delay = '$diffDy j';
    } else {
      delay = '';
    }
    return delay;
  }
}
