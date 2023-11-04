import 'package:flutter/material.dart';
import 'package:hospisolve/models/Doctor.dart';

class DoctorProvider with ChangeNotifier {
  Doctor? _doctor;

  String? _practiceNumber;
  String? _practiceName;
  String? _department;

  Doctor? get doctor => _doctor;
  String? get practiceNumber => _practiceNumber;
  String? get practiceName => _practiceName;
  String? get department => _department;

  void setDoctor(Doctor doctor) {
    _doctor = doctor;
    _practiceNumber = doctor.practiceNumber;
    _practiceName = doctor.practiceName;
    _department = doctor.department;
    notifyListeners();
  }

  void clearDoctor() {
    _doctor = null;
    _practiceNumber = null;
    _practiceName = null;
    _department = null;
    notifyListeners();
  }
}
