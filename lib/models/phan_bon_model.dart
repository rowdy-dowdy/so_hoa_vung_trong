// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class PhanBonModel {
  final String Oid;
  final String? TenPhanBon;
  final int? Gia;
  final String? DonGia;
  final String? ThanhPhan;
  final String? LieuLuongSuDung;
  final String? NhaCungCap;
  final String? GhiChu;
  final Uint8List? HinhAnh;

  PhanBonModel({
    required this.Oid,
    this.TenPhanBon,
    this.Gia,
    this.DonGia,
    this.ThanhPhan,
    this.LieuLuongSuDung,
    this.NhaCungCap,
    this.GhiChu,
    this.HinhAnh,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenPhanBon': TenPhanBon,
      'Gia': Gia,
      'DonGia': DonGia,
      'ThanhPhan': ThanhPhan,
      'LieuLuongSuDung': LieuLuongSuDung,
      'NhaCungCap': NhaCungCap,
      'GhiChu': GhiChu,
      'HinhAnh': HinhAnh?.toString(),
    };
  }

  factory PhanBonModel.fromMap(Map<String, dynamic> map) {
    return PhanBonModel(
      Oid: map['Oid'] as String,
      TenPhanBon: map['TenPhanBon'] != null ? map['TenPhanBon'] as String : null,
      Gia: map['Gia'] != null ? map['Gia'] as int : null,
      DonGia: map['DonGia'] != null ? map['DonGia'] as String : null,
      ThanhPhan: map['ThanhPhan'] != null ? map['ThanhPhan'] as String : null,
      LieuLuongSuDung: map['LieuLuongSuDung'] != null ? map['LieuLuongSuDung'] as String : null,
      NhaCungCap: map['NhaCungCap'] != null ? map['NhaCungCap'] as String : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      HinhAnh: map['HinhAnh'] != null ? base64Decode(map['HinhAnh'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhanBonModel.fromJson(String source) => PhanBonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
