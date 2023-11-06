import 'package:flutter/material.dart';
import 'package:hospisolve/models/Doctor.dart';
import 'package:hospisolve/services/DataService.dart';
import 'dart:convert' as convert;

class DoctorProvider with ChangeNotifier {

  DataService _dataService =  DataService();
  Doctor? _doctor;
  late List<Doctor> _doctors;
  String? _practiceNumber;
  String? _practiceName;
  String? _department;

  Doctor? get doctor => _doctor;
  String? get practiceNumber => _practiceNumber;
  String? get practiceName => _practiceName;
  String? get department => _department;
  List<Doctor> get doctors => _doctors;

  void setDoctor(Doctor doctor) {
    _doctor = doctor;
    _practiceNumber = doctor.practiceNumber;
    _practiceName = doctor.practiceName;
    _department = doctor.department;
    notifyListeners();
  }
  DoctorProvider(){
    _doctors = List.empty(growable: true);
    loadDoctors();
  }
  Future<List<Doctor>> getDoctors()async{
    List<Doctor> docs = List.empty(growable: true);
    _dataService.readDataList(key: "doctors").then((value){
      if(value !=null){
        value.forEach((element) {
          docs.add( Doctor.fromMap( convert.jsonDecode(element)));
        });
      }
    });
    _doctors = docs;
    notifyListeners();
    return docs;
  }

  Future<void> loadDoctors()async{
    _dataService.networkGetRequest(url: "/doctors/getall").then((value){
      List<String> doctors = List.empty(growable: true);
      if(value !=null && value != "retry"){
        Map<String,dynamic> doctors_response = convert.jsonDecode(value);
        doctors_response['data']?.forEach((element) {
          Map<String,dynamic> doc = Map.of(element);
          doctors.add( convert.jsonEncode(doc));
          notifyListeners();
        });
        _dataService.writeDataList(key: "doctors", value: doctors);
      }
    });
  }

  void clearDoctor() {
    _doctor = null;
    _practiceNumber = null;
    _practiceName = null;
    _department = null;
    notifyListeners();
  }
}
