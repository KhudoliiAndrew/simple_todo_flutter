import 'package:easy_localization/easy_localization.dart';

class Time {

  static String getTimeFromMilliseconds(int milliseconds) {
    return DateFormat('kk:mm').format(
        DateTime.fromMillisecondsSinceEpoch(
            milliseconds));
  }

  static String getDateFromMilliseconds(int milliseconds) {
    return DateFormat('dd.MM.yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(
            milliseconds));
  }

  static String getStringFromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(
            milliseconds).toString();
  }

}

class DatesLocalized {
  static List<String> days = [
    "weekday.monday".tr(),
    "weekday.tuesday".tr(),
    "weekday.wednesday".tr(),
    "weekday.thursday".tr(),
    "weekday.friday".tr(),
    "weekday.saturday".tr(),
    "weekday.sunday".tr()
  ];

  static List<String> daysShort = [
    "weekday.monday".tr()[0],
    "weekday.tuesday".tr()[0],
    "weekday.wednesday".tr()[0],
    "weekday.thursday".tr()[0],
    "weekday.friday".tr()[0],
    "weekday.saturday".tr()[0],
    "weekday.sunday".tr()[0]
  ];

  static List<String> months = [
    "month.january".tr(),
    "month.february".tr(),
    "month.march".tr(),
    "month.april".tr(),
    "month.may".tr(),
    "month.june".tr(),
    "month.july".tr(),
    "month.august".tr(),
    "month.september".tr(),
    "month.october".tr(),
    "month.november".tr(),
    "month.december".tr()
  ];
}

extension DateOnly on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }

  DateTime onlyDate() {
    return DateTime(this.year, this.month, this.day);
  }
}

extension DateOnlyInt on int {
  DateTime onlyDate() {
    var date = this.toDate();
    return DateTime(date.year, date.month, date.day);
  }

  int onlyDateInMilli() {
    var date = this.toDate();
    return DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
  }
}

extension Date on int {

  String getDayTitle() => DatesLocalized.days[this - 1];
  String getMonthTitle() => DatesLocalized.months[this - 1];

  String timeToString() {
    return DateTime.fromMillisecondsSinceEpoch(
        this).toString();
  }

  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(
        this);
  }
}