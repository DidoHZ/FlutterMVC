import 'package:fluttermvc/constants/enums.dart';
import 'package:fluttermvc/model/patient.dart';

import 'package:get/get.dart';

import '../repositorie/patientRepositorie.dart';

class PatientController extends GetxController {
  var fetchState = FetchState.init.obs;
  var patients = <Patient>[];
  var repo = PatientRepositorie();

  @override
  void onInit() {
    getPatients();
    super.onInit();
  }

  void getPatients() async {
    fetchState(FetchState.loding);
    try {
      patients = await repo.getPatients();
      fetchState(FetchState.succeed);
    } catch (err) {
      fetchState(FetchState.failed);
    }
  }
}
