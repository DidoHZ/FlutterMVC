import 'package:flutter/material.dart';
import 'package:fluttermvc/constants/enums.dart';
import 'package:fluttermvc/view/widget/NoConnection.dart';
import 'package:get/get.dart';
import '../controller/patientController.dart';
import 'widget/AddPatientDialog.dart';
import 'widget/PatientTable.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({
    Key? key,
  }) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  // Get the Controllers
  final patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients"), // Scaffold Title
        // Scaffold Actions ( Add , Refresh)
        actions: [
          // Add Button Appaire when there is Connection
          GetBuilder<PatientController>(
              init: patientController,
              id: 'add',
              builder: (_) {
                if (patientController.fetchState != FetchState.succeed) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const AddDialog());
                    });
              }),
          // Refresh Button (Reload data)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              patientController.getPatients();
            },
          )
        ],
      ),
      body: Center(
          child: GetBuilder<PatientController>(
        init: patientController,
        id: 'body',
        builder: (_) {
          // When loding data from the server..
          if (patientController.fetchState == FetchState.loding) {
            return const CircularProgressIndicator();
          }
          // Handling connection fail
          else if (patientController.fetchState == FetchState.failed) {
            return const NoConnection();
          }
          // When data fetched succussfully
          else if (patientController.fetchState == FetchState.succeed) {
            return const SingleChildScrollView(child: PatientTable());
          }

          // Handling Unexpected State
          throw Exception(
              "Unexpected State: " + patientController.fetchState.toString());
        },
      )),
    );
  }
}
