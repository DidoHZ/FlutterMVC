import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/patientController.dart';
import '../../model/patient.dart';

/*
* This Widget used to show the patient details
* using AutomaticKeepAliveClientMixin to avoid rerendering when scrolling
* showing (Date, name & last name, report, Meds)
*/
class PatientDetail extends StatefulWidget {
  final Patient patient;
  const PatientDetail({Key? key, required this.patient}) : super(key: key);

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

//
class _PatientDetailState extends State<PatientDetail>
    with AutomaticKeepAliveClientMixin {
  final patientController = Get.put(PatientController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("rebuild");
    Size size = MediaQuery.of(context).size;
    return Card(
        child: ExpansionTile(
      title: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(children: [
          const Text(
            "Date",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Text(widget.patient.date)
        ]),
        Column(children: [  
        const Text(
            "Nom et Prenom",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Text(widget.patient.lname + " " + widget.patient.name)
        ])
      ])),
      // Expandable part
      children: [
        Padding(padding:EdgeInsets.only(right:size.width*.05,left:size.width*.05),child: const Divider()),
        Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	      crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Report at the left of the Row
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      width: size.width*.4,
                      child: const Text("report",
                      style: TextStyle(color: Colors.grey, fontSize: 12))),
                  SizedBox(
                      width: size.width*.4,
                      child: Text("\t"+widget.patient.report))
                ],
              ),
              // Meds at the Right of the Row
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [ 
                  SizedBox(
                      width: size.width*.4,
                      child: const Text("Meds",
                      style: TextStyle(color: Colors.grey, fontSize: 12))),
                  ...List.generate(
                      widget.patient.meds.length,
                      (index) => SizedBox(
                        width: size.width*.4,
                          child: Text("   - " +
                          widget.patient.meds[index]))),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
