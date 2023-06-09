import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/models/comment_model.dart';
import 'package:so_hoa_vung_trong/models/congviec_model.dart';
import 'package:so_hoa_vung_trong/models/dat_model.dart';
import 'package:so_hoa_vung_trong/models/diary_log_model.dart';
import 'package:so_hoa_vung_trong/models/diary_model.dart';
import 'package:so_hoa_vung_trong/models/nguyen_lieu.dart';
import 'package:so_hoa_vung_trong/models/phan_bon_model.dart';
import 'package:so_hoa_vung_trong/models/thiet_bi_model.dart';
import 'package:so_hoa_vung_trong/models/thuoc_model.dart';
import 'package:so_hoa_vung_trong/models/topic_category_model.dart';
import 'package:so_hoa_vung_trong/models/topic_model.dart';
import 'package:so_hoa_vung_trong/services/dio.dart';


class MainRepository {
  final Ref ref;
  final Dio dio;

  MainRepository({
    required this.ref,
    required this.dio,
  });

  Future<List<DiaryModel>> fetchListDiary() async {
    try {
      Response response = await dio.get('/api/odata/NhatKyCanhTac');

      List<DiaryModel> data = List<DiaryModel>.from((response.data['value'] as List<dynamic>).map<DiaryModel>((x) => DiaryModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<DiaryModel?> fetchDiaryById(String Oid) async {
    try {
      Response response = await dio.get('/api/odata/NhatKyCanhTac/$Oid?\$expand=Dat_CoSos');

      DiaryModel data = DiaryModel.fromMap(response.data);

      return data;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<DiaryLogModel>> fetchListDiaryLog(String Oid) async {
    try {
      Response response = await dio.get('/api/odata/NhatKyCanhTac/$Oid/ChiTietNhatKys/\$ref');

      List<DiaryLogModel> data = List<DiaryLogModel>.from((response.data['value'] as List<dynamic>).map<DiaryLogModel>((x) => DiaryLogModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<NguyenLieuModel>> fetchListNguyenLieu() async {
    try {
      Response response = await dio.get('/api/odata/NguyenLieu');

      List<NguyenLieuModel> data = List<NguyenLieuModel>.from((response.data['value'] as List<dynamic>).map<NguyenLieuModel>((x) => NguyenLieuModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<PhanBonModel>> fetchListPhanBon() async {
    try {
      Response response = await dio.get('/api/odata/PhanBon');

      List<PhanBonModel> data = List<PhanBonModel>.from((response.data['value'] as List<dynamic>).map<PhanBonModel>((x) => PhanBonModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ThietBiModel>> fetchListThietBi() async {
    try {
      Response response = await dio.get('/api/odata/ThieuBiMayMoc');

      List<ThietBiModel> data = List<ThietBiModel>.from((response.data['value'] as List<dynamic>).map<ThietBiModel>((x) => ThietBiModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ThuocModel>> fetchListThuoc() async {
    try {
      Response response = await dio.get('/api/odata/ThuocBVTV');

      List<ThuocModel> data = List<ThuocModel>.from((response.data['value'] as List<dynamic>).map<ThuocModel>((x) => ThuocModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<DatModel>> fetchListDat() async {
    try {
      Response response = await dio.get('/api/odata/Dat_CoSo');

      List<DatModel> data = List<DatModel>.from((response.data['value'] as List<dynamic>).map<DatModel>((x) => DatModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CongViecModel>> fetchListCongViec() async {
    try {
      Response response = await dio.get('/api/odata/CongViec_TinhTrang');

      List<CongViecModel> data = List<CongViecModel>.from((response.data['value'] as List<dynamic>).map<CongViecModel>((x) => CongViecModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TopicModel>> fetchTopic({int page = 1, int perPage = 8, String search = '', List<String> categories = const []}) async {
    try {
      var skip = (page - 1) * perPage;
      var take = perPage;

      String filter = "";

      categories.asMap().forEach((index, element) {
        if (index > 0) {
          filter += " or ";
        }
        filter += "DanhMucChuDe/Oid eq $element";
      });

      if (categories.isNotEmpty) {
        filter = "($filter) and ";
      }

      filter += 'contains(tolower(TieuDe), tolower(\'$search\'))';
      
      var uri = Uri(path: '/api/odata/Ticket', queryParameters: {
        '\$expand': 'DanhMucChuDe,NguoiTao',
        '\$filter': filter,
        '\$skip': "$skip",
        '\$top': "$take",
        '\$orderby': 'Oid'
      });

      Response response = await dio.get(uri.toString());

      // print(response.data);

      List<TopicModel> data = List<TopicModel>.from((response.data['value'] as List<dynamic>).map<TopicModel>((x) => TopicModel.fromMap(x as Map<String,dynamic>),),);

      print(data);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TopicCategoryModel>> fetchTopicCategories([int page = 1, String search = '']) async {
    try {
      Response response = await dio.get('/api/odata/DanhMucChuDe');

      List<TopicCategoryModel> data = List<TopicCategoryModel>.from((response.data['value'] as List<dynamic>).map<TopicCategoryModel>((x) => TopicCategoryModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CommentModel>> fetchComments({required String TopicOid}) async {
    try {
      var uri = Uri(path: '/api/odata/HoiThoai', queryParameters: {
        '\$expand': 'NguoiTao',
        '\$filter': 'Ticket/Oid eq $TopicOid',
      });

      Response response = await dio.get(uri.toString());

      List<CommentModel> data = List<CommentModel>.from((response.data['value'] as List<dynamic>).map<CommentModel>((x) => CommentModel.fromMap(x as Map<String,dynamic>),),);

      return data;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<CommentModel?> createComment({required String TopicOid, required String NoiDung}) async {
    try {
      final currentUser = ref.watch(authControllerProvider).user;
      if (currentUser == null) return null;

      var uri = Uri(path: '/api/odata/HoiThoai');

      Response response = await dio.post(uri.toString(), data: {
        "NoiDung": NoiDung,
        "NguoiTao": {
          "Oid": currentUser.Oid
        },
        "Ticket": {
          "Oid": TopicOid
        }
      });

      CommentModel data = CommentModel.fromMap({
        ...response.data,
        'NguoiTao': currentUser.toMap()
      });

      return data;

    } catch (e) {
      print(e);
      return null;
    }
  }
}

final mainRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MainRepository(ref: ref, dio: dio);
}); 