import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/diary_model.dart';
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
      Response response = await dio.get('/api/odata/NhatKyCanhTac($Oid)');

      print(response.data);

      DiaryModel data = DiaryModel.fromMap(response.data);

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