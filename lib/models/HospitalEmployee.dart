class HospitalEmployee {
  final String uuid;
  final String employeeId;
  final String employeeName;
  final String? counterNumber;

  HospitalEmployee({
    required this.uuid,
    required this.employeeId,
    required this.employeeName,
    this.counterNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'counterNumber': counterNumber,
    };
  }

  HospitalEmployee.fromMap(Map<String, dynamic> map)
      : uuid = map['uuid'],
        employeeId = map['employeeId'],
        employeeName = map['employeeName'],
        counterNumber = map['counterNumber'];
}
