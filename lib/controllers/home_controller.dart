import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/nguyen_lieu.dart';
import 'package:so_hoa_vung_trong/models/phan_bon_model.dart';
import 'package:so_hoa_vung_trong/models/thiet_bi_model.dart';
import 'package:so_hoa_vung_trong/models/thuoc_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';
import 'package:collection/collection.dart';

final listNguyenLieuProvider = FutureProvider<List<NguyenLieuModel>>((ref) async {
  return ref.read(mainRepositoryProvider).fetchListNguyenLieu();
});

final listPhanBonProvider = FutureProvider<List<PhanBonModel>>((ref) async {
  return ref.read(mainRepositoryProvider).fetchListPhanBon();
});

final listThietBiProvider = FutureProvider<List<ThietBiModel>>((ref) async {
  return ref.read(mainRepositoryProvider).fetchListThietBi();
});

final listThuocProvider = FutureProvider<List<ThuocModel>>((ref) async {
  return ref.read(mainRepositoryProvider).fetchListThuoc();
});


class NguyenLieuDataModel {
  final bool loading;
  List<NguyenLieuModel> data;
  NguyenLieuDataModel({
    required this.loading,
    required this.data,
  });

  NguyenLieuDataModel.unknown()
    : loading = false,
      data = [];
}

class DiaryNotifier extends StateNotifier<NguyenLieuDataModel> {
  final Ref ref;
  DiaryNotifier(this.ref): super(NguyenLieuDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = NguyenLieuDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListNguyenLieu();
    state = NguyenLieuDataModel(loading: false, data: data);
  }

  NguyenLieuModel? getItem(String Oid) {
    NguyenLieuModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final nguyenLieuControllerProvider = StateNotifierProvider<DiaryNotifier, NguyenLieuDataModel>((ref) {
  return DiaryNotifier(ref);
});
