import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_citizen_science/modules/class_details.dart';
import 'package:flutter_citizen_science/modules/create_observation_screen.dart';
import 'package:flutter_citizen_science/modules/project_bundle.dart';
import 'package:flutter_citizen_science/modules/user_observations_obj.dart';
import 'project_obj.dart';
import 'create_observation_screen.dart';

// observations page

class ObservationsScreen extends StatefulWidget {
  const ObservationsScreen(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final ProjectBundle _currentProject;

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
          centerTitle: true,
          title: Text(_title),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
            elevation: 5.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateObservationScreen(
                        widget._currentProject, widget._currentUser),
                  )).then((value) {
                setState(() {});
              });
            }));
  }
}

class ObservationView extends StatefulWidget {
  const ObservationView(this._currentProject, this._currentUser, {Key? key})
      : super(key: key);

  final ProjectBundle _currentProject;

  final UserSpecificObservationsObj _currentUser;

  @override
  _ObservationViewState createState() => _ObservationViewState();
}

class _ObservationViewState extends State<ObservationView> {
  List<Widget> observationWidgets = [];

  Future<List> _loadData() async {
    List posts = [];
    try {
      // This is an open REST API endpoint for testing purposes
      var url = 'https://cs467-citizen-science.herokuapp.com/field_app/' +
          widget._currentProject.getProjectObj.getProjectCode +
          '/' +
          widget._currentUser.getUserID;

      final http.Response response = await http.get(Uri.parse(url));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Expanded(
        child: FutureBuilder(
            future: _loadData(),
            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) => Card(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Observation: ' + (index + 1).toString()),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                title: Text(snapshot.data![index]['obs_vals']
                                        ['iv_val']
                                    .toString()),
                                subtitle: Text(snapshot.data![index]['obs_vals']
                                        ['dv_val']
                                    .toString()),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        print('Edit pressed!');
                                      },
                                      child: const Text('EDIT')),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          print('Delete pressed!');
                                        });
                                      },
                                      child: const Text('DELETE'))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )),
      ),

      /*
        ListView.builder(
          itemCount: observationWidgets.length,
          itemBuilder: (context, index) {
            return observationWidgets[index];
          },
          */
    );
  }
}
