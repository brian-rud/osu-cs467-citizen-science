import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_bundle.dart';

class CreateObservationScreen extends StatefulWidget {
  const CreateObservationScreen(this._currentProject, this._currentUser,
      {Key? key, required this.isEditing, required this.editObsID})
      : super(key: key);

  final ProjectBundle _currentProject;

  final UserSpecificObservationsObj _currentUser;

  final _title = 'Citizen Science App';

  final bool isEditing;

  final int editObsID;

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
          title: Text(
              widget.isEditing ? "Edit Observation" : "Create Observation"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to Observations Screen',
            onPressed: () {
              Navigator.pop(context);
              /*
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ObservationsScreen(
                      widget._currentProject, widget._currentUser);
                }));
              });
              */
            },
          ),
        ),
        backgroundColor: Colors.lightGreenAccent,
        body: ObservationFormBody(
          currentProject: widget._currentProject,
          currentUser: widget._currentUser,
          isEditing: widget.isEditing,
          editObsID: widget.editObsID,
        ));
  }
}

class ObservationFormBody extends StatefulWidget {
  const ObservationFormBody(
      {Key? key,
      required this.currentProject,
      required this.currentUser,
      required this.isEditing,
      required this.editObsID})
      : super(key: key);

  final ProjectBundle currentProject;

  final UserSpecificObservationsObj currentUser;

  final bool isEditing;

  final int editObsID;

  @override
  _ObservationFormBodyState createState() => _ObservationFormBodyState();
}

class _ObservationFormBodyState extends State<ObservationFormBody> {
  final _formKey = GlobalKey<FormState>();

  String ivDropdownValue = 'Loading...';
  String dvDropdownValue = 'Loading...';
  double ivSliderValue = 0;
  double dvSliderValue = 0;
  final TextEditingController ivTextController = TextEditingController();
  final TextEditingController dvTextController = TextEditingController();

  bool submissionToggle = false;

  String ivVal = '';
  String dvVal = '';

  final ButtonStyle submitButtonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18.0));

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

  List<double> sliderFormatter(int max, int min, int intVal) {
    // List[0] = double max, List[1] = double min, List[2] = double interval
    //(complete double to int inline)
    List<double> sliderFormatted = [];
    // check if divisible
    if (intVal != 0 && intVal != 1) {
      int newMax = max;
      while ((newMax - min) % intVal != 0) {
        newMax = newMax + 1;
      }
      sliderFormatted.add(newMax.toDouble());
    } else {
      sliderFormatted.add(max.toDouble());
    }
    sliderFormatted.add(min.toDouble());
    if (intVal == 0 || intVal == 1) {
      sliderFormatted.add(sliderFormatted[0] - sliderFormatted[1]);
    } else {
      sliderFormatted.add((sliderFormatted[0] - sliderFormatted[1]) / intVal);
    }
    return sliderFormatted;
  }

  String labelSliderFormatter(double value, int max, double newMax) {
    if (value == newMax) {
      double convertedmax = max.toDouble();
      return convertedmax.toString();
    } else {
      return value.toString();
    }
  }

  double valueSliderFormatter(double value, int max, double newMax) {
    if (value == newMax) {
      return max.toDouble();
    } else {
      return value;
    }
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
      var url =
          'https://cs467-citizen-science-for-kids.herokuapp.com/field_app/' +
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ADD ANOTHER'),
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

  Future<void> _editObservation(ivVal, dvVal, int obsID) async {
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
      var url =
          'https://cs467-citizen-science-for-kids.herokuapp.com/field_app/' +
              obsID.toString();
      Map<String, dynamic> encodingBody = {
        "obs_vals": {"iv_val": ivBodyObj, "dv_val": dvBodyObj},
      };
      await http.put(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode(encodingBody));
      submissionMessage = 'Observation Edited';
    } catch (err) {
      submissionMessage = 'Could not submit edit';
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(submissionMessage),
        actions: <Widget>[
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
    // add prompt
    columnList.add(Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Center(
          child: Text(
            widget.currentProject.getProjectObj.getProjectPrompt,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22.0,
                color: Colors.blue),
          ),
        ),
      ),
    ));
    // method configures form for observation submission
    if (iv.getIVType == null) {
      columnList.add(const Text('No IV'));
    }
    if (dv.getDVType == null) {
      columnList.add(const Text('No DV'));
    }
    // configure IV
    columnList.add(Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getIndependentVar.getIVName ?? "IV",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                color: Colors.blue),
          )),
    ));
    if (iv.getIVType == "string") {
      // REPLACE WITH VALUES AFTER
      if (iv.getIVList.isNotEmpty) {
        // create dropdown
        columnList.add(SelectionDropdown(
          stringList: iv.getIVList,
          val: changeIVValue,
        ));
      } else {
        // create text input
        columnList.add(
          TextFormField(
            controller: ivTextController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an observation';
              }
              changeIVValue(ivTextController.text);
              return null;
            },
          ),
        );
      }
      columnList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.currentProject.getIndependentVar.getIVUnits.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
        ),
      ));
    } else if (iv.getIVType == "number") {
      if (iv.getIVList.isNotEmpty) {
        // create dropdown
        columnList.add(SelectionDropdown(
          stringList: iv.getIVList,
          val: changeIVValue,
        ));
        columnList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getIndependentVar.getIVUnits.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
          ),
        ));
      } else if (iv.accepted!["interval_size"] != null ||
          iv.accepted!["min"] != null ||
          iv.accepted!["max"] != null) {
        // create slider
        List<double> ivSliderList = sliderFormatter(iv.accepted!["max"],
            iv.accepted!["min"], iv.accepted!["interval_size"]);
        columnList.add(Slider(
          value: ivSliderValue,
          min: ivSliderList[1],
          max: ivSliderList[0],
          divisions: ivSliderList[2].toInt(),
          label: labelSliderFormatter(
                  ivSliderValue, iv.accepted!["max"], ivSliderList[0]) +
              ' ' +
              widget.currentProject.getIndependentVar.getIVUnits.toString(),
          onChanged: (double value) {
            setState(() {
              ivSliderValue = valueSliderFormatter(
                  value, iv.accepted!["max"], ivSliderList[0]);
              changeIVValue(ivSliderValue.toString());
            });
          },
        ));
      } else {
        // create number input without validation
        columnList.add(
          TextFormField(
            controller: ivTextController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              if (isNumeric(value) == false) {
                return 'Please enter a valid number';
              }
              changeIVValue(ivTextController.text);
              return null;
            },
          ),
        );
        columnList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getIndependentVar.getIVUnits.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
          ),
        ));
      }
    }
    columnList.add(const Padding(padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0)));
    columnList.add(Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getDependentVar.getDVName ?? "DV",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                color: Colors.blue),
          )),
    ));
    // configure DV
    if (dv.getDVType == "string") {
      // REPLACE WITH VALUES AFTER
      if (dv.getDVList.isNotEmpty) {
        // create dropdown
        columnList.add(SelectionDropdown(
          stringList: dv.getDVList,
          val: changeDVValue,
        ));
      } else {
        // create text input
        columnList.add(
          TextFormField(
            controller: dvTextController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an observation';
              }
              changeDVValue(dvTextController.text);
              return null;
            },
          ),
        );
      }
      columnList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.currentProject.getDependentVar.getDVUnits.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
        ),
      ));
    } else if (dv.getDVType == "number") {
      if (dv.getDVList.isNotEmpty) {
        // create dropdown
        columnList.add(SelectionDropdown(
          stringList: dv.getDVList,
          val: changeDVValue,
        ));
        columnList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getDependentVar.getDVUnits.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
          ),
        ));
      } else if (dv.accepted!["interval_size"] != null ||
          dv.accepted!["min"] != null ||
          dv.accepted!["max"] != null) {
        // create slider
        List<double> dvSliderList = sliderFormatter(dv.accepted!["max"],
            dv.accepted!["min"], dv.accepted!["interval_size"]);
        columnList.add(Slider(
          value: dvSliderValue,
          min: dvSliderList[1],
          max: dvSliderList[0],
          divisions: dvSliderList[2].toInt(),
          label: labelSliderFormatter(
                  dvSliderValue, dv.accepted!["max"], dvSliderList[0]) +
              ' ' +
              widget.currentProject.dependentVar.getDVUnits.toString(),
          onChanged: (double value) {
            setState(() {
              dvSliderValue = valueSliderFormatter(
                  value, dv.accepted!["max"], dvSliderList[0]);
              changeDVValue(dvSliderValue.toString());
            });
          },
        ));
      } else {
        // create number input without validation
        columnList.add(
          TextFormField(
            controller: dvTextController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              if (isNumeric(value) == false) {
                return 'Please enter a valid number';
              }
              changeDVValue(dvTextController.text);
              return null;
            },
          ),
        );
        columnList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.currentProject.getDependentVar.getDVUnits.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 14.0),
          ),
        ));
      }
    }
    columnList.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: submitButtonStyle,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (widget.isEditing) {
              _editObservation(ivVal, dvVal, widget.editObsID);
            } else {
              _submitObservation(ivVal, dvVal);
            }
          }
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
            : widget.isEditing
                ? const Text(
                    'Edit',
                  )
                : const Text('Submit'),
      ),
    ));
    return Form(
        key: formKey,
        child: ListView(
          children: columnList,
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
    if (widget.currentProject.getIndependentVar.accepted!["min"] != null) {
      ivSliderValue =
          widget.currentProject.getIndependentVar.accepted!["min"].toDouble();
    }
    if (widget.currentProject.getDependentVar.accepted!["min"] != null) {
      dvSliderValue =
          widget.currentProject.getDependentVar.accepted!["min"].toDouble();
    }
  }

  @override
  void dispose() {
    ivTextController.dispose();
    dvTextController.dispose();
    super.dispose();
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
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      alignment: Alignment.center,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      style: const TextStyle(
        fontSize: 20.0,
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
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}
