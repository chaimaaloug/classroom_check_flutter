class Room {
  final String name;
  final String pictureUrl;
  final Geo geo;

  Room({
    required this.name,
    required this.pictureUrl,
    required this.geo,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['room']['name'],
      pictureUrl: json['room']['pictureUrl'],
      geo: Geo.fromJson(json['room']['geo']),
    );
  }
}

class Geo {
  final double latitude;
  final double longitude;
  final int radius;

  Geo({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
    );
  }
}
