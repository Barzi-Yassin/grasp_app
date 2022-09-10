class DateTimeOptimizer {
  String dateTimeNumberToMonthName({required int monthNumber}) {
    String result = "";
    switch (monthNumber) {
      case 1:
        result = "Jan";
        break;
      case 2:
        result = "Feb";
        break;
      case 3:
        result = "Mar";
        break;
      case 4:
        result = "Apr";
        break;
      case 5:
        result = "May";
        break;
      case 6:
        result = "Jun";
        break;
      case 7:
        result = "july";
        break;
      case 8:
        result = "Aug";
        break;
      case 9:
        result = "Sep";
        break;
      case 10:
        result = "Oct";
        break;
      case 11:
        result = "Nov";
        break;
      case 12:
        result = "Dec";
        break;
      default:
        result = 'invalid month number';
    }
    return result;
  }

  String dateTimeTwelveHourFormater(
      {required int hourNumber, required int minuteNumber}) {
    String result = "";

    if (hourNumber < 12) {
      result = "$hourNumber:$minuteNumber am";
    } else {
      result = "${hourNumber - 12}:$minuteNumber pm";
    }

    return result;
  }
}
