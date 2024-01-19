import 'package:json_annotation/json_annotation.dart';
import 'student.dart';

part 'students.g.dart';

@JsonSerializable()
class Students {
  final List<Student> students;

  const Students({required this.students});

  factory Students.fromJson(Map<String, dynamic> json) =>
      _$StudentsFromJson(json);

  Map<String, dynamic> toJson() => _$StudentsToJson(this);
}
