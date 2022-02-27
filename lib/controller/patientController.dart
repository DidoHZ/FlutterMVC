import 'package:fluttermvc/constants/enums.dart';
import 'package:fluttermvc/model/patient.dart';

import 'package:get/get.dart';

import '../repositorie/patientRepositorie.dart';

class PatientController extends GetxController {
  var fetchState = FetchState.init;
  var patients = <Patient>[];
  var repo = PatientRepositorie();

  @override
  void onInit() {
    getPatients();
    super.onInit();
  }

  void setState(FetchState _fetchState, {List<String> id = const ['body']}) {
    fetchState = _fetchState;
    update(id);
  }

  void getPatients() async {
    setState(FetchState.loding, id: ['body','add']);
    try {
      patients = await repo.getPatients();
      setState(FetchState.succeed, id: ['body','add']);
    } catch (err) {
      setState(FetchState.failed, id: ['body','add']);
    }
  }
}

class AddPatientController extends GetxController {}

class EditPatientController extends GetxController {}
