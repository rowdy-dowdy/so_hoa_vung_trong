// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:so_hoa_vung_trong/models/topic_category_model.dart';

class TopicModel {
  final String Oid;
  final String? TieuDe;
  final String? NoiDung;
  final bool? TrangThai;
  final DateTime? NgayTao;
  final DateTime? NgaySua;
  final Uint8List? File;
  final TopicCategoryModel? DanhMucChuDe;

  TopicModel({
    required this.Oid,
    this.TieuDe,
    this.NoiDung,
    this.TrangThai,
    this.NgayTao,
    this.NgaySua,
    this.File,
    this.DanhMucChuDe,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TieuDe': TieuDe,
      'NoiDung': NoiDung,
      'TrangThai': TrangThai,
      'NgayTao': NgayTao?.millisecondsSinceEpoch,
      'NgaySua': NgaySua?.millisecondsSinceEpoch,
      'File': File?.toString(),
      'DanhMucChuDe': DanhMucChuDe?.toMap(),
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      Oid: map['Oid'] as String,
      TieuDe: map['TieuDe'] != null ? map['TieuDe'] as String : null,
      NoiDung: map['NoiDung'] != null ? map['NoiDung'] as String : null,
      TrangThai: map['TrangThai'] != null ? map['TrangThai'] as bool : null,
      NgayTao: map['NgayTao'] != null ? DateTime.fromMillisecondsSinceEpoch(map['NgayTao'] as int) : null,
      NgaySua: map['NgaySua'] != null ? DateTime.fromMillisecondsSinceEpoch(map['NgaySua'] as int) : null,
      File: map['File'] != null ? base64Decode(map['File'] as String) : null,
      DanhMucChuDe: map['DanhMucChuDe'] != null ? TopicCategoryModel.fromMap(map['DanhMucChuDe'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicModel.fromJson(String source) => TopicModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
