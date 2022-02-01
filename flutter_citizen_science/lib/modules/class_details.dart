import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/class_input_screen.dart';
import 'class_input_screen.dart';
import 'projectObj.dart';
// class details page

class ClassDetailsScreen extends StatelessWidget {
  const ClassDetailsScreen(this.currentProject, {Key? key}) : super(key: key);

  final String _title = 'Citizen Science App';

  final ProjectObj currentProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_title)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(currentProject.getProjectTitle),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}
