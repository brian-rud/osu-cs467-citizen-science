import 'package:flutter/material.dart';
import 'package:flutter_citizen_science/modules/class_details.dart';
import 'package:flutter_citizen_science/modules/class_input_screen.dart';

void main() => (runApp(const CitizenScienceApp()));

class CitizenScienceApp extends StatelessWidget {
  const CitizenScienceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CodeInputScreen(),
    );
  }
}
