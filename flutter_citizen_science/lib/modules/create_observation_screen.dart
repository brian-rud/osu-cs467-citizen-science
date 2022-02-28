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
    /*
      Container(
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
                  widget._currentProject.getProjectObj.getProjectTitle +
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
    */
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

  String dropdownValue = 'Loading...';

  bool submissionToggle = false;

  Future<void> _submitObservation() async {
    bool wasResponse = false;
    try {
      var url = 'https://cs467-citizen-science.herokuapp.com/field_app/' +
          widget.currentProject.getProjectObj.getProjectCode +
          '/' +
          widget.currentUser.getUserID;
      Map<String, dynamic> encodingBody = {
        "obs_vals": {"iv_val": "Brown", "dv_val": 4},
      };
      final http.Response response = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode(encodingBody));
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        wasResponse = true;
      }
    } catch (err) {
      print(err);
    }
    print(wasResponse);
  }

  Widget configureForm(
      IndependentVar iv, DependentVar dv, GlobalKey<FormState> formKey) {
    // create column widget
    List<Widget> columnList = [];
    print(iv.getIVType);
    print(dv.getDVType);
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
      } else {
        // create text input
        columnList.add(const Text('String Text Input'));
      }
    } else if (iv.getIVType == "Num") {
      if (iv.getIVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('Num Dropdown'));
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
      } else {
        // create text input
        columnList.add(const Text('String Text Input'));
      }
    } else if (dv.getDVType == "Num") {
      if (dv.getDVList.isNotEmpty) {
        // create dropdown
        columnList.add(const Text('Num Dropdown'));
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
          _submitObservation();
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
    dropdownValue = widget.currentProject.getIndependentVar.getIVList[0];
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
      /*
      Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Observation Form',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                child: Divider(
                  height: 10,
                  thickness: 2,
                  endIndent: 0,
                  color: Colors.blue,
                ),
              ),
              Text(
                  widget.currentProject.getIndependentVar.getIVName ??
                      'Independent Variable',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  )),
              SelectionDropdown(
                  stringList:
                      widget.currentProject.getIndependentVar.getIVList),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 8.0, 8.0),
                child: Divider(
                  height: 10,
                  thickness: 2,
                  endIndent: 0,
                  color: Colors.blue,
                ),
              ),
              Text(
                  widget.currentProject.getDependentVar.getDVName ??
                      'Dependent Variable',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  )),
              Text(sliderValue.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  )),
              Slider.adaptive(
                  value: sliderValue,
                  divisions: 7,
                  min: 0,
                  max: 7,
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _submitObservation();
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
              ),
            ],
          )),
          */
    );
  }
}

class SelectionDropdown extends StatefulWidget {
  const SelectionDropdown({Key? key, required this.stringList})
      : super(key: key);

  final List<String> stringList;

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
