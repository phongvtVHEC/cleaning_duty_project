extension WeekDay on int {
  String get week {
    switch (this) {
      case 0:
        return "SU";

      case 1:
        return "MO";

      case 2:
        return "TU";

      case 3:
        return "WE";

      case 4:
        return "TH";

      case 5:
        return "FR";

      case 6:
        return "SA";

      default:
        throw "INVALID WEEK";
    }
  }
}

extension Month on int {
  String get month {
    switch (this) {
      case 1:
        return "JAN";

      case 2:
        return "FEB";

      case 3:
        return "MAR";

      case 4:
        return "APR";

      case 5:
        return "MAY";

      case 6:
        return "JUN";

      case 7:
        return "JUL";

      case 8:
        return "AUG";

      case 9:
        return "SEP";

      case 10:
        return "OCT";

      case 11:
        return "NOV";

      case 12:
        return "DEC";

      default:
        throw "INVALID MONTH";
    }
  }
}
