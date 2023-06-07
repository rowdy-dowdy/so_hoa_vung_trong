import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CongViecModel {
  final String Oid;
  final String? TenCongViec;
  final String? CongViec_TT;
  final DateTime? ApDungTu;
  final DateTime? ApDungDen;
  
  CongViecModel({
    required this.Oid,
    this.TenCongViec,
    this.CongViec_TT,
    this.ApDungTu,
    this.ApDungDen,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenCongViec': TenCongViec,
      'CongViec_TT': CongViec_TT,
      'ApDungTu': ApDungTu?.toString(),
      'ApDungDen': ApDungDen?.toString(),
    };
  }

  factory CongViecModel.fromMap(Map<String, dynamic> map) {
    return CongViecModel(
      Oid: map['Oid'] as String,
      TenCongViec: map['TenCongViec'] != null ? map['TenCongViec'] as String : null,
      CongViec_TT: map['CongViec_TT'] != null ? map['CongViec_TT'] as String : null,
      ApDungTu: map['ApDungTu'] != null ? DateTime.parse(map['ApDungTu'] as String) : null,
      ApDungDen: map['ApDungDen'] != null ? DateTime.parse(map['ApDungDen'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CongViecModel.fromJson(String source) => CongViecModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
