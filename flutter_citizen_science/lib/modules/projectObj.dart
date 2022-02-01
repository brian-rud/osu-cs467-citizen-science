// class object to store class name and description
// also futher data and methods

class ProjectObj {
  int? projectID;
  int? teacherID;
  int? projectCode;
  String? projectTitle;
  String? projectDesc;
  String? projectPrompt;
  String? projectCategory;
  DateTime? projectEndDate;

  ProjectObj(
      this.projectID,
      this.teacherID,
      this.projectCode,
      this.projectTitle,
      this.projectDesc,
      this.projectPrompt,
      this.projectCategory,
      this.projectEndDate);

  ProjectObj.fromJson(Map<String, dynamic> json)
      : projectID = json['project_id'],
        teacherID = json['teacher_id'],
        projectCode = json['project_code'],
        projectTitle = json['title'],
        projectDesc = json['description'],
        projectPrompt = json['prompt'],
        projectCategory = json['category'],
        projectEndDate = json['end_date'];

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

  int? get getTeacherID {
    return teacherID;
  }

  int? get getProjectCode {
    return projectCode;
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
}
