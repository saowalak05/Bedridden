import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HealthModel {
  final String disease;
  final String medicine;
  final String inspectionresults;
  final String druguse;
  final String correct;
  final String otherdrugs;
  final String herb;
  final String foodsupplement;
  final String groupA;
  final String groupB;
  HealthModel({
    required this.disease,
    required this.medicine,
    required this.inspectionresults,
    required this.druguse,
    required this.correct,
    required this.otherdrugs,
    required this.herb,
    required this.foodsupplement,
    required this.groupA,
    required this.groupB,
  });
 

  HealthModel copyWith({
    String? disease,
    String? medicine,
    String? inspectionresults,
    String? druguse,
    String? correct,
    String? otherdrugs,
    String? herb,
    String? foodsupplement,
    String? groupA,
    String? groupB,
  }) {
    return HealthModel(
      disease: disease ?? this.disease,
      medicine: medicine ?? this.medicine,
      inspectionresults: inspectionresults ?? this.inspectionresults,
      druguse: druguse ?? this.druguse,
      correct: correct ?? this.correct,
      otherdrugs: otherdrugs ?? this.otherdrugs,
      herb: herb ?? this.herb,
      foodsupplement: foodsupplement ?? this.foodsupplement,
      groupA: groupA ?? this.groupA,
      groupB: groupB ?? this.groupB,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'disease': disease,
      'medicine': medicine,
      'inspectionresults': inspectionresults,
      'druguse': druguse,
      'correct': correct,
      'otherdrugs': otherdrugs,
      'herb': herb,
      'foodsupplement': foodsupplement,
      'groupA': groupA,
      'groupB': groupB,
    };
  }

  factory HealthModel.fromMap(Map<String, dynamic> map) {
    return HealthModel(
      disease: map['disease'],
      medicine: map['medicine'],
      inspectionresults: map['inspectionresults'],
      druguse: map['druguse'],
      correct: map['correct'],
      otherdrugs: map['otherdrugs'],
      herb: map['herb'],
      foodsupplement: map['foodsupplement'],
      groupA: map['groupA'],
      groupB: map['groupB'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthModel.fromJson(String source) => HealthModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HealthModel(disease: $disease, medicine: $medicine, inspectionresults: $inspectionresults, druguse: $druguse, correct: $correct, otherdrugs: $otherdrugs, herb: $herb, foodsupplement: $foodsupplement, groupA: $groupA, groupB: $groupB)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HealthModel &&
      other.disease == disease &&
      other.medicine == medicine &&
      other.inspectionresults == inspectionresults &&
      other.druguse == druguse &&
      other.correct == correct &&
      other.otherdrugs == otherdrugs &&
      other.herb == herb &&
      other.foodsupplement == foodsupplement &&
      other.groupA == groupA &&
      other.groupB == groupB;
  }

  @override
  int get hashCode {
    return disease.hashCode ^
      medicine.hashCode ^
      inspectionresults.hashCode ^
      druguse.hashCode ^
      correct.hashCode ^
      otherdrugs.hashCode ^
      herb.hashCode ^
      foodsupplement.hashCode ^
      groupA.hashCode ^
      groupB.hashCode;
  }
}
