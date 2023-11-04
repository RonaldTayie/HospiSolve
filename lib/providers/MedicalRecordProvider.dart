import 'package:flutter/material.dart';
import 'package:hospisolve/models/MedicalRecord.dart';

class MedicalRecordProvider with ChangeNotifier {
  MedicalRecord? _medicalRecord;

  int? _patientId;
  String? _practiceNumber;
  DateTime? _dateDiagnosed;
  String? _diagnoses;
  List<dynamic>? _prescriptions;

  MedicalRecord? get medicalRecord => _medicalRecord;
  int? get patientId => _patientId;
  String? get practiceNumber => _practiceNumber;
  DateTime? get dateDiagnosed => _dateDiagnosed;
  String? get diagnoses => _diagnoses;
  List<dynamic>? get prescriptions => _prescriptions;

  void setMedicalRecord(MedicalRecord medicalRecord) {
    _medicalRecord = medicalRecord;
    _patientId = medicalRecord.patientId;
    _practiceNumber = medicalRecord.practiceNumber;
    _dateDiagnosed = medicalRecord.dateDiagnosed;
    _diagnoses = medicalRecord.diagnoses;
    _prescriptions = medicalRecord.prescriptions;
    notifyListeners();
  }

  void clearMedicalRecord() {
    _medicalRecord = null;
    _patientId = null;
    _practiceNumber = null;
    _dateDiagnosed = null;
    _diagnoses = null;
    _prescriptions = null;
    notifyListeners();
  }
}
