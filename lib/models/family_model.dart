import 'dart:convert';

class FamilyModel {
  final String familynameone;
  final String familynametwo;
  final String familynamethree;
  final String familynamefour;

  final String familyrelationshipone;
  final String familyrelationshiptwo;
  final String familyrelationshipthree;
  final String familyrelationshipfour;

  final String occupationone;
  final String occupationtwo;
  final String occupationthree;
  final String occupationfour;

  FamilyModel({
    required this.familynameone,
    required this.familynametwo,
    required this.familynamethree,
    required this.familynamefour,
    required this.familyrelationshipone,
    required this.familyrelationshiptwo,
    required this.familyrelationshipthree,
    required this.familyrelationshipfour,
    required this.occupationone,
    required this.occupationtwo,
    required this.occupationthree,
    required this.occupationfour,
  });

  FamilyModel copyWith({
    String? familynameone,
    String? familynametwo,
    String? familynamethree,
    String? familynamefour,
    String? familyrelationshipone,
    String? familyrelationshiptwo,
    String? familyrelationshipthree,
    String? familyrelationshipfour,
    String? occupationone,
    String? occupationtwo,
    String? occupationthree,
    String? occupationfour,
  }) {
    return FamilyModel(
      familynameone: familynameone ?? this.familynameone,
      familynametwo: familynametwo ?? this.familynametwo,
      familynamethree: familynamethree ?? this.familynamethree,
      familynamefour: familynamefour ?? this.familynamefour,
      familyrelationshipone:
          familyrelationshipone ?? this.familyrelationshipone,
      familyrelationshiptwo:
          familyrelationshiptwo ?? this.familyrelationshiptwo,
      familyrelationshipthree:
          familyrelationshipthree ?? this.familyrelationshipthree,
      familyrelationshipfour:
          familyrelationshipfour ?? this.familyrelationshipfour,
      occupationone: occupationone ?? this.occupationone,
      occupationtwo: occupationtwo ?? this.occupationtwo,
      occupationthree: occupationthree ?? this.occupationthree,
      occupationfour: occupationfour ?? this.occupationfour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'familynameone': familynameone,
      'familynametwo': familynametwo,
      'familynamethree': familynamethree,
      'familynamefour': familynamefour,
      'familyrelationshipone': familyrelationshipone,
      'familyrelationshiptwo': familyrelationshiptwo,
      'familyrelationshipthree': familyrelationshipthree,
      'familyrelationshipfour': familyrelationshipfour,
      'occupationone': occupationone,
      'occupationtwo': occupationtwo,
      'occupationthree': occupationthree,
      'occupationfour': occupationfour,
    };
  }

  factory FamilyModel.fromMap(Map<String, dynamic> map) {
    return FamilyModel(
      familynameone: map['familynameone'],
      familynametwo: map['familynametwo'],
      familynamethree: map['familynamethree'],
      familynamefour: map['familynamefour'],
      familyrelationshipone: map['familyrelationshipone'],
      familyrelationshiptwo: map['familyrelationshiptwo'],
      familyrelationshipthree: map['familyrelationshipthree'],
      familyrelationshipfour: map['familyrelationshipfour'],
      occupationone: map['occupationone'],
      occupationtwo: map['occupationtwo'],
      occupationthree: map['occupationthree'],
      occupationfour: map['occupationtfour'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyModel.fromJson(String source) =>
      FamilyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FamilyModel(familynameone: $familynameone, familynametwo: $familynametwo, familynamethree: $familynamethree,familynamefour: $familynamefour, familyrelationshipone: $familyrelationshipone, familyrelationshiptwo: $familyrelationshiptwo, familyrelationshipthree: $familyrelationshipthree,  familyrelationshipfour: $familyrelationshipfour,occupationone: $occupationone, occupationtwo: $occupationtwo, occupationthree: $occupationthree,occupationfour: $occupationfour)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FamilyModel &&
        other.familynameone == familynameone &&
        other.familynametwo == familynametwo &&
        other.familynamethree == familynamethree &&
        other.familynamefour == familynamefour &&
        other.familyrelationshipone == familyrelationshipone &&
        other.familyrelationshiptwo == familyrelationshiptwo &&
        other.familyrelationshipthree == familyrelationshipthree &&
        other.familyrelationshipfour == familyrelationshipfour &&
        other.occupationone == occupationone &&
        other.occupationtwo == occupationtwo &&
        other.occupationthree == occupationthree&&
        other.occupationfour == occupationfour;
        
  }

  @override
  int get hashCode {
    return familynameone.hashCode ^
        familynametwo.hashCode ^
        familynamethree.hashCode ^
        familynamefour.hashCode ^
        familyrelationshipone.hashCode ^
        familyrelationshiptwo.hashCode ^
        familyrelationshipthree.hashCode ^
        familyrelationshipfour.hashCode ^
        occupationone.hashCode ^
        occupationtwo.hashCode ^
        occupationthree.hashCode^
        occupationfour.hashCode;
  }
}
