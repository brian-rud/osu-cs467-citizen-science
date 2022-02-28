import 'variables.dart';
import 'project_obj.dart';

class ProjectBundle {
  ProjectObj projectObj;
  IndependentVar independentVar;
  DependentVar dependentVar;

  ProjectBundle(this.projectObj, this.independentVar, this.dependentVar);

  // GET methods

  ProjectObj get getProjectObj {
    return projectObj;
  }

  IndependentVar get getIndependentVar {
    return independentVar;
  }

  DependentVar get getDependentVar {
    return dependentVar;
  }
}
