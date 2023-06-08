import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum PhanLoaiDatEnum {
  soHuu('soHuu'),
  choThue('choThue'),
  empty('');

  const PhanLoaiDatEnum(this.type);
  final String type;
}

extension ConvertCall on String {
  PhanLoaiDatEnum toPhanLoaiDatEnum() {
    switch (this) {
      case 'soHuu':
        return PhanLoaiDatEnum.soHuu;
      case 'choThue':
        return PhanLoaiDatEnum.choThue;
      default:
        return PhanLoaiDatEnum.empty;
    }
  }
}

class DatModel {
  final String Oid;
  final String? TenDatCoSo;
  final String? SoDatCoSo;
  final int? DienTich;
  final String? DiaDiem;
  final String? GhiChu;
  final PhanLoaiDatEnum? PhanLoaiDat;

  DatModel({
    required this.Oid,
    this.TenDatCoSo,
    this.SoDatCoSo,
    this.DienTich,
    this.DiaDiem,
    this.GhiChu,
    this.PhanLoaiDat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenDatCoSo': TenDatCoSo,
      'SoDatCoSo': SoDatCoSo,
      'DienTich': DienTich,
      'DiaDiem': DiaDiem,
      'GhiChu': GhiChu,
      'PhanLoaiDat': PhanLoaiDat?.type,
    };
  }

  factory DatModel.fromMap(Map<String, dynamic> map) {
    return DatModel(
      Oid: map['Oid'] as String,
      TenDatCoSo: map['TenDatCoSo'] != null ? map['TenDatCoSo'] as String : null,
      SoDatCoSo: map['SoDatCoSo'] != null ? map['SoDatCoSo'] as String : null,
      DienTich: map['DienTich'] != null ? map['DienTich'] as int : null,
      DiaDiem: map['DiaDiem'] != null ? map['DiaDiem'] as String : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      PhanLoaiDat: map['PhanLoaiDat'] != null ? (map['PhanLoaiDat'] as String).toPhanLoaiDatEnum() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DatModel.fromJson(String source) => DatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

String donViSanLuongToString(PhanLoaiDatEnum? DonViSanLuong) {
  switch (DonViSanLuong) {
    case PhanLoaiDatEnum.soHuu:
      return 'Sở hữu';
    case PhanLoaiDatEnum.choThue:
      return 'Cho thuê';
    default:
      return '';
  }
}