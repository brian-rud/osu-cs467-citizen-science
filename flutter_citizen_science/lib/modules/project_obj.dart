// class object to store class name and description
// also futher data and methods

class ProjectObj {
  int? projectID;
  String? teacherID;
  String? projectCode;
  String? projectTitle;
  String? projectDesc;
  String? projectPrompt;
  String? projectCategory;
  DateTime? projectEndDate;
  int? projectDvInfoID;
  int? projectIvInfoID;

  ProjectObj(
      this.projectID,
      this.teacherID,
      this.projectCode,
      this.projectTitle,
      this.projectDesc,
      this.projectPrompt,
      this.projectCategory,
      this.projectEndDate,
      this.projectDvInfoID,
      this.projectIvInfoID);

  static Future<ProjectObj> getInstance(jsonData) async {
    var tempData = (await jsonData);
    return ProjectObj.fromJson(tempData);
  }

  ProjectObj.fromJson(Map<String, dynamic> json)
      : projectID = json['project_id'],
        teacherID = json['teacher_id'],
        projectCode = json['project_code'],
        projectTitle = json['title'],
        projectDesc = json['description'],
        projectPrompt = json['prompt'],
        projectCategory = json['category'],
        projectEndDate = DateTime.parse(json['end_date']),
        projectDvInfoID = json['dv_info_id'],
        projectIvInfoID = json['iv_info_id'];

  // GET methods
  String get getProjectTitle {
    return '$projectTitle';
  }

  String get getProjectDesc {
    return '$projectDesc';
  }

  int? get getProjectID {
    return projectID;
  }

  String? get getTeacherID {
    return '$teacherID';
  }

  String get getProjectCode {
    return '$projectCode';
  }

  String get getProjectPrompt {
    return '$projectPrompt';
  }

  String get getProjectCategory {
    return '$projectCategory';
  }

  DateTime? get getEndDate {
    return projectEndDate;
  }

  int? get getProjectIvInfoID {
    return projectIvInfoID;
  }

  int? get getProjectDvInfoID {
    return projectDvInfoID;
  }
}
