import 'package:uuid/uuid.dart';

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

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: Uuid().v4(),
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      pictureUrl: json['pictureUrl'] as String,
    );
  }
}
