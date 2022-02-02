// object to be used to store observations and the device id associated with that

class UserSpecificObservationsObj {
  String? userID;
  int? projectID;
  late List<Observation> observationsArray;

  UserSpecificObservationsObj(
      this.userID, this.projectID, this.observationsArray);

  String get getUserID {
    return '$userID';
  }

  int? get getProjectID {
    return projectID;
  }

  List<Observation> get getObservationsArray {
    return observationsArray;
  }
}

// observations object

class Observation {
  String? observationName;

  Observation(this.observationName);

  String get getObservationName {
    return '$observationName';
  }
}
