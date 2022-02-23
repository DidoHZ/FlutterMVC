import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/patientView.dart';

// Using GetX Material

/*
* Flutter MVC Example.
* @Author(Imad Hamzaoui)
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Patients',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PatientPage(),
    );
  }
}