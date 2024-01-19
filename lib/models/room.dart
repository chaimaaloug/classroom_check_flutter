import 'package:json_annotation/json_annotation.dart';
part 'room.g.dart';

@JsonSerializable()
class Room {
  final String name;
  final String pictureUrl;
  final Geo geo;

  Room({
    required this.name,
    required this.pictureUrl,
    required this.geo,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@JsonSerializable()
class Geo {
  final double latitude;
  final double longitude;
  final int radius;

  Geo({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}
