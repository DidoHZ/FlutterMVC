import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermvc/constants/enums.dart';
import 'package:get/get.dart';

import '../../controller/patientController.dart';
import '../../model/patient.dart';
import 'components/Components.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final patientController = Get.put(PatientController());
  final addPatientController = Get.put(AddPatientController());

  var meds = <String>[];

  final _name = TextEditingController(),
      _lname = TextEditingController(),
      _report = TextEditingController();

  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    _nameFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _lname.dispose();
    _report.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _add() async {
    patientController.setState(FetchState.loding);

    Navigator.of(context).pop();
    final now = DateTime.now();
    final date = now.year.toString().padLeft(2, '0') + "-" + now.month.toString().padLeft(2, '0') + "-" + now.day.toString().padLeft(2, '0');
    final patient = Patient(id: '', date: date, name: _name.text, lname: _lname.text, report: _report.text, meds: meds);
    patient.id = json.decode((await patientController.repo.addPatient(patient)).body)["insertedId"];
    patientController.patients.add(patient);

    patientController.setState(FetchState.succeed);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.transparent,
        child: Card(
          elevation: 3,
          child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * .5,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DTextField(name: _name, label: "Name", focusNode: _nameFocusNode),
                      DTextField(name: _lname, label: "Last Name")
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DTextArea(report: _report, label: "Report" )),
                  GetBuilder<AddPatientController>(
                    init: AddPatientController(),
                    builder: (_) => InputChipList(
                      chips: meds,
                      onDelete: (int index) {
                        meds.removeAt(index);
                        addPatientController.update();
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    OutlinedButton(child: const Text("Add"), onPressed: _add),
                    const SizedBox(width: 15),
                    OutlinedButton(child: const Text("Cancel"), onPressed: () => Navigator.of(context).pop())
                  ])
                ],
              ))),
        ));
  }
}
