import 'dart:convert';

class LocationHOTModel {
  final String locationHOT; //วัด
  final double lat;
  final double lng;

  LocationHOTModel({
    required this.locationHOT,
    required this.lat,
    required this.lng,
  });

  LocationHOTModel copyWith({
    String? locationHOT,
    double? lat,
    double? lng,
  }) {
    return LocationHOTModel(
      locationHOT: locationHOT ?? this.locationHOT,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationHOT': locationHOT,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationHOTModel.fromMap(Map<String, dynamic> map) {
    return LocationHOTModel(
      locationHOT: map['locationHOT'],
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationHOTModel.fromJson(String source) =>
      LocationHOTModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationHOTModel(locationHOT: $locationHOT, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationHOTModel &&
        other.locationHOT == locationHOT &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationHOT.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
