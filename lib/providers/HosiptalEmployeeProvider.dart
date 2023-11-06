import 'package:flutter/foundation.dart';
import 'package:hospisolve/models/HospitalEmployee.dart';
import 'package:hospisolve/services/DataService.dart';
import 'dart:convert' as convert;

class HospitalEmployeeProvider with ChangeNotifier {
  // Load services
  DataService _dataService = DataService();

  HospitalEmployee? _hospitalEmployee;

  String? _uuid;
  String? _employeeId;
  String? _employeeName;
  String? _counterNumber;


  HospitalEmployee? get hospitalEmployee => _hospitalEmployee;

  String? get uuid => _uuid;
  String? get employeeId => _employeeId;
  String? get employeeName => _employeeName;
  String? get counterNumber => _counterNumber;

  void setEmployeeId(String v)=>_employeeId=v;
  void setEmployeeName(String v)=>_employeeName=v;
  void setCounterNumber(String v)=>_counterNumber=v;

  void setHospitalEmployee(HospitalEmployee hospitalEmployee) {
    _hospitalEmployee = hospitalEmployee;
    _uuid = hospitalEmployee.uuid;
    _employeeId = hospitalEmployee.employeeId;
    _employeeName = hospitalEmployee.employeeName;
    _counterNumber = hospitalEmployee.counterNumber;
    notifyListeners();
  }


  List<HospitalEmployee> getEmployees(){
    List<HospitalEmployee> employees = List.empty();
    if(_dataService.readDataList(key: "hospital_employees")!=null){
      List<String> employees_tmp = _dataService.readDataList(key: "hospital_employees") as List<String>;
      employees_tmp.forEach((element) {
        employees.add( HospitalEmployee.fromMap( convert.jsonDecode(element)));
      });
    }

    return employees;
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
