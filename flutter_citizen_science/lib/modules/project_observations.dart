import 'package:flutter/material.dart';
import 'projectObj.dart';

// observations page

class ObservationsScreen extends StatelessWidget {
  const ObservationsScreen(this._currentProject, {Key? key}) : super(key: key);

  final String _title = 'Citizen Science App';

  final ProjectObj _currentProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_title)),
        backgroundColor: Colors.black,
      ),
      body: Center(child: Text(_currentProject.getProjectPrompt)),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}
