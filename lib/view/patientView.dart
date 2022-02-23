import 'package:flutter/material.dart';
import 'package:fluttermvc/constants/enums.dart';
import 'package:fluttermvc/view/widget/noConnection.dart';
import 'package:get/get.dart';
import '../controller/patientController.dart';
import 'widget/patientDetail.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({
    Key? key,
  }) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  // Get the Controller
  final patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Patients"), // Scaffold Title
          actions: [
            // Refresh Button (Reload data)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                patientController.getPatients();
              },
            )
          ],
        ),
        body: Center(child: Obx(() {
          // When loding data from the server..
          if (patientController.fetchState.value == FetchState.loding) {
            return const Center(child: CircularProgressIndicator());
          }
          // Handling connection fail
          else if (patientController.fetchState.value == FetchState.failed) {
            return const NoConnection();
          }
          // When data fetched succussfully
          else if (patientController.fetchState.value == FetchState.succeed) {
            return ListView.builder(
                itemCount: patientController.patients.length,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) => PatientDetail(
                      patient: patientController.patients[index],
                    ));
          }

          // Handling Unexpected State
          throw Exception("Unexpected State: " +
              patientController.fetchState.value.toString());
        })));
  }
}
