import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'class_details.dart';
import 'project_obj.dart';
import 'user_observations_obj.dart';
import 'variables.dart';
import 'project_bundle.dart';

// home input page

class CodeInputScreen extends StatelessWidget {
  const CodeInputScreen({Key? key}) : super(key: key);

  final String _title = 'Citizen Science App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: FlutterLogo(),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
            ListTile(
              title: const Text('Back'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: const ClassCodeInput(),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class ClassCodeInput extends StatefulWidget {
  const ClassCodeInput({Key? key}) : super(key: key);

  @override
  _ClassCodeInputState createState() => _ClassCodeInputState();
}

class _ClassCodeInputState extends State<ClassCodeInput> {
  final TextEditingController _classCode = TextEditingController();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _classCode.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Future<ProjectBundle?> _getProjectRequest(projectCode) async {
    ProjectBundle asyncProject;
    // test code = 2022-1-1
    var url = Uri.parse(
        'https://cs467-citizen-science-for-kids.herokuapp.com/field_app/' +
            projectCode);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      asyncProject = ProjectBundle(ProjectObj.fromJson(data[0]),
          IndependentVar.fromJson(data[1]), DependentVar.fromJson(data[2]));
      return asyncProject;
    } else {
      return null;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(40),
            child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.psychology,
                  color: Colors.blue,
                  size: 100.0,
                )),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome to the Citizen Science App!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _classCode,
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
                labelText: 'Code',
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: isLoading
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
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final ProjectBundle? _asyncProject =
                    await _getProjectRequest(_classCode.text);
                if (_asyncProject == null) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Not a valid code. Please try again.')),
                  );
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    UserSpecificObservationsObj currentUser =
                        UserSpecificObservationsObj(
                            _deviceData['id'] ??
                                _deviceData['identifierForVendor'],
                            _asyncProject.getProjectObj.getProjectID);
                    return ClassDetailsScreen(_asyncProject, currentUser);
                  }));
                }
              },
              style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 20)),
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
