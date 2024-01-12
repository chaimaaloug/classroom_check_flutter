import 'package:uuid/uuid.dart';

class Session {
  final String id;
  final String startDate;
  final String endDate;

  const Session({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: Uuid().v4(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );
  }
}
