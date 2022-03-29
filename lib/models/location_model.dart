import 'dart:convert';

class LocationModel {
  final String location;
  final double lat;
  final double lng;

  LocationModel({
    required this.location,
    required this.lat,
    required this.lng,
  });

  LocationModel copyWith({
    String? location,
    double? lat,
    double? lng,
  }) {
    return LocationModel(
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      location: map['location'],
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(location: $location, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.location == location &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return location.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
