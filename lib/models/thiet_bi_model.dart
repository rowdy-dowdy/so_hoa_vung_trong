// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class ThietBiModel {
  final String Oid;
  final DateTime? ThoiHanSuDung;
  final String? TenThietBi;
  final String? HuongDanSuDung;
  final String? GhiChu;
  final Uint8List? HinhAnh;
  
  ThietBiModel({
    required this.Oid,
    this.ThoiHanSuDung,
    this.TenThietBi,
    this.HuongDanSuDung,
    this.GhiChu,
    this.HinhAnh,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'ThoiHanSuDung': ThoiHanSuDung?.toString(),
      'TenThietBi': TenThietBi,
      'HuongDanSuDung': HuongDanSuDung,
      'GhiChu': GhiChu,
      'HinhAnh': HinhAnh?.toString(),
    };
  }

  factory ThietBiModel.fromMap(Map<String, dynamic> map) {
    return ThietBiModel(
      Oid: map['Oid'] as String,
      ThoiHanSuDung: map['ThoiHanSuDung'] != null ? DateTime.parse(map['ThoiHanSuDung'] as String) : null,
      TenThietBi: map['TenThietBi'] != null ? map['TenThietBi'] as String : null,
      HuongDanSuDung: map['HuongDanSuDung'] != null ? map['HuongDanSuDung'] as String : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      HinhAnh: map['HinhAnh'] != null ? base64Decode(map['HinhAnh'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThietBiModel.fromJson(String source) => ThietBiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
