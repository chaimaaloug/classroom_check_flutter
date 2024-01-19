// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      name: json['name'] as String,
      pictureUrl: json['pictureUrl'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'geo': instance.geo,
    };

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: json['radius'] as int,
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };
