class Doctor {
  final String practiceNumber;
  final String practiceName;
  final String department;

  Doctor({
    required this.practiceNumber,
    required this.practiceName,
    required this.department,
  });

  Map<String, dynamic> toMap() {
    return {
      'practice_number': practiceNumber,
      'practice_name': practiceName,
      'department': department,
    };
  }

  Doctor.fromMap(Map<String, dynamic> map)
      : practiceNumber = map['practice_number'],
        practiceName = map['practice_name'],
        department = map['department'];
}
