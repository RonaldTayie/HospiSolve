import 'package:flutter/material.dart';
import 'package:hospisolve/models/Appointment.dart';

class AppointmentProvider with ChangeNotifier {
  Appointment? _appointment;

  int? _patientId;
  String? _practiceNumber;
  DateTime? _dateBooked;

  Appointment? get appointment => _appointment;
  int? get patientId => _patientId;
  String? get practiceNumber => _practiceNumber;
  DateTime? get dateBooked => _dateBooked;

  void setAppointment(Appointment appointment) {
    _appointment = appointment;
    _patientId = appointment.patientId;
    _practiceNumber = appointment.practiceNumber;
    _dateBooked = appointment.dateBooked;
    notifyListeners();
  }

  void clearAppointment() {
    _appointment = null;
    _patientId = null;
    _practiceNumber = null;
    _dateBooked = null;
    notifyListeners();
  }
}
