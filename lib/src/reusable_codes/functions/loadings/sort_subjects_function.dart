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

  String getSortName({required String theSortedSubjectsFieldName}) {
    String result = "Newest";
    if (theSortedSubjectsFieldName == "subjectItemsNumber") {
      result = "Items";
    }
    if (theSortedSubjectsFieldName == "subjectName") {
      result = "Name";
    }

    return result;
  }

  String getSortAscOrDesc({required bool isSortDescending}) {
    String result = isSortDescending ? "Descending" : "Ascending";
    return result;
  }

  
}
