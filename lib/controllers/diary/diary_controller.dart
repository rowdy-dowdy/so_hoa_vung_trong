// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/diary_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';

class DiaryDataModel {
  final bool loading;
  List<DiaryModel> data;
  DiaryDataModel({
    required this.loading,
    required this.data,
  });

  DiaryDataModel.unknown()
    : loading = false,
      data = [];
}

class DiaryNotifier extends StateNotifier<DiaryDataModel> {
  final Ref ref;
  DiaryNotifier(this.ref): super(DiaryDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = DiaryDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListDiary();
    state = DiaryDataModel(loading: false, data: data);
  }
}

final diaryControllerProvider = StateNotifierProvider<DiaryNotifier, DiaryDataModel>((ref) {
  return DiaryNotifier(ref);
});

