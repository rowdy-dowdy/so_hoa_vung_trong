import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/nguyen_lieu.dart';
import 'package:so_hoa_vung_trong/models/phan_bon_model.dart';
import 'package:so_hoa_vung_trong/models/thiet_bi_model.dart';
import 'package:so_hoa_vung_trong/models/thuoc_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';

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