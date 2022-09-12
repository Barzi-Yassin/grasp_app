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
    String result;
    String generatePairHourNumber;
    String generatePairMinuteNumber = minuteNumber.toString();

    if (minuteNumber < 10) {
      generatePairMinuteNumber = "0$minuteNumber";
    }

    if (hourNumber < 12) {
      generatePairHourNumber = hourNumber.toString().length == 1
          ? "0$hourNumber"
          : hourNumber.toString();
      result = "$generatePairHourNumber:$generatePairMinuteNumber am";
    } else if (hourNumber == 12) {
      result = "12:$generatePairMinuteNumber pm";
    } else {
      generatePairHourNumber = "${hourNumber - 12}".length == 1
          ? "0${hourNumber - 12}"
          : (hourNumber - 12).toString();
      result = "$generatePairHourNumber:$generatePairMinuteNumber pm";
    }

    return result;
  }
}
