import 'dart:convert';

class Patient {
  String id;
  String date;
  String name;
  String lname;
  String report;
  List<dynamic> meds;
  bool selected = false;

  Patient({
    required this.id,
    required this.date,
    required this.name,
    required this.lname,
    required this.report,
    required this.meds,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient &&
        other.id == id &&
        other.date == date &&
        other.name == name &&
        other.lname == lname &&
        other.report == report &&
        other.selected == selected &&
        other.meds == meds;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      name.hashCode ^
      lname.hashCode ^
      report.hashCode ^
      report.hashCode ^
      selected.hashCode ^
      meds.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'name': name,
      'lname': lname,
      'report': report,
      'meds': meds
    };
  }

  factory Patient.fromJson(Map<String, dynamic> map) {
    return Patient(
        id: map['_id'],
        date: map['date'] ?? '',
        name: map['name'] ?? '',
        lname: map['lname'] ?? '',
        report: map['report'] ?? '',
        meds: List<dynamic>.from(map['meds']));
  }

  String toJson() => json.encode(toMap());

  //factory Patient.fromJson(String source) => Patient.fromMap(json.decode(source));

  static List<Patient> patientsFromJson(String str) =>
      List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));
}
