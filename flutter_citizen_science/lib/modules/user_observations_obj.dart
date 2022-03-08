// object to be used to store observations and the device id associated with that

class UserSpecificObservationsObj {
  String? userID;
  int? projectID;

  UserSpecificObservationsObj(this.userID, this.projectID);

  String get getUserID {
    return '$userID';
  }

  int? get getProjectID {
    return projectID;
  }
}
