class CustomeStringFunctions {
  String customeSubString({
    required String theString,
    required int theResultLengthLimit,
  }) {
    String abbreviated;

    if (theString.length < (theResultLengthLimit+1)) {
      abbreviated = theString;
    } else {
      abbreviated = '${theString.substring(0, (theResultLengthLimit))}...';
    }

    return abbreviated;
  }
}
