import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final bool hasSigned;

  const Student({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.hasSigned,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
