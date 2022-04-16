import 'dart:convert';

class LocationModel {
  final String locationTEM; //วัด
  final double lat;
  final double lng;

  LocationModel({
    required this.locationTEM,
    required this.lat,
    required this.lng,
  });

  LocationModel copyWith({
    String? locationTEM,
    double? lat,
    double? lng,
  }) {
    return LocationModel(
      locationTEM: locationTEM ?? this.locationTEM,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationTEM': locationTEM,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      locationTEM: map['locationTEM'],
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(locationTEM: $locationTEM, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.locationTEM == locationTEM &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationTEM.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
