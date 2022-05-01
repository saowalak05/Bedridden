import 'dart:convert';

class LocationSAOModel {
  final String locationSAO; //วัด
  final double lat;
  final double lng;

  LocationSAOModel({
    required this.locationSAO,
    required this.lat,
    required this.lng,
  });

  LocationSAOModel copyWith({
    String? locationSAO,
    double? lat,
    double? lng,
  }) {
    return LocationSAOModel(
      locationSAO: locationSAO ?? this.locationSAO,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationSCH': locationSAO,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationSAOModel.fromMap(Map<String, dynamic> map) {
    return LocationSAOModel(
      locationSAO: map['locationSAO'] ?? '',
      lat: map['lat'].toDouble() ?? 0.0,
      lng: map['lng'].toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSAOModel.fromJson(String source) =>
      LocationSAOModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationSAOModel(locationSAO: $locationSAO, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationSAOModel &&
        other.locationSAO == locationSAO &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationSAO.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
