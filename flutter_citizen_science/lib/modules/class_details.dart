import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/class_input_screen.dart';
import 'package:flutter_citizen_science/modules/project_observations.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_observations.dart';
import 'project_obj.dart';
import 'project_bundle.dart';
// class details page

class ClassDetailsScreen extends StatelessWidget {
  const ClassDetailsScreen(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final String _title = 'Citizen Science App';

  final ProjectBundle _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Observations Screen',
          onPressed: () {
            Navigator.pop(context);
            /*
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CodeInputScreen();
            }));
            */
          },
        ),
      ),
      body: ClassDetailsBody(_currentProject, _currentUser),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class ClassDetailsBody extends StatelessWidget {
  const ClassDetailsBody(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final ProjectBundle _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _currentProject.getProjectObj.getProjectTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Project Code: ' +
                        _currentProject.getProjectObj.projectCode.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                )),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _currentProject.getProjectObj.getProjectDesc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text(
                  'Get Started!',
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ObservationsScreen(_currentProject, _currentUser);
                  }));
                },
                style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
