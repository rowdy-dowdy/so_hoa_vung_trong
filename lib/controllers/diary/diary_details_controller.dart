// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/diary_log_model.dart';
import 'package:so_hoa_vung_trong/models/diary_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';

class DiaryDetailsDataModel {
  final bool loading;
  DiaryModel? data;
  DiaryDetailsDataModel({
    required this.loading,
    required this.data,
  });

  DiaryDetailsDataModel.unknown()
    : loading = false,
      data = null;
}

class DiaryNotifier extends StateNotifier<DiaryDetailsDataModel> {
  final Ref ref;
  final String Oid;
  DiaryNotifier(this.ref, this.Oid): super(DiaryDetailsDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = DiaryDetailsDataModel(loading: true, data: null);
    var data = await ref.read(mainRepositoryProvider).fetchDiaryById(Oid);
    state = DiaryDetailsDataModel(loading: false, data: data);
  }
}

final diaryDetailsControllerProvider = StateNotifierProvider.family<DiaryNotifier, DiaryDetailsDataModel, String>((ref, Oid) {
  return DiaryNotifier(ref, Oid);
});

final diaryLogProvider = FutureProvider.family<List<DiaryLogModel>, String>((ref, Oid) async {
  return ref.read(mainRepositoryProvider).fetchListDiaryLog(Oid);
});
