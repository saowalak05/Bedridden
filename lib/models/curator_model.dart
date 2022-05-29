import 'dart:convert';

class CuratorModel {
  final String curatorname;
  final String curatoraddress;

  CuratorModel({
    required this.curatorname,
    required this.curatoraddress,
  });

  CuratorModel copyWith({
    String? curatorname,
    String? curatoraddress,
  }) {
    return CuratorModel(
      curatorname: curatorname ?? this.curatorname,
      curatoraddress: curatoraddress ?? this.curatoraddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'curatorname': curatorname,
      'curatoraddress': curatoraddress,
    };
  }

  factory CuratorModel.fromMap(Map<String, dynamic> map) {
    return CuratorModel(
      curatorname: map['curatorname'],
      curatoraddress: map['curatoraddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CuratorModel.fromJson(String source) =>
      CuratorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CuratorModel(curatorname: $curatorname, curatoraddress: $curatoraddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CuratorModel &&
        other.curatorname == curatorname &&
        other.curatoraddress == curatoraddress;
  }

  @override
  int get hashCode {
    return curatorname.hashCode ^ curatoraddress.hashCode;
  }
}
