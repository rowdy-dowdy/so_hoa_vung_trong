// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class UserModel {
  final String Oid;
  final String? Ten;
  final int? SoThanhVien;
  final String? DiaChi;
  final String? SDT;
  final String? DiaChiEmail;
  final Uint8List? Avatar;
  
  UserModel({
    required this.Oid,
    this.Ten,
    this.SoThanhVien,
    this.DiaChi,
    this.SDT,
    this.DiaChiEmail,
    this.Avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Oid': Oid,
      'Ten': Ten,
      'SoThanhVien': SoThanhVien,
      'DiaChi': DiaChi,
      'SDT': SDT,
      'DiaChiEmail': DiaChiEmail,
      'Avatar': Avatar != null ? base64Encode(Avatar!) : null,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Oid: map['Oid'] as String,
      Ten: map['Ten'] != null ? map['Ten'] as String : null,
      SoThanhVien: map['SoThanhVien'] != null ? map['SoThanhVien'] as int : null,
      DiaChi: map['DiaChi'] != null ? map['DiaChi'] as String : null,
      SDT: map['SDT'] != null ? map['SDT'] as String : null,
      DiaChiEmail: map['DiaChiEmail'] != null ? map['DiaChiEmail'] as String : null,
      Avatar: map['Avatar'] != null ? base64Decode(map['Avatar'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
