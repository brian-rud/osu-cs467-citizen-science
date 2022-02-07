import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/class_details.dart';
import 'package:flutter_citizen_science/modules/create_observation_screen.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_obj.dart';
import 'create_observation_screen.dart';

// observations page

class ObservationsScreen extends StatefulWidget {
  const ObservationsScreen(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final ProjectObj _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  State<ObservationsScreen> createState() => _ObservationsScreenState();
}

class _ObservationsScreenState extends State<ObservationsScreen> {
  final String _title = 'Citizen Science App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(_title)),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to Observations Screen',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ClassDetailsScreen(
                    widget._currentProject, widget._currentUser);
              }));
            },
          ),
        ),
        body: ObservationView(widget._currentProject, widget._currentUser),
        backgroundColor: Colors.lightGreenAccent,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateObservationScreen(
                        widget._currentProject, widget._currentUser),
                  ));
            }));
  }
}

class ObservationView extends StatefulWidget {
  const ObservationView(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final ProjectObj _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  _ObservationViewState createState() => _ObservationViewState();
}

class _ObservationViewState extends State<ObservationView> {
  List<Widget> observationWidgets = [];

  void _removeObservation(index) {
    // prompt will be 0; remove at index of 1 or greater
    widget._currentUser.getObservationsArray.removeAt(index);
  }

  void _createObservationWidgets() {
    observationWidgets.clear();
    observationWidgets.add(Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget._currentProject.getProjectPrompt,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          )),
    ));
    for (int i = 0; i < widget._currentUser.getObservationsArray.length; i++) {
      observationWidgets.add(Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Delete Observation',
                      ),
                      tooltip: 'Delete Observation',
                      onPressed: () {
                        setState(() {
                          _removeObservation(i);
                          _createObservationWidgets();
                        });
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(widget._currentUser.getObservationsArray[i]
                          .getObservationName)),
                ],
              ))));
    }
  }

  @override
  void initState() {
    super.initState();
    _createObservationWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: observationWidgets.length,
          itemBuilder: (context, index) {
            return observationWidgets[index];
          },
        ));
  }
}
