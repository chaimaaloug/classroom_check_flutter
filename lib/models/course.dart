import 'package:json_annotation/json_annotation.dart';
import './teacher.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final String name;
  final String shortDescription;
  final Teacher teacher;

  const Course({
    required this.name,
    required this.shortDescription,
    required this.teacher,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
