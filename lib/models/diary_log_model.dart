import 'dart:convert';

import 'package:so_hoa_vung_trong/utils/utils.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DiaryLogModel {
  final String Oid;
  final DateTime? ThoiGianBatDau;
  final DateTime? ThoiGianKetThuc;
  final String? GhiChu;
  final double? TongGioLamViec;
  final String? NhieuLieuTieuThu;
  final String? SanLuong;
  final String? TacNhanGayHai;
  
  DiaryLogModel({
    required this.Oid,
    this.ThoiGianBatDau,
    this.ThoiGianKetThuc,
    this.GhiChu,
    this.TongGioLamViec,
    this.NhieuLieuTieuThu,
    this.SanLuong,
    this.TacNhanGayHai,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'ThoiGianBatDau': ThoiGianBatDau?.toString(),
      'ThoiGianKetThuc': ThoiGianKetThuc?.toString(),
      'GhiChu': GhiChu,
      'TongGioLamViec': TongGioLamViec.toString(),
      'NhieuLieuTieuThu': NhieuLieuTieuThu,
      'SanLuong': SanLuong,
      'TacNhanGayHai': TacNhanGayHai,
    };
  }

  factory DiaryLogModel.fromMap(Map<String, dynamic> map) {
    return DiaryLogModel(
      Oid: map['Oid'] as String,
      ThoiGianBatDau: map['ThoiGianBatDau'] != null ? DateTime.parse(map['ThoiGianBatDau'] as String) : null,
      ThoiGianKetThuc: map['ThoiGianKetThuc'] != null ? DateTime.parse(map['ThoiGianKetThuc'] as String) : null,
      GhiChu: map['GhiChu'] != null ? map['GhiChu'] as String : null,
      TongGioLamViec: map['TongGioLamViec'] != null ? map['TongGioLamViec'] as double : null,
      NhieuLieuTieuThu: map['NhieuLieuTieuThu'] != null ? map['NhieuLieuTieuThu'] as String : null,
      SanLuong: map['SanLuong'] != null ? map['SanLuong'] as String : null,
      TacNhanGayHai: map['TacNhanGayHai'] != null ? map['TacNhanGayHai'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryLogModel.fromJson(String source) => DiaryLogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String dateToString() {
    return "${formatTimeToString2(ThoiGianBatDau)} - ${formatTimeToString2(ThoiGianKetThuc)}";
  }
}
