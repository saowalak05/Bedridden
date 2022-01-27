import 'dart:convert';

class EnvironmentModel {
  final String accommodation;
  final String statusresidenceother;
  final String typeHouse;
  final String housetypeother;
  final String typeHomeEnvironment;
  final String homeienvironment;
  final String typeHousingSafety;
  final String housingSafety;
  final String typefacilities;
  final String facilities;
  final String urlenvironmentImage;
  EnvironmentModel({
    required this.accommodation,
    required this.statusresidenceother,
    required this.typeHouse,
    required this.housetypeother,
    required this.typeHomeEnvironment,
    required this.homeienvironment,
    required this.typeHousingSafety,
    required this.housingSafety,
    required this.typefacilities,
    required this.facilities,
    required this.urlenvironmentImage,
  });

  EnvironmentModel copyWith({
    String? accommodation,
    String? statusresidenceother,
    String? typeHouse,
    String? housetypeother,
    String? typeHomeEnvironment,
    String? homeienvironment,
    String? typeHousingSafety,
    String? housingSafety,
    String? typefacilities,
    String? facilities,
    String? urlenvironmentImage,
  }) {
    return EnvironmentModel(
      accommodation: accommodation ?? this.accommodation,
      statusresidenceother: statusresidenceother ?? this.statusresidenceother,
      typeHouse: typeHouse ?? this.typeHouse,
      housetypeother: housetypeother ?? this.housetypeother,
      typeHomeEnvironment: typeHomeEnvironment ?? this.typeHomeEnvironment,
      homeienvironment: homeienvironment ?? this.homeienvironment,
      typeHousingSafety: typeHousingSafety ?? this.typeHousingSafety,
      housingSafety: housingSafety ?? this.housingSafety,
      typefacilities: typefacilities ?? this.typefacilities,
      facilities: facilities ?? this.facilities,
      urlenvironmentImage: urlenvironmentImage ?? this.urlenvironmentImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accommodation': accommodation,
      'statusresidenceother': statusresidenceother,
      'typeHouse': typeHouse,
      'housetypeother': housetypeother,
      'typeHomeEnvironment': typeHomeEnvironment,
      'homeienvironment': homeienvironment,
      'typeHousingSafety': typeHousingSafety,
      'housingSafety': housingSafety,
      'typefacilities': typefacilities,
      'facilities': facilities,
      'urlenvironmentImage': urlenvironmentImage,
    };
  }

  factory EnvironmentModel.fromMap(Map<String, dynamic> map) {
    return EnvironmentModel(
      accommodation: map['accommodation'],
      statusresidenceother: map['statusresidenceother'],
      typeHouse: map['typeHouse'],
      housetypeother: map['housetypeother'],
      typeHomeEnvironment: map['typeHomeEnvironment'],
      homeienvironment: map['homeienvironment'],
      typeHousingSafety: map['typeHousingSafety'],
      housingSafety: map['housingSafety'],
      typefacilities: map['typefacilities'],
      facilities: map['facilities'],
      urlenvironmentImage: map['urlenvironmentImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnvironmentModel.fromJson(String source) =>
      EnvironmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnvironmentModel(accommodation: $accommodation, statusresidenceother: $statusresidenceother, typeHouse: $typeHouse, housetypeother: $housetypeother, typeHomeEnvironment: $typeHomeEnvironment, homeienvironment: $homeienvironment, typeHousingSafety: $typeHousingSafety, housingSafety: $housingSafety, typefacilities: $typefacilities, facilities: $facilities, urlenvironmentImage: $urlenvironmentImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnvironmentModel &&
        other.accommodation == accommodation &&
        other.statusresidenceother == statusresidenceother &&
        other.typeHouse == typeHouse &&
        other.housetypeother == housetypeother &&
        other.typeHomeEnvironment == typeHomeEnvironment &&
        other.homeienvironment == homeienvironment &&
        other.typeHousingSafety == typeHousingSafety &&
        other.housingSafety == housingSafety &&
        other.typefacilities == typefacilities &&
        other.facilities == facilities &&
        other.urlenvironmentImage == urlenvironmentImage;
  }

  @override
  int get hashCode {
    return accommodation.hashCode ^
        statusresidenceother.hashCode ^
        typeHouse.hashCode ^
        housetypeother.hashCode ^
        typeHomeEnvironment.hashCode ^
        homeienvironment.hashCode ^
        typeHousingSafety.hashCode ^
        housingSafety.hashCode ^
        typefacilities.hashCode ^
        facilities.hashCode ^
        urlenvironmentImage.hashCode;
  }
}
