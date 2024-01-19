import 'package:uuid/uuid.dart';

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

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      hasSigned: json['hasSigned'] as bool,
    );
  }
}
