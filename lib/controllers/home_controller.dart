import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/congviec_model.dart';
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

// congviec
class CongViecDataModel {
  final bool loading;
  List<CongViecModel> data;
  CongViecDataModel({
    required this.loading,
    required this.data,
  });

  CongViecDataModel.unknown()
    : loading = false,
      data = [];
}

class CongViecNotifier extends StateNotifier<CongViecDataModel> {
  final Ref ref;
  CongViecNotifier(this.ref): super(CongViecDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = CongViecDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListCongViec();
    state = CongViecDataModel(loading: false, data: data);
  }

  CongViecModel? getItem(String Oid) {
    CongViecModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final congViecControllerProvider = StateNotifierProvider<CongViecNotifier, CongViecDataModel>((ref) {
  return CongViecNotifier(ref);
});

// bon phan
class PhanBonDataModel {
  final bool loading;
  List<PhanBonModel> data;
  PhanBonDataModel({
    required this.loading,
    required this.data,
  });

  PhanBonDataModel.unknown()
    : loading = false,
      data = [];
}

class PhanBonNotifier extends StateNotifier<PhanBonDataModel> {
  final Ref ref;
  PhanBonNotifier(this.ref): super(PhanBonDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = PhanBonDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListPhanBon();
    state = PhanBonDataModel(loading: false, data: data);
  }

  PhanBonModel? getItem(String Oid) {
    PhanBonModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final phanBonControllerProvider = StateNotifierProvider<PhanBonNotifier, PhanBonDataModel>((ref) {
  return PhanBonNotifier(ref);
});

// thuoc
class ThuocDataModel {
  final bool loading;
  List<ThuocModel> data;
  ThuocDataModel({
    required this.loading,
    required this.data,
  });

  ThuocDataModel.unknown()
    : loading = false,
      data = [];
}

class ThuocNotifier extends StateNotifier<ThuocDataModel> {
  final Ref ref;
  ThuocNotifier(this.ref): super(ThuocDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = ThuocDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListThuoc();
    state = ThuocDataModel(loading: false, data: data);
  }

  ThuocModel? getItem(String Oid) {
    ThuocModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final thuocControllerProvider = StateNotifierProvider<ThuocNotifier, ThuocDataModel>((ref) {
  return ThuocNotifier(ref);
});

// thuoc
class ThietBiDataModel {
  final bool loading;
  List<ThietBiModel> data;
  ThietBiDataModel({
    required this.loading,
    required this.data,
  });

  ThietBiDataModel.unknown()
    : loading = false,
      data = [];
}

class ThietBiNotifier extends StateNotifier<ThietBiDataModel> {
  final Ref ref;
  ThietBiNotifier(this.ref): super(ThietBiDataModel.unknown()) {
    loadData();
  }
  
  Future loadData() async {
    state = ThietBiDataModel(loading: true, data: []);
    var data = await ref.read(mainRepositoryProvider).fetchListThietBi();
    state = ThietBiDataModel(loading: false, data: data);
  }

  ThietBiModel? getItem(String Oid) {
    ThietBiModel? topic = state.data.firstWhereOrNull((element) => element.Oid == Oid);
    return topic;
  }
}

final thietBiControllerProvider = StateNotifierProvider<ThietBiNotifier, ThietBiDataModel>((ref) {
  return ThietBiNotifier(ref);
});