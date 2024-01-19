// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Students _$StudentsFromJson(Map<String, dynamic> json) => Students(
      students: (json['students'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentsToJson(Students instance) => <String, dynamic>{
      'students': instance.students,
    };
