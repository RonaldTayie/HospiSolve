import 'package:flutter/foundation.dart';
import 'package:hospisolve/models/HospitalEmployee.dart';

class HospitalEmployeeProvider with ChangeNotifier {
  HospitalEmployee? _hospitalEmployee;

  String? _uuid;
  String? _employeeId;
  String? _employeeName;
  int? _counterNumber;

  HospitalEmployee? get hospitalEmployee => _hospitalEmployee;

  String? get uuid => _uuid;
  String? get employeeId => _employeeId;
  String? get employeeName => _employeeName;
  int? get counterNumber => _counterNumber;

  void setHospitalEmployee(HospitalEmployee hospitalEmployee) {
    _hospitalEmployee = hospitalEmployee;
    _uuid = hospitalEmployee.uuid;
    _employeeId = hospitalEmployee.employeeId;
    _employeeName = hospitalEmployee.employeeName;
    _counterNumber = hospitalEmployee.counterNumber;
    notifyListeners();
  }

  void clearHospitalEmployee() {
    _hospitalEmployee = null;
    _uuid = null;
    _employeeId = null;
    _employeeName = null;
    _counterNumber = null;
    notifyListeners();
  }
}
