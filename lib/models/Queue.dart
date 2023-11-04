class Queue {
  final int queueNumber;
  final String patientId;
  final int counterNumber;
  final String? status;

  Queue({
    required this.queueNumber,
    required this.patientId,
    required this.counterNumber,
    this.status,
  });
}
