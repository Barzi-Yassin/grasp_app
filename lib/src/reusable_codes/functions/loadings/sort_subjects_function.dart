class SortSubjectsFunctions {
  String sortSubjectsByFieldName({required int theSortingSubjectNumber}) {
    String result;
    switch (theSortingSubjectNumber % 3) {
      case 1:
        result = "subjectName";
        break;
      case 2:
        result = "subjectItemsNumber";
        break;
      default: // the only possible number is 0
        result = "subjectCreatedAt";
    }
    return result;
  }
}
