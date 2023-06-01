import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TopicCategoryModel {
  final String Oid;
  final String? TenDanhMuc;
  final String? MoTa;
  
  TopicCategoryModel({
    required this.Oid,
    this.TenDanhMuc,
    this.MoTa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'TenDanhMuc': TenDanhMuc,
      'MoTa': MoTa,
    };
  }

  factory TopicCategoryModel.fromMap(Map<String, dynamic> map) {
    return TopicCategoryModel(
      Oid: map['Oid'] as String,
      TenDanhMuc: map['TenDanhMuc'] != null ? map['TenDanhMuc'] as String : null,
      MoTa: map['MoTa'] != null ? map['MoTa'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicCategoryModel.fromJson(String source) => TopicCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
