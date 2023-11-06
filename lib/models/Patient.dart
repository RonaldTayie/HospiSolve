class Patient {
  late String uuid;
  late final String patientId;
  late final String firstName;
  late final String lastName;
  late final String gender;
  late final DateTime dateOfBirth;
  late final String contactNumber;
  late String email;
  late final String residentialAddress;
  late final String postalAddress;
  late final List<String> allergies;
  late final bool? medicalAid;
  late final String? medicalAidProvider;
  late final String? medicalAidNumber;
  late final String? medicalAidPlan;

  Patient({
    this.uuid = "",
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
    this.medicalAidProvider,
    this.medicalAidNumber,
    this.medicalAidPlan,
  });

  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "patient_id": patientId,
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender,
      "date_of_birth": dateOfBirth.toIso8601String(),
      "contact_number": contactNumber,
      "email": email,
      "residential_address": residentialAddress,
      "postal_address": postalAddress.isNotEmpty?postalAddress:"",
      "allergies": allergies.toList().toString(),
      "medical_aid": medicalAid.toString(),
      "medical_aid_provider": medicalAidProvider,
      "medical_aid_number": medicalAidNumber,
      "medical_aid_plan": medicalAidPlan,
    };
  }

  Patient.fromMap(Map<String, dynamic> patientMap)
      : uuid = patientMap['uuid'],
        patientId = patientMap['patient_id'],
        firstName = patientMap['first_name'],
        lastName = patientMap['last_name'],
        gender = patientMap['gender'],
        dateOfBirth = DateTime.parse(patientMap['date_of_birth']),
        contactNumber = patientMap['contact_number'],
        email = patientMap['email'],
        residentialAddress = patientMap['residential_address'],
        postalAddress = patientMap['postal_address'],
        allergies = List<String>.from(patientMap['allergies']),
        medicalAid = patientMap['medical_aid'],
        medicalAidProvider = patientMap['medical_aid_provider'],
        medicalAidNumber = patientMap['medical_aid_number'],
        medicalAidPlan = patientMap['medical_aid_plan'];
}
