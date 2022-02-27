import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluttermvc/controller/patientController.dart';
import 'package:fluttermvc/view/widget/EditPatientDialog.dart';

/*
* This Widget used to show the patients details
* showing (Date, Name, Report, Meds)
*/

class PatientTable extends StatefulWidget {
  const PatientTable({Key? key}) : super(key: key);

  @override
  _PatientTableState createState() => _PatientTableState();
}

//
class _PatientTableState extends State<PatientTable> {
  final patientController = Get.put(PatientController());

  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  var selectedCount = 0;

  void deleteSelectedPatiened() {
    setState(() {
      var toRemove = [];
    
      patientController.patients
                      .where((patient) => patient.selected)
                      .forEach((patient) async { toRemove.add(patient); await patientController.repo.removePatient(patient);} );
                      
      selectedCount -= toRemove.length;
      patientController.patients.removeWhere( (p) => toRemove.contains(p));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
        header: const Text("Patients"),
        actions: [
          IconButton(
              onPressed: () => deleteSelectedPatiened(),
              icon: const Icon(Icons.delete))
        ],
        rowsPerPage: rowsPerPage,
        availableRowsPerPage: const <int>[5, 10, 20],
        onRowsPerPageChanged: (int? value) {
          if (value != null) setState(() { rowsPerPage = value; });
        },
        columns: tableColumn,
        source: PatientDataSource(context,selectedCount));
  }
}

class PatientDataSource extends DataTableSource {
  PatientController patientController = Get.put(PatientController());
  final BuildContext _context;
  int selectedCount;

  PatientDataSource(this._context,this.selectedCount);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= patientController.patients.length) return null;
    final patient = patientController.patients[index];
    return DataRow.byIndex(
        index: index,
        selected: patient.selected,
        onSelectChanged: (bool? value) {
          if (value == null) return;
          if (patient.selected != value) {
            selectedCount += value ? 1 : -1;
            //assert(patientTableController.selectedCount >= 0);
            patient.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text(patient.name + ' ' + patient.lname)),
          DataCell(Text(patient.date)),
          DataCell(SizedBox(width: 300, child: Text(patient.report))),
          DataCell(Text(patient.meds.map((e) => "- " + e,).join("\n"))),
          DataCell(IconButton(
              onPressed: () => showDialog(context: _context, builder: (_) => EditDialog(patient: patient)),
              icon: const Icon(Icons.edit_note_outlined)))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => patientController.patients.length;

  @override
  int get selectedRowCount => selectedCount;
}

const tableColumn = <DataColumn>[
  DataColumn(label: Text("Name")),
  DataColumn(label: Text("Date"), tooltip: "patient's visiting day"),
  DataColumn(label: Text("Repot")),
  DataColumn(label: Text("Meds")),
  DataColumn(label: Text("Edit"))
];
