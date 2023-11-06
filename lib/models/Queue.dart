class Queue {
  final String queueNumber;
  final String patientId;
  final String counterNumber;
  final String? status;

  Queue({
    required this.queueNumber,
    required this.patientId,
    required this.counterNumber,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'queue_number': queueNumber,
      'patient_id': patientId,
      'counter_number': counterNumber,
      'status': status,
    };
  }

  Queue.fromMap(Map<String, dynamic> map)
      : queueNumber = map['queue_number'],
        patientId = map['patient_id'],
        counterNumber = map['counter_number'],
        status = map['status'];
}
