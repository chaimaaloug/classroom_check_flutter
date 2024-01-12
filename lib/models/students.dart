import 'package:prj_flutter/models/student.dart';

class Students {
  final List<Student> students;

  const Students({required this.students});

  factory Students.fromJson(Map<String, dynamic> json) {
    final List<dynamic> studentsJson = json['students'] ?? [];
    final List<Student> students = studentsJson
        .map((dynamic studentJson) => Student.fromJson(studentJson))
        .toList();

    return Students(students: students);
  }
}
