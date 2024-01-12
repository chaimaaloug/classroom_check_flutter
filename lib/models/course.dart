import 'package:uuid/uuid.dart';
import './teacher.dart';

class Course {
  final String name;
  final String shortDescription;
  final Teacher teacher;

  const Course({
    required this.name,
    required this.shortDescription,
    required this.teacher,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      teacher: Teacher.fromJson(json['teacher']),
    );
  }
}
