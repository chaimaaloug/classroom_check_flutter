import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String pictureUrl;

  const Teacher({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.pictureUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
