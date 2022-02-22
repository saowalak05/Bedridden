import 'dart:convert';

class FamilyModel {
  final String familynameone;
  final String familynametwo;
  final String familynamethree;
  final String familyrelationshipone;
  final String familyrelationshiptwo;
  final String familyrelationshipthree;
  final String occupationone;
  final String occupationtwo;
  final String occupationthree;

  FamilyModel({
    required this.familynameone,
    required this.familynametwo,
    required this.familynamethree,
    required this.familyrelationshipone,
    required this.familyrelationshiptwo,
    required this.familyrelationshipthree,
    required this.occupationone,
    required this.occupationtwo,
    required this.occupationthree,
  });

  FamilyModel copyWith({
    String? familynameone,
    String? familynametwo,
    String? familynamethree,
    String? familyrelationshipone,
    String? familyrelationshiptwo,
    String? familyrelationshipthree,
    String? occupationone,
    String? occupationtwo,
    String? occupationthree,
  }) {
    return FamilyModel(
      familynameone: familynameone ?? this.familynameone,
      familynametwo: familynametwo ?? this.familynametwo,
      familynamethree: familynamethree ?? this.familynamethree,
      familyrelationshipone:
          familyrelationshipone ?? this.familyrelationshipone,
      familyrelationshiptwo:
          familyrelationshiptwo ?? this.familyrelationshiptwo,
      familyrelationshipthree:
          familyrelationshipthree ?? this.familyrelationshipthree,
      occupationone: occupationone ?? this.occupationone,
      occupationtwo: occupationtwo ?? this.occupationtwo,
      occupationthree: occupationthree ?? this.occupationthree,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'familynameone': familynameone,
      'familynametwo': familynametwo,
      'familynamethree': familynamethree,
      'familyrelationshipone': familyrelationshipone,
      'familyrelationshiptwo': familyrelationshiptwo,
      'familyrelationshipthree': familyrelationshipthree,
      'occupationone': occupationone,
      'occupationtwo': occupationtwo,
      'occupationthree': occupationthree,
    };
  }

  factory FamilyModel.fromMap(Map<String, dynamic> map) {
    return FamilyModel(
      familynameone: map['familynameone'],
      familynametwo: map['familynametwo'],
      familynamethree: map['familynamethree'],
      familyrelationshipone: map['familyrelationshipone'],
      familyrelationshiptwo: map['familyrelationshiptwo'],
      familyrelationshipthree: map['familyrelationshipthree'],
      occupationone: map['occupationone'],
      occupationtwo: map['occupationtwo'],
      occupationthree: map['occupationthree'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyModel.fromJson(String source) =>
      FamilyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FamilyModel(familynameone: $familynameone, familynametwo: $familynametwo, familynamethree: $familynamethree, familyrelationshipone: $familyrelationshipone, familyrelationshiptwo: $familyrelationshiptwo, familyrelationshipthree: $familyrelationshipthree, occupationone: $occupationone, occupationtwo: $occupationtwo, occupationthree: $occupationthree,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FamilyModel &&
        other.familynameone == familynameone &&
        other.familynametwo == familynametwo &&
        other.familynamethree == familynamethree &&
        other.familyrelationshipone == familyrelationshipone &&
        other.familyrelationshiptwo == familyrelationshiptwo &&
        other.familyrelationshipthree == familyrelationshipthree &&
        other.occupationone == occupationone &&
        other.occupationtwo == occupationtwo &&
        other.occupationthree == occupationthree;
  }

  @override
  int get hashCode {
    return familynameone.hashCode ^
        familynametwo.hashCode ^
        familynamethree.hashCode ^
        familyrelationshipone.hashCode ^
        familyrelationshiptwo.hashCode ^
        familyrelationshipthree.hashCode ^
        occupationone.hashCode ^
        occupationtwo.hashCode ^
        occupationthree.hashCode;
  }
}
