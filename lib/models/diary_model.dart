import 'dart:convert';

enum DonViEnum {
  tan('tan'),
  ta('ta'),
  yen('yen'),
  kg('kg'),
  empty('');

  const DonViEnum(this.type);
  final String type;
}

extension ConvertCall on String {
  DonViEnum toEnum() {
    switch (this) {
      case 'tan':
        return DonViEnum.tan;
      case 'ta':
        return DonViEnum.ta;
      case 'yen':
        return DonViEnum.yen;
      case 'kg':
        return DonViEnum.kg;
      default:
        return DonViEnum.empty;
    }
  }
}

class DiaryModel {
  final String Oid;
  final DateTime? NgayBatDau;
  final DateTime? NgayNuoiTrong;
  final DateTime? NgayThuHoach;
  final DateTime? NgayKetThuc;
  final String? TenNhatKy;
  final String? DatCoSo;
  final String? Nam;
  final String? TrangThai;
  final String? SanLuong;
  final DonViEnum? DonViSanLuong;
  final String? GhiChu;

  DiaryModel({
    required this.Oid,
    this.NgayBatDau,
    this.NgayNuoiTrong,
    this.NgayThuHoach,
    this.NgayKetThuc,
    this.TenNhatKy,
    this.DatCoSo,
    this.Nam,
    this.TrangThai,
    this.SanLuong,
    this.DonViSanLuong,
    this.GhiChu,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'NgayBatDau': NgayBatDau?.toString(),
      'NgayNuoiTrong': NgayNuoiTrong?.toString(),
      'NgayThuHoach': NgayThuHoach?.toString(),
      'NgayKetThuc': NgayKetThuc?.toString(),
      'TenNhatKy': TenNhatKy,
      'DatCoSo': DatCoSo,
      'Nam': Nam,
      'TrangThai': TrangThai,
      'SanLuong': SanLuong,
      'DonViSanLuong': DonViSanLuong?.type,
      'GhiChu': GhiChu,
    };
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
      Oid: map['Oid'] as String,
      NgayBatDau: map['NgayBatDau'] != null ? DateTime.parse(map['NgayBatDau'] as String) : null,
      NgayNuoiTrong: map['NgayNuoiTrong'] != null ? DateTime.parse(map['NgayNuoiTrong'] as String) : null,
      NgayThuHoach: map['NgayThuHoach'] != null ? DateTime.parse(map['NgayThuHoach'] as String) : null,
      NgayKetThuc: map['NgayKetThuc'] != null ? DateTime.parse(map['NgayKetThuc'] as String) : null,
      TenNhatKy: map['TenNhatKy'] != null ? map['TenNhatKy'] as String : null,
      DatCoSo: map['DatCoSo'] != null ? map['DatCoSo'] as String : null,
      Nam: map['Nam'] != null ? map['Nam'] as String : null,
      TrangThai: map['TrangThai'] != null ? map['TrangThai'] as String : null,
      SanLuong: map['SanLuong'] != null ? map['SanLuong'] as String : null,
      DonViSanLuong: map['DonViSanLuong'] != null ? (map['DonViSanLuong'] as String).toEnum() : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryModel.fromJson(String source) => DiaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String getSanLuong() {
    return "$SanLuong ${donViToString()}";
  }

  String donViToString() {
    switch (DonViSanLuong) {
      case DonViEnum.tan:
        return 'Tấn';
      case DonViEnum.ta:
        return 'Tạ';
      case DonViEnum.yen:
        return 'yến';
      case DonViEnum.kg:
        return 'Kg';
      default:
        return '';
    }
  }
}
