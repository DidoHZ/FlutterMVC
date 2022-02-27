import 'package:fluttermvc/constants/strings.dart';
import 'package:fluttermvc/model/patient.dart';
import 'package:http/http.dart' as http;

class PatientRepositorie {

  Future<List<Patient>> getPatients() async {
    final res = await http.get(Uri.parse(BASE_URL + '/Patients'));

    return Patient.patientsFromJson(res.body);
  }

  Future<http.Response> addPatient(Patient patient) async {
    return await http.post(Uri.parse(BASE_URL + '/Patients/Add'),headers: {"Content-Type":"application/json"},body: patient.toJson());
  }

  Future<http.Response> removePatient(Patient patient) async {
    return await http.post(Uri.parse(BASE_URL + '/Patients/Delete'),headers: {"Content-Type":"application/json"},body: patient.toJson());
  }

  Future<http.Response> editPatient(Patient patient) async {
    return await http.post(Uri.parse(BASE_URL + '/Patients/Edit'),headers: {"Content-Type":"application/json"},body: patient.toJson());
  }
}
