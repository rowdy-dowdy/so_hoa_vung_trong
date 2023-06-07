import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/dat_model.dart';
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

// nguyen lieu
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

class NguyenLieuNotifier extends StateNotifier<NguyenLieuDataModel> {
  final Ref ref;
  NguyenLieuNotifier(this.ref): super(NguyenLieuDataModel.unknown()) {
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

final nguyenLieuControllerProvider = StateNotifierProvider<NguyenLieuNotifier, NguyenLieuDataModel>((ref) {
  return NguyenLieuNotifier(ref);
});


// dat
class DatDataModel {
  final bool loading;
  List<DatModel> data;
  DatDataModel({
    required this.loading,
    required this.data,
  });

  DatDataModel.unknown()
    : loading = false,
      data = [];
}

class DatNotifier extends StateNotifier<DatDataModel> {
  final Ref ref;
  DatNotifier(this.ref): super(DatDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = DatDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListDat();
    state = DatDataModel(loading: false, data: data);
  }

  DatModel? getItem(String Oid) {
    DatModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final datControllerProvider = StateNotifierProvider<DatNotifier, DatDataModel>((ref) {
  return DatNotifier(ref);
});