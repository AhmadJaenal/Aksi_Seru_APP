import 'package:intl/intl.dart';

class DateController {
  String getDateNow() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
  }

  String checkDifferenceTime({String? date}) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
    DateTime parsedDate = dateFormat.parse(date!);

    DateTime now = DateTime.now();
    Duration difference = now.difference(parsedDate);

    int differenceInDays = difference.inDays;
    int differenceInWeak = (difference.inDays / 7).floor();

    int differenceInHours = difference.inHours;
    int differenceInMinute = difference.inMinutes;
    int differenceInSecond = difference.inSeconds;

    if (differenceInSecond <= 60) {
      return "$differenceInSecond detik yang lalu";
    } else if (differenceInMinute <= 60) {
      return "$differenceInMinute menit yang lalu";
    } else if (differenceInHours <= 24) {
      return "$differenceInHours jam yang lalu";
    } else if (differenceInDays <= 7) {
      return "$differenceInDays hari yang lalu";
    } else {
      return "$differenceInWeak minggu yang lalu";
    }
  }
}
