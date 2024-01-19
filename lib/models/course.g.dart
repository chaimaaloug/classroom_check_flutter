// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'teacher': instance.teacher,
    };
