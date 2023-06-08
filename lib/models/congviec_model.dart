import 'dart:convert';

enum CongViecTTEnum {
  CongViec('CongViec'),
  TinhTrang('TinhTrang'),
  empty('');

  const CongViecTTEnum(this.type);
  final String type;
}

extension ConvertCall on String {
  CongViecTTEnum toCongViecTTEnum() {
    switch (this) {
      case 'CongViec':
        return CongViecTTEnum.CongViec;
      case 'TinhTrang':
        return CongViecTTEnum.TinhTrang;
      default:
        return CongViecTTEnum.empty;
    }
  }
}

class CongViecModel {
  final String Oid;
  final String? TenCongViec;
  final CongViecTTEnum? CongViec_TT;
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
      'CongViec_TT': CongViec_TT?.type,
      'ApDungTu': ApDungTu?.toString(),
      'ApDungDen': ApDungDen?.toString(),
    };
  }

  factory CongViecModel.fromMap(Map<String, dynamic> map) {
    return CongViecModel(
      Oid: map['Oid'] as String,
      TenCongViec: map['TenCongViec'] != null ? map['TenCongViec'] as String : null,
      CongViec_TT: map['CongViec_TT'] != null ? (map['CongViec_TT'] as String).toCongViecTTEnum() : null,
      ApDungTu: map['ApDungTu'] != null ? DateTime.parse(map['ApDungTu'] as String) : null,
      ApDungDen: map['ApDungDen'] != null ? DateTime.parse(map['ApDungDen'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CongViecModel.fromJson(String source) => CongViecModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

String congViecTTToString(CongViecTTEnum? CongViec_TT) {
  switch (CongViec_TT) {
    case CongViecTTEnum.CongViec:
      return 'Công việc';
    case CongViecTTEnum.TinhTrang:
      return 'Tình Trạng';
    default:
      return '';
  }
}