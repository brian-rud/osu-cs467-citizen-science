// class object to variable items
// also futher data and methods

// Independent Variable

class IndependentVar {
  int? id;
  String? name;
  String? type;
  String? units;
  Map? accepted;

  IndependentVar(
    this.id,
    this.name,
    this.type,
    this.units,
    this.accepted,
  );

  static Future<IndependentVar> getInstance(jsonData) async {
    var tempData = (await jsonData);
    return IndependentVar.fromJson(tempData);
  }

  IndependentVar.fromJson(Map<String, dynamic> json)
      : id = json['iv_info_id'],
        name = json['iv_name'],
        type = json['iv_type'],
        units = json['iv_units'],
        accepted = json['iv_accepted'];

  // GET methods

  int? get getIVID {
    return id;
  }

  String? get getIVName {
    return '$name';
  }

  String? get getIVType {
    return '$type';
  }

  String? get getIVUnits {
    return '$units';
  }

  Map? get getIVAccepted {
    return accepted;
  }

  List<String> get getIVList {
    List<String> tempList = [];
    if (accepted!["values"] != null) {
      for (int h = 0; h < accepted!["values"].length; h++) {
        tempList.add(accepted!["values"][h].toString());
      }
    }
    return tempList;
  }
}

// Dependent Variable

class DependentVar {
  int? id;
  String? name;
  String? type;
  String? units;
  Map? accepted;

  static Future<DependentVar> getInstance(jsonData) async {
    var tempData = (await jsonData);
    return DependentVar.fromJson(tempData);
  }

  DependentVar.fromJson(Map<String, dynamic> json)
      : id = json['dv_info_id'],
        name = json['dv_name'],
        type = json['dv_type'],
        units = json['dv_units'],
        accepted = json['dv_accepted'];

  // GET methods

  int? get getDVID {
    return id;
  }

  String? get getDVName {
    return '$name';
  }

  String? get getDVType {
    return '$type';
  }

  String? get getDVUnits {
    return '$units';
  }

  Map? get getDVAccepted {
    return accepted;
  }

  List<String> get getDVList {
    List<String> tempList = [];
    if (accepted!["values"] != null) {
      for (int h = 0; h < accepted!["values"].length; h++) {
        tempList.add(accepted!["values"][h].toString());
      }
    }
    return tempList;
  }
}
