import 'package:flutter/material.dart';
import 'class_details.dart';
import 'projectObj.dart';

// home input page

class CodeInputScreen extends StatelessWidget {
  const CodeInputScreen({Key? key}) : super(key: key);

  final String _title = 'Citizen Science App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_title)),
        backgroundColor: Colors.black,
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

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _classCode.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _classCode.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${_classCode.text}');
  }

  ProjectObj _getProjectObject() {
    // sample object currently, will build error catching with http request
    ProjectObj currentProject = ProjectObj(
        1,
        1,
        1111,
        'Example Project',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut placerat orci nulla pellentesque dignissim. Sollicitudin nibh sit amet commodo nulla facilisi nullam. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Aliquam sem et tortor consequat id porta nibh. Orci phasellus egestas tellus rutrum tellus. Ornare arcu odio ut sem nulla pharetra diam sit. Ut aliquam purus sit amet luctus venenatis lectus magna. Cursus metus aliquam eleifend mi in nulla. Aliquam purus sit amet luctus venenatis lectus magna. Orci dapibus ultrices in iaculis nunc sed. Quis varius quam quisque id diam vel quam elementum. Egestas sed sed risus pretium quam vulputate dignissim suspendisse. A scelerisque purus semper eget duis at tellus. Phasellus egestas tellus rutrum tellus pellentesque eu tincidunt. Proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. Tempor nec feugiat nisl pretium fusce id velit ut.',
        'Example Project Prompt',
        'Science',
        DateTime.utc(2023, 11, 9));
    return currentProject;
  }

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
              child: FlutterLogo(
                curve: Curves.bounceIn,
                size: 100,
              ),
            ),
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
              child: const Text(
                'Submit',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  ProjectObj currentProject = _getProjectObject();
                  return ClassDetailsScreen(currentProject);
                }));
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
