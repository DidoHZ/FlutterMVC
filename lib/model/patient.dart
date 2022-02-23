import 'dart:convert';

class Patient {
  String date, name, lname, report;
  List<dynamic> meds;

  Patient({
    required this.date,
    required this.name,
    required this.lname,
    required this.report,
    required this.meds,
  });

  static List<Patient> patientsFromJson(String str) => List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

  Patient.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        name = json['name'],
        lname = json['lname'],
        report = json['report'],
        meds = json['meds'];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.date == date &&
        other.name == name &&
        other.lname == lname &&
        other.report == report &&
        other.meds == meds;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      name.hashCode ^
      lname.hashCode ^
      report.hashCode ^
      report.hashCode ^
      meds.hashCode;
}