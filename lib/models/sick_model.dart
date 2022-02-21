import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SickModel {
  final String address;
  final Timestamp bond;
  final String idCard;
  final String name;
  final String phone;
  final String typeSex;
  final String typeStatus;
  final String urlImage;
  final String level;
  final String typeeducationlevel;
  final String typeposition;
  final String patientoccupation;
  final String talent;
  final String race;
  final String nationality;
  final String religion;
  final double lat;
  final double lng;

  SickModel({
    required this.address,
    required this.bond,
    required this.idCard,
    required this.name,
    required this.phone,
    required this.typeSex,
    required this.typeStatus,
    required this.urlImage,
    required this.level,
    required this.typeeducationlevel,
    required this.typeposition,
    required this.patientoccupation,
    required this.talent,
    required this.race,
    required this.nationality,
    required this.religion,
    required this.lat,
    required this.lng,
  });

  SickModel copyWith({
    String? address,
    Timestamp? bond,
    String? idCard,
    String? name,
    String? phone,
    String? typeSex,
    String? typeStatus,
    String? urlImage,
    String? level,
    String? typeeducationlevel,
    String? typeposition,
    String? patientoccupation,
    String? talent,
    String? race,
    String? nationality,
    String? religion,
    double? lat,
    double? lng,
  }) {
    return SickModel(
      address: address ?? this.address,
      bond: bond ?? this.bond,
      idCard: idCard ?? this.idCard,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      typeSex: typeSex ?? this.typeSex,
      typeStatus: typeStatus ?? this.typeStatus,
      urlImage: urlImage ?? this.urlImage,
      level: level ?? this.level,
      typeeducationlevel: typeeducationlevel ?? this.typeeducationlevel,
      typeposition: typeposition ?? this.typeposition,
      patientoccupation: patientoccupation ?? this.patientoccupation,
      talent: talent ?? this.talent,
      race: race ?? this.race,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'bond': bond,
      'idCard': idCard,
      'name': name,
      'phone': phone,
      'typeSex': typeSex,
      'typeStatus': typeStatus,
      'urlImage': urlImage,
      'level': level,
      'typeeducation_level': typeeducationlevel,
      'typeposition': typeposition,
      'patientoccupation': patientoccupation,
      'talent': talent,
      'race': race,
      'nationality': nationality,
      'religion': religion,
      'lat': lat,
      'lng': lng,
    };
  }

  factory SickModel.fromMap(Map<String, dynamic> map) {
    return SickModel(
      address: map['address'],
      bond: map['bond'],
      idCard: map['idCard'],
      name: map['name'],
      phone: map['phone'],
      typeSex: map['typeSex'],
      typeStatus: map['typeStatus'],
      urlImage: map['urlImage'],
      level: map['level'],
      typeeducationlevel: map['typeeducation_level'] ?? '',
      typeposition: map['typeposition'] ?? '',
      patientoccupation: map['patientoccupation'] ?? '',
      talent: map['talent'] ?? '',
      race: map['race'] ?? '',
      nationality: map['nationality'] ?? '',
      religion: map['religion'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SickModel.fromJson(String source) =>
      SickModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SickModel(address: $address, bond: $bond, idCard: $idCard, name: $name, phone: $phone, typeSex: $typeSex, typeStatus: $typeStatus, urlImage: $urlImage, level: $level, typeeducation_level: $typeeducationlevel, typeposition: $typeposition, patientoccupation: $patientoccupation, talent: $talent, race: $race, nationality: $nationality, religion: $religion, lat: $lng, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SickModel &&
        other.address == address &&
        other.bond == bond &&
        other.idCard == idCard &&
        other.name == name &&
        other.phone == phone &&
        other.typeSex == typeSex &&
        other.typeStatus == typeStatus &&
        other.urlImage == urlImage &&
        other.level == level &&
        other.typeeducationlevel == typeeducationlevel &&
        other.typeposition == typeposition &&
        other.patientoccupation == patientoccupation &&
        other.talent == talent &&
        other.race == race &&
        other.nationality == nationality &&
        other.religion == religion &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        bond.hashCode ^
        idCard.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        typeSex.hashCode ^
        typeStatus.hashCode ^
        urlImage.hashCode ^
        level.hashCode ^
        typeeducationlevel.hashCode ^
        typeposition.hashCode ^
        patientoccupation.hashCode ^
        talent.hashCode ^
        race.hashCode ^
        nationality.hashCode ^
        religion.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
