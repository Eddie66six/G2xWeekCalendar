class MyDateTime {
  static String formatDate(DateTime date, {String format = "dd/MM/yyyy"}) {
    var str = format.replaceAll("dd", date.day.toString());
    str = str.replaceAll("MM", date.month.toString());
    str = str.replaceAll("yyyy", date.year.toString());
    return str;
  }

  static DateTime getFirstDateOfWeek(DateTime date) {
    return date.weekday == 7
        ? date
        : date.add(new Duration(days: -date.weekday));
  }

  static List<int> getDaysOfWeek(DateTime date) {
    var firstDay = getFirstDateOfWeek(date);
    var days = <int>[];
    for (var i = 0; i < 7; i++) {
      days.add(firstDay.add(new Duration(days: i)).day);
    }
    return days;
  }
}