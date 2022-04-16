import 'dart:convert';

class LocationSTModel {
  final String locationST; //วัด
  final double lat;
  final double lng;

  LocationSTModel({
    required this.locationST,
    required this.lat,
    required this.lng,
  });

  LocationSTModel copyWith({
    String? locationST,
    double? lat,
    double? lng,
  }) {
    return LocationSTModel(
      locationST: locationST ?? this.locationST,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'locationST': locationST,
      'lat': lat,
      'lng': lng,
    };
  }

  factory LocationSTModel.fromMap(Map<String, dynamic> map) {
    return LocationSTModel(
      locationST: map['locationST'],
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationSTModel.fromJson(String source) =>
      LocationSTModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationSTModel(locationST: $locationST, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationSTModel &&
        other.locationST == locationST &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return locationST.hashCode ^ lat.hashCode ^ lng.hashCode;
  }
}
