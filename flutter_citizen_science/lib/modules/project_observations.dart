import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_obj.dart';

// observations page

class ObservationsScreen extends StatelessWidget {
  const ObservationsScreen(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final String _title = 'Citizen Science App';

  final ProjectObj _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_title)),
        backgroundColor: Colors.black,
      ),
      body: ObservationView(_currentProject, _currentUser),
      backgroundColor: Colors.lightGreenAccent,
    );
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

  void _createObservationWidgets() {
    for (int i = 0; i < widget._currentUser.getObservationsArray.length; i++) {
      observationWidgets.add(Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget
                  ._currentUser.getObservationsArray[i].getObservationName))));
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
      child: ListView(
        children: observationWidgets,
      ),
    );
  }
}
