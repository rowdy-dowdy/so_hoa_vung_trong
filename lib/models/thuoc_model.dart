// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class ThuocModel {
  final String Oid;
  final String? TenThuoc;
  final int? Gia;
  final String? DonGia;
  final String? NongDoPhaLoang;
  final String? LieuLuongSuDung;
  final String? NhaCungCap;
  final String? GhiChu;
  final Uint8List? HinhAnh;

  ThuocModel({
    required this.Oid,
    this.TenThuoc,
    this.Gia,
    this.DonGia,
    this.NongDoPhaLoang,
    this.LieuLuongSuDung,
    this.NhaCungCap,
    this.GhiChu,
    this.HinhAnh,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenThuoc': TenThuoc,
      'Gia': Gia,
      'DonGia': DonGia,
      'NongDoPhaLoang': NongDoPhaLoang,
      'LieuLuongSuDung': LieuLuongSuDung,
      'NhaCungCap': NhaCungCap,
      'GhiChu': GhiChu,
      'HinhAnh': HinhAnh?.toString(),
    };
  }

  factory ThuocModel.fromMap(Map<String, dynamic> map) {
    return ThuocModel(
      Oid: map['Oid'] as String,
      TenThuoc: map['TenThuoc'] != null ? map['TenThuoc'] as String : null,
      Gia: map['Gia'] != null ? map['Gia'] as int : null,
      DonGia: map['DonGia'] != null ? map['DonGia'] as String : null,
      NongDoPhaLoang: map['NongDoPhaLoang'] != null ? map['NongDoPhaLoang'] as String : null,
      LieuLuongSuDung: map['LieuLuongSuDung'] != null ? map['LieuLuongSuDung'] as String : null,
      NhaCungCap: map['NhaCungCap'] != null ? map['NhaCungCap'] as String : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      HinhAnh: map['HinhAnh'] != null ? base64Decode(map['HinhAnh'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThuocModel.fromJson(String source) => ThuocModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
