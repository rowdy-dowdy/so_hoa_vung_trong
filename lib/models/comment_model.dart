// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:so_hoa_vung_trong/models/user_model.dart';

class CommentModel {
  final String Oid;
  final DateTime? NgayTao;
  final String? NoiDung;
  final Uint8List? File;
  final UserModel? NguoiTao;
  
  CommentModel({
    required this.Oid,
    this.NgayTao,
    this.NoiDung,
    this.File,
    this.NguoiTao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'NgayTao': NgayTao?.toString(),
      'NoiDung': NoiDung,
      'File': File?.toString(),
      'NguoiTao': NguoiTao?.toMap(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      Oid: map['Oid'] as String,
      NgayTao: map['NgayTao'] != null ? DateTime.parse(map['NgayTao'] as String) : null,
      NoiDung: map['NoiDung'] != null ? map['NoiDung'] as String : null,
      File: map['File'] != null ? base64Decode(map['File'] as String) : null,
      NguoiTao: map['NguoiTao'] != null ? UserModel.fromMap(map['NguoiTao'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.Oid == Oid &&
      other.NgayTao == NgayTao &&
      other.NoiDung == NoiDung &&
      other.File == File &&
      other.NguoiTao == NguoiTao;
  }

  @override
  int get hashCode {
    return Oid.hashCode ^
      NgayTao.hashCode ^
      NoiDung.hashCode ^
      File.hashCode ^
      NguoiTao.hashCode;
  }
}
