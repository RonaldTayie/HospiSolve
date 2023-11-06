class MedicalRecord {
  final int patientId;
  final String practiceNumber;
  final DateTime dateDiagnosed;
  final String? diagnoses;
  final List<dynamic> prescriptions;

  MedicalRecord({
    required this.patientId,
    required this.practiceNumber,
    required this.dateDiagnosed,
    this.diagnoses,
    required this.prescriptions,
  });
}
