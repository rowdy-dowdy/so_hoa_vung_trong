// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class CommentModel {
  final String Oid;
  final DateTime? NgayTao;
  final String? NoiDung;
  final Uint8List? File;
  CommentModel({
    required this.Oid,
    this.NgayTao,
    this.NoiDung,
    this.File,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'NgayTao': NgayTao?.toString(),
      'NoiDung': NoiDung,
      'File': File?.toString(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      Oid: map['Oid'] as String,
      NgayTao: map['NgayTao'] != null ? DateTime.parse(map['NgayTao'] as String) : null,
      NoiDung: map['NoiDung'] != null ? map['NoiDung'] as String : null,
      File: map['File'] != null ? base64Decode(map['File'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
