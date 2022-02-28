import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_citizen_science/modules/project_observations.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_bundle.dart';

class CreateObservationScreen extends StatefulWidget {
  const CreateObservationScreen(this._currentProject, this._currentUser,
      {Key? key})
      : super(key: key);

  final ProjectBundle _currentProject;

  final UserSpecificObservationsObj _currentUser;

  final _title = 'Citizen Science App';

  @override
  _CreateObservationScreenState createState() =>
      _CreateObservationScreenState();
}

class _CreateObservationScreenState extends State<CreateObservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget._title),
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
        body: ObservationFormBody(
          currentProject: widget._currentProject,
          currentUser: widget._currentUser,
        ));
  }
}

class ObservationFormBody extends StatefulWidget {
  const ObservationFormBody(
      {Key? key, required this.currentProject, required this.currentUser})
      : super(key: key);

  final ProjectBundle currentProject;

  final UserSpecificObservationsObj currentUser;

  @override
  _ObservationFormBodyState createState() => _ObservationFormBodyState();
}

class _ObservationFormBodyState extends State<ObservationFormBody> {
  final _formKey = GlobalKey<FormState>();

  double sliderValue = 0;

  String ivDropdownValue = 'Loading...';
  String dvDropdownValue = 'Loading...';

  bool submissionToggle = false;

  String ivVal = '';
  String dvVal = '';

  void changeIVValue(String value) {
    ivVal = value;
  }

  void changeDVValue(String value) {
    dvVal = value;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> _submitObservation(ivVal, dvVal) async {
    String submissionMessage = 'Default Response';
    var ivBodyObj;
    var dvBodyObj;
    if (isNumeric(ivVal)) {
      ivBodyObj = double.parse(ivVal);
    } else {
      ivBodyObj = ivVal as String;
    }
    if (isNumeric(dvVal)) {
      dvBodyObj = double.parse(dvVal);
    } else {
      dvBodyObj = dvVal as String;
    }
    try {
      var url = 'https://cs467-citizen-science.herokuapp.com/field_app/' +
          widget.currentProject.getProjectObj.getProjectCode +
          '/' +
          widget.currentUser.getUserID;
      Map<String, dynamic> encodingBody = {
        "obs_vals": {"iv_val": ivBodyObj, "dv_val": dvBodyObj},
      };
      final http.Response response = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode(encodingBody));
      submissionMessage = 'Observation Submitted';
    } catch (err) {
      submissionMessage = 'Could not submit observation';
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(submissionMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add Another'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget configureForm(
      IndependentVar iv, DependentVar dv, GlobalKey<FormState> formKey) {
    // create column widget
    List<Widget> columnList = [];
    // method configures form for observation submission
    if (iv.getIVType == null) {
      columnList.add(const Text('sorry iv'));
    }
    if (dv.getDVType == null) {
      columnList.add(const Text('sorry dv'));
    }
    // configure IV
    if (iv.getIVType == "String") {
      // REPLACE WITH VALUES AFTER
      if (iv.getIVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('String Dropdown'));
        columnList.add(SelectionDropdown(
          stringList: iv.getIVList,
          val: changeIVValue,
        ));
      } else {
        // create text input
        columnList.add(const Text('String Text Input'));
      }
    } else if (iv.getIVType == "Num") {
      if (iv.getIVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('Num Dropdown'));
        columnList.add(SelectionDropdown(
          stringList: iv.getIVList,
          val: changeIVValue,
        ));
      } else {
        if (iv.accepted!.containsKey("interval_size") ||
            iv.accepted!.containsKey("min") ||
            iv.accepted!.containsKey("max")) {
          // create slider
          columnList.add(const Text('Num Slider'));
        } else {
          // create number input without validation
          columnList.add(const Text('Num input'));
        }
      }
    } else if (iv.getIVType == "Date") {
      if (iv.accepted!.containsKey("min") && iv.accepted!.containsKey("max")) {
        // date input with validation
        columnList.add(const Text('Date input with validation'));
      } else {
        // date input without validation
        columnList.add(const Text('Date input without validation'));
      }
    }
    // configure DV
    if (dv.getDVType == "String") {
      // REPLACE WITH VALUES AFTER
      if (dv.getDVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('String Dropdown'));
        columnList.add(SelectionDropdown(
          stringList: dv.getDVList,
          val: changeDVValue,
        ));
      } else {
        // create text input
        columnList.add(const Text('String Text Input'));
      }
    } else if (dv.getDVType == "Num") {
      if (dv.getDVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('Num Dropdown'));
        columnList.add(SelectionDropdown(
          stringList: dv.getDVList,
          val: changeDVValue,
        ));
      } else {
        if (dv.accepted!.containsKey("interval_size") ||
            dv.accepted!.containsKey("min") ||
            dv.accepted!.containsKey("max")) {
          // create slider
          columnList.add(const Text('Num Slider'));
        } else {
          // create number input without validation
          columnList.add(const Text('Num input'));
        }
      }
    } else if (dv.getDVType == "Date") {
      if (dv.accepted!.containsKey("min") && dv.accepted!.containsKey("max")) {
        // date input with validation
        columnList.add(const Text('Date input with validation'));
      } else {
        // date input without validation
        columnList.add(const Text('Date input without validation'));
      }
    }
    columnList.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          _submitObservation(ivVal, dvVal);
        },
        child: submissionToggle
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Loading...'),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              )
            : const Text(
                'Submit',
              ),
      ),
    ));
    return Form(
        key: formKey,
        child: Column(
          children: columnList,
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.currentProject.getIndependentVar.getIVList.isNotEmpty) {
      ivVal = widget.currentProject.getIndependentVar.getIVList[0];
    }
    if (widget.currentProject.getDependentVar.getDVList.isNotEmpty) {
      dvVal = widget.currentProject.getDependentVar.getDVList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: configureForm(widget.currentProject.getIndependentVar,
          widget.currentProject.getDependentVar, _formKey),
    );
  }
}

class SelectionDropdown extends StatefulWidget {
  const SelectionDropdown(
      {Key? key, required this.stringList, required this.val})
      : super(key: key);

  final List<String> stringList;

  final void Function(String value) val;

  @override
  _SelectionDropdownState createState() => _SelectionDropdownState();
}

class _SelectionDropdownState extends State<SelectionDropdown> {
  String dropdownValue = 'Loading...';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.stringList[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.blue,
      ),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.val(dropdownValue);
        });
      },
      items: widget.stringList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
