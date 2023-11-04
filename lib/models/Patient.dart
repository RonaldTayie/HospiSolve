class Patient {
  late String uuid;
  late final int patientId;
  late final String firstName;
  late final String lastName;
  late final String gender;
  late final DateTime dateOfBirth;
  late final String contactNumber;
  late final String email;
  late final String residentialAddress;
  late final String postalAddress;
  late final List<String> allergies;
  late final bool? medicalAid;
  late final String medicalAidProvider;
  late final String medicalAidNumber;
  late final String medicalAidPlan;

  Patient({
    this.uuid="",
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.residentialAddress,
    required this.postalAddress,
    required this.allergies,
    required this.email,
    this.medicalAid,
    required this.medicalAidProvider,
    required this.medicalAidNumber,
    required this.medicalAidPlan,
  });

  // Getters for all attributes
  String get getUuid => uuid;
  int get getPatientId => patientId;
  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getGender => gender;
  DateTime get getDateOfBirth => dateOfBirth;
  String get getContactNumber => contactNumber;
  String get getEmail => email;
  String get getResidentialAddress => residentialAddress;
  String get getPostalAddress => postalAddress;
  List<String> get getAllergies => allergies;
  bool? get getMedicalAid => medicalAid;
  String get getMedicalAidProvider => medicalAidProvider;
  String get getMedicalAidNumber => medicalAidNumber;
  String get getMedicalAidPlan => medicalAidPlan;

  // Setters for attributes that can be modified
  set setUuid(String value) => uuid = value;
  set setPatientId(int value) => patientId = value;
  set setFirstName(String value) => firstName = value;
  set setLastName(String value) => lastName = value;
  set setGender(String value) => gender = value;
  set setDateOfBirth(DateTime value) => dateOfBirth = value;
  set setContactNumber(String value) => contactNumber = value;
  set setEmail(String value) => email = value;
  set setResidentialAddress(String value) => residentialAddress = value;
  set setPostalAddress(String value) => postalAddress = value;
  set setAllergies(List<String> value) => allergies = value;
  set setMedicalAid(bool? value) => medicalAid = value;
  set setMedicalAidProvider(String value) => medicalAidProvider = value;
  set setMedicalAidNumber(String value) => medicalAidNumber = value;
  set setMedicalAidPlan(String value) => medicalAidPlan = value;
}
