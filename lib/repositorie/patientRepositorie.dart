import 'package:fluttermvc/constants/strings.dart';
import 'package:fluttermvc/model/patient.dart';
import 'package:http/http.dart' as http;

class PatientRepositorie {
  Future<List<Patient>> getPatients() async {
    final res = await http.get(Uri.parse(BASE_URL + '/Patients'));
    
    return Patient.patientsFromJson(res.body);
  }
}
