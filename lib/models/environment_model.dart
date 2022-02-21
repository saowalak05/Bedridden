import 'dart:convert';

class EnvironmentModel {
  final String accommodation;
  final String typeHouse;
  final String typeHomeEnvironment;
  final String typeHousingSafety;
  final String typefacilities;
  final String urlenvironmentImage;
  EnvironmentModel({
    required this.accommodation,
    required this.typeHouse,
    required this.typeHomeEnvironment,
    required this.typeHousingSafety,
    required this.typefacilities,
    required this.urlenvironmentImage,
  });

  EnvironmentModel copyWith({
    String? accommodation,
    String? typeHouse,
    String? typeHomeEnvironment,
    String? typeHousingSafety,
    String? typefacilities,
    String? urlenvironmentImage,
  }) {
    return EnvironmentModel(
      accommodation: accommodation ?? this.accommodation,
      typeHouse: typeHouse ?? this.typeHouse,
      typeHomeEnvironment: typeHomeEnvironment ?? this.typeHomeEnvironment,
      typeHousingSafety: typeHousingSafety ?? this.typeHousingSafety,
      typefacilities: typefacilities ?? this.typefacilities,
      urlenvironmentImage: urlenvironmentImage ?? this.urlenvironmentImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accommodation': accommodation,
      'typeHouse': typeHouse,
      'typeHomeEnvironment': typeHomeEnvironment,
      'typeHousingSafety': typeHousingSafety,
      'typefacilities': typefacilities,
      'urlenvironmentImage': urlenvironmentImage,
    };
  }

  factory EnvironmentModel.fromMap(Map<String, dynamic> map) {
    return EnvironmentModel(
      accommodation: map['accommodation'],
      typeHouse: map['typeHouse'],
      typeHomeEnvironment: map['typeHomeEnvironment'],
      typeHousingSafety: map['typeHousingSafety'],
      typefacilities: map['typefacilities'],
      urlenvironmentImage: map['urlenvironmentImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnvironmentModel.fromJson(String source) =>
      EnvironmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnvironmentModel(accommodation: $accommodation, typeHouse: $typeHouse, typeHomeEnvironment: $typeHomeEnvironment, typeHousingSafety: $typeHousingSafety,  typefacilities: $typefacilities,  urlenvironmentImage: $urlenvironmentImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnvironmentModel &&
        other.accommodation == accommodation &&
        other.typeHouse == typeHouse &&
        other.typeHomeEnvironment == typeHomeEnvironment &&
        other.typeHousingSafety == typeHousingSafety &&
        other.typefacilities == typefacilities &&
        other.urlenvironmentImage == urlenvironmentImage;
  }

  @override
  int get hashCode {
    return accommodation.hashCode ^
        typeHouse.hashCode ^
        typeHomeEnvironment.hashCode ^
        typeHousingSafety.hashCode ^
        typefacilities.hashCode ^
        urlenvironmentImage.hashCode;
  }
}
