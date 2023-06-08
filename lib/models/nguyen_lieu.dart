// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

enum DonGiaEnum {
  Cai('Cai'),
  m('m'),
  cm('cm'),
  kg('kg'),
  L('L'),
  ml('ml'),
  con('con'),
  baoBi('baoBi'),
  Vien('Vien'),
  Lieu('Lièu'),
  Hat('Hat'),
  Cay('Cay'),
  empty('');

  const DonGiaEnum(this.type);
  final String type;
}

extension ConvertCall on String {
  DonGiaEnum toDonGiaEnum() {
    switch (this) {
      case 'Cai':
        return DonGiaEnum.Cai;
      case 'm':
        return DonGiaEnum.m;
      case 'cm':
        return DonGiaEnum.cm;
      case 'kg':
        return DonGiaEnum.kg;
      case 'L':
        return DonGiaEnum.L;
      case 'ml':
        return DonGiaEnum.ml;
      case 'con':
        return DonGiaEnum.con;
      case 'baoBi':
        return DonGiaEnum.baoBi;
      case 'Vien':
        return DonGiaEnum.Vien;
      case 'Lièu':
        return DonGiaEnum.Lieu;
      case 'Hat':
        return DonGiaEnum.Hat;
      case 'Cay':
        return DonGiaEnum.Cay;
      default:
        return DonGiaEnum.empty;
    }
  }
}

class NguyenLieuModel {
  final String Oid;
  final String? TenNguyenLieu;
  final int? Gia;
  final DonGiaEnum? DonGia;
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
      'DonGia': DonGia?.type,
      'GhiChu': GhiChu,
      'HinhAnh': HinhAnh?.toString(),
    };
  }

  factory NguyenLieuModel.fromMap(Map<String, dynamic> map) {
    return NguyenLieuModel(
      Oid: map['Oid'] as String,
      TenNguyenLieu: map['TenNguyenLieu'] != null ? map['TenNguyenLieu'] as String : null,
      Gia: map['Gia'] != null ? map['Gia'] as int : null,
      DonGia: map['DonGia'] != null ? (map['DonGia'] as String).toDonGiaEnum() : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      HinhAnh: map['HinhAnh'] != null ? base64Decode(map['HinhAnh'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NguyenLieuModel.fromJson(String source) => NguyenLieuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

String donGiaToString(DonGiaEnum? DonViSanLuong) {
  switch (DonViSanLuong) {
      case DonGiaEnum.Cai:
        return 'Cái';
      case DonGiaEnum.m:
        return 'Mét';
      case DonGiaEnum.cm:
        return 'Centimet';
      case DonGiaEnum.kg:
        return 'Kilogram';
      case DonGiaEnum.L:
        return 'Lít';
      case DonGiaEnum.ml:
        return 'Mililit';
      case DonGiaEnum.con:
        return 'Con';
      case DonGiaEnum.baoBi:
        return 'Bao (Bì)';
      case DonGiaEnum.Vien:
        return 'Viên';
      case DonGiaEnum.Lieu:
        return 'Liều';
      case DonGiaEnum.Hat:
        return 'Hạt';
      case DonGiaEnum.Cay:
        return 'Cay';
      default:
        return '';
  }
}