import 'dart:convert';

class LocationHELModel {
  final String locationHEL; //วัด
  final double lat;
  final double lng;

  LocationHELModel({
    required this.locationHEL,
    required this.lat,
    required this.lng,
  });

  LocationHELModel copyWith({
    String? locationHEL,
    double? lat,
    double? lng,
  }) {
    return LocationHELModel(
      locationHEL: locationHEL ?? this.locationHEL,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationSCH': locationHEL,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationHELModel.fromMap(Map<String, dynamic> map) {
    return LocationHELModel(
      locationHEL: map['locationHEL'] ?? '',
      lat: map['lat'].toDouble() ?? 0.0,
      lng: map['lng'].toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationHELModel.fromJson(String source) =>
      LocationHELModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationHELModel(locationHEL: $locationHEL, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationHELModel &&
        other.locationHEL == locationHEL &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationHEL.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
