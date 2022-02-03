import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/project_observations.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_obj.dart';
import 'class_details.dart';

class CreateObservationScreen extends StatefulWidget {
  const CreateObservationScreen(this._currentProject, this._currentUser,
      {Key? key})
      : super(key: key);

  final ProjectObj _currentProject;

  final UserSpecificObservationsObj _currentUser;

  final _title = 'Citizen Science App';

  @override
  _CreateObservationScreenState createState() =>
      _CreateObservationScreenState();
}

class _CreateObservationScreenState extends State<CreateObservationScreen> {
  final TextEditingController _observationString = TextEditingController();

  void _addObservation(observation) {
    widget._currentUser.getObservationsArray.add(Observation(
        widget._currentUser.getObservationsArray.length, observation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget._title)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Observations Screen',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ObservationsScreen(
                  widget._currentProject, widget._currentUser);
            }));
          },
        ),
      ),
      backgroundColor: Colors.lightGreenAccent,
      body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text('Add observation here to ' +
                  widget._currentProject.getProjectTitle +
                  ' for ' +
                  widget._currentUser.getUserID),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _observationString,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    // errorText: 'Invalid Code',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
                    labelText: 'Input String Observation',
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Submit',
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      _addObservation(_observationString.text);
                      return ObservationsScreen(
                          widget._currentProject, widget._currentUser);
                    }));
                  },
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
