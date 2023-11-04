import 'package:flutter/material.dart';
import 'package:hospisolve/models/Patient.dart';

class PatientProvider with ChangeNotifier {

  late Patient _patient;
  late int _patientId = 0;
  late String _firstName = "";
  late String _lastName = "";
  late String _gender="M";
  late DateTime _dateOfBirth = DateTime.now();
  late String _contactNumber="";
  late String _email = "";
  late String _residentialAddress = "";
  late String _postalAddress = "";
  late List<String> _allergies = [];
  late bool _medicalAid = false;
  late String _medicalAidProvider ="";
  late String _medicalAidNumber ="";
  late String _medicalAidPlan = "";

  Patient get patient => _patient;
  int get patientId => _patientId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  DateTime get dateOfBirth => _dateOfBirth;
  String get contactNumber => _contactNumber;
  String get email => _email;
  String get residentialAddress => _residentialAddress;
  String get postalAddress => _postalAddress;
  List<String> get allergies => _allergies;
  bool get medicalAid => _medicalAid;
  String get medicalAidProvider => _medicalAidProvider;
  String get medicalAidNumber => _medicalAidNumber;
  String get medicalAidPlan => _medicalAidPlan;

  void setPatient(Patient patient) {
    setPatientId(patient.patientId);
    setFirstName(patient.firstName);
    setLastName(patient.lastName);
    setGender(patient.gender);
    setDateOfBirth(patient.dateOfBirth);
    setContactNumber(patient.contactNumber);
    setEmail(patient.email);
    setResidentialAddress(patient.residentialAddress);
    setPostalAddress(patient.postalAddress);
    setAllergies(patient.allergies);
    setMedicalAid(patient.medicalAid);
    setMedicalAidProvider(patient.medicalAidProvider);
    setMedicalAidNumber(patient.medicalAidNumber);
    setMedicalAidPlan(patient.medicalAidPlan);
    notifyListeners();
  }

  void setPatientId(int patientId) {
    _patientId = patientId;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setDateOfBirth(DateTime dateOfBirth) {
    _dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void setContactNumber(String contactNumber) {
    _contactNumber = contactNumber;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setResidentialAddress(String residentialAddress) {
    _residentialAddress = residentialAddress;
    notifyListeners();
  }

  void setPostalAddress(String postalAddress) {
    _postalAddress = postalAddress;
    notifyListeners();
  }

  void setAllergies(List<String> allergies) {
    _allergies = allergies;
    notifyListeners();
  }

  void setMedicalAid(medicalAid) {
    _medicalAid = medicalAid;
    notifyListeners();
  }

  void setMedicalAidProvider(String medicalAidProvider) {
    _medicalAidProvider = medicalAidProvider;
    notifyListeners();
  }

  void setMedicalAidNumber(String medicalAidNumber) {
    _medicalAidNumber = medicalAidNumber;
    notifyListeners();
  }

  void setMedicalAidPlan(String medicalAidPlan) {
    _medicalAidPlan = medicalAidPlan;
    notifyListeners();
  }

  Patient getPatient (){
    Patient patient = Patient(
        patientId: patientId,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        dateOfBirth: dateOfBirth,
        contactNumber: contactNumber,
        residentialAddress: residentialAddress,
        postalAddress: postalAddress,
        allergies: allergies,
        email: email,
        medicalAid: medicalAid,
        medicalAidProvider: medicalAidProvider,
        medicalAidNumber: medicalAidNumber,
        medicalAidPlan: medicalAidPlan,
    );
    return patient;
  }

}
