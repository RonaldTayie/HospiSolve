class HospitalEmployee {
  final String uuid;
  final String employeeId;
  final String employeeName;
  final int? counterNumber;

  HospitalEmployee({
    required this.uuid,
    required this.employeeId,
    required this.employeeName,
    this.counterNumber,
  });
}
