import 'package:flutter/material.dart';
import 'package:fluttermvc/constants/enums.dart';
import 'package:get/get.dart';

import '../../controller/patientController.dart';
import '../../model/patient.dart';
import 'components/Components.dart';

class EditDialog extends StatefulWidget {
  final Patient patient;
  const EditDialog({Key? key, required this.patient}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final patientController = Get.put(PatientController());
  final addPatientController = Get.put(AddPatientController());
  late final TextEditingController _name, _lname, _report;

  var meds = <dynamic>[];

  final FocusNode _namefocusNode = FocusNode();

  @override
  void initState() {
    _name = TextEditingController(text: widget.patient.name);
    _lname = TextEditingController(text: widget.patient.lname);
    _report = TextEditingController(text: widget.patient.report);
    meds = widget.patient.meds;
    _namefocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _lname.dispose();
    _report.dispose();
    _namefocusNode.dispose();
    super.dispose();
  }

  void _update() async {
    patientController.setState(FetchState.loding);

    Navigator.of(context).pop();
    final patient = Patient(id: widget.patient.id, date: widget.patient.date, name: _name.text, lname: _lname.text, report: _report.text, meds: meds);
    await patientController.repo.editPatient(patient);
    patientController.patients
        .where((element) => element == widget.patient)
        .forEach((element) { element.name = patient.name; element.lname = patient.lname; element.report = patient.report; element.meds = patient.meds; });

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
                      DTextField(name: _name, label: "Name", focusNode: _namefocusNode),
                      DTextField(name: _lname, label: "Last Name")
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DTextArea(report: _report,label: "Report",)),
                  GetBuilder<AddPatientController>(
                    init: AddPatientController(),
                    builder: (_) => InputChipList(
                        chips: meds.cast<String>(),
                        onDelete: (int index) {
                          meds.removeAt(index);
                          addPatientController.update();
                        }),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    OutlinedButton(child: const Text("Update"), onPressed: _update),
                    const SizedBox(width: 15),
                    OutlinedButton(child: const Text("Cancel"), onPressed: () => Navigator.of(context).pop())
                  ])
                ],
              ))),
        ));
  }
}
