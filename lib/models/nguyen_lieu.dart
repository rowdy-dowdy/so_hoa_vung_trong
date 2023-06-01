// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class NguyenLieuModel {
  final String Oid;
  final String? TenNguyenLieu;
  final int? Gia;
  final String? DonGia;
  final String? GhiChu;
  final Uint8List? HinhAnh;
  
  NguyenLieuModel({
    required this.Oid,
    this.TenNguyenLieu,
    this.Gia,
    this.DonGia,
    this.GhiChu,
    this.HinhAnh,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenNguyenLieu': TenNguyenLieu,
      'Gia': Gia,
      'DonGia': DonGia,
      'GhiChu': GhiChu,
      'HinhAnh': HinhAnh?.toString(),
    };
  }

  factory NguyenLieuModel.fromMap(Map<String, dynamic> map) {
    return NguyenLieuModel(
      Oid: map['Oid'] as String,
      TenNguyenLieu: map['TenNguyenLieu'] != null ? map['TenNguyenLieu'] as String : null,
      Gia: map['Gia'] != null ? map['Gia'] as int : null,
      DonGia: map['DonGia'] != null ? map['DonGia'] as String : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      HinhAnh: map['HinhAnh'] != null ? base64Decode(map['HinhAnh'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NguyenLieuModel.fromJson(String source) => NguyenLieuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
