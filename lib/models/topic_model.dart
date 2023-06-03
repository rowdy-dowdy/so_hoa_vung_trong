// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:so_hoa_vung_trong/models/comment_model.dart';
import 'package:so_hoa_vung_trong/models/topic_category_model.dart';
import 'package:so_hoa_vung_trong/models/user_model.dart';

class TopicModel {
  final String Oid;
  final String? TieuDe;
  final String? NoiDung;
  final bool? TrangThai;
  final DateTime? NgayTao;
  final DateTime? NgaySua;
  final Uint8List? File;
  final TopicCategoryModel? DanhMucChuDe;
  final UserModel? NguoiTao;
  List<CommentModel> HoiThoais;

  TopicModel({
    required this.Oid,
    this.TieuDe,
    this.NoiDung,
    this.TrangThai,
    this.NgayTao,
    this.NgaySua,
    this.File,
    this.DanhMucChuDe,
    this.NguoiTao,
    required this.HoiThoais,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TieuDe': TieuDe,
      'NoiDung': NoiDung,
      'TrangThai': TrangThai,
      'NgayTao': NgayTao?.toString(),
      'NgaySua': NgaySua?.toString(),
      'File': File?.toString(),
      'DanhMucChuDe': DanhMucChuDe?.toMap(),
      'NguoiTao': NguoiTao?.toMap(),
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      Oid: map['Oid'] as String,
      TieuDe: map['TieuDe'] != null ? map['TieuDe'] as String : null,
      NoiDung: map['NoiDung'] != null ? map['NoiDung'] as String : null,
      TrangThai: map['TrangThai'] != null ? map['TrangThai'] as bool : null,
      NgayTao: map['NgayTao'] != null ? DateTime.parse(map['NgayTao'] as String) : null,
      NgaySua: map['NgaySua'] != null ? DateTime.parse(map['NgaySua'] as String) : null,
      File: map['File'] != null ? base64Decode(map['File'] as String) : null,
      DanhMucChuDe: map['DanhMucChuDe'] != null ? TopicCategoryModel.fromMap(map['DanhMucChuDe'] as Map<String,dynamic>) : null,
      NguoiTao: map['NguoiTao'] != null ? UserModel.fromMap(map['NguoiTao'] as Map<String,dynamic>) : null,
      HoiThoais: List<CommentModel>.from((map['HoiThoais'] as List<dynamic>).map<CommentModel>((x) => CommentModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicModel.fromJson(String source) => TopicModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
