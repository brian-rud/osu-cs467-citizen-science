import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/project_observations.dart';
import 'project_observations.dart';
import 'projectObj.dart';
// class details page

class ClassDetailsScreen extends StatelessWidget {
  const ClassDetailsScreen(this._currentProject, {Key? key}) : super(key: key);

  final String _title = 'Citizen Science App';

  final ProjectObj _currentProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_title)),
        backgroundColor: Colors.black,
      ),
      body: ClassDetailsBody(_currentProject),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class ClassDetailsBody extends StatelessWidget {
  const ClassDetailsBody(this._currentProject, {Key? key}) : super(key: key);

  final ProjectObj _currentProject;

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
                    _currentProject.getProjectTitle,
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
                    'Project ID: ' + _currentProject.projectID.toString(),
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
                _currentProject.getProjectDesc,
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
                    return ObservationsScreen(_currentProject);
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
