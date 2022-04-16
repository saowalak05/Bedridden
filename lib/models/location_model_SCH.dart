import 'dart:convert';

class LocationSCHModel {
  final String locationSCH; //วัด
  final double lat;
  final double lng;

  LocationSCHModel({
    required this.locationSCH,
    required this.lat,
    required this.lng,
  });

  LocationSCHModel copyWith({
    String? locationSCH,
    double? lat,
    double? lng,
  }) {
    return LocationSCHModel(
      locationSCH: locationSCH ?? this.locationSCH,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationSCH': locationSCH,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationSCHModel.fromMap(Map<String, dynamic> map) {
    return LocationSCHModel(
      locationSCH: map['locationSCH'],
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSCHModel.fromJson(String source) =>
      LocationSCHModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationSCHModel(locationSCH: $locationSCH, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationSCHModel &&
        other.locationSCH == locationSCH &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationSCH.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
