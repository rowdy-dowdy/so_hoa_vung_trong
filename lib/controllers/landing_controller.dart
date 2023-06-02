// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/services/shared_prefs.dart';

class LandingDataModel {
  final bool loading;
  final bool firstRunApp;
  LandingDataModel({
    required this.loading,
    required this.firstRunApp,
  });

  const LandingDataModel.unknown()
    : loading = false,
      firstRunApp = true;
}

class LandingNotifier extends StateNotifier<LandingDataModel> {
  final Ref ref;
  LandingNotifier(this.ref): super(const LandingDataModel.unknown()) {
    init();
  }
  
  void init() async {
    state = LandingDataModel(loading: false, firstRunApp: true);
    // state = LandingDataModel(loading: true, firstRunApp: true);
    // final prefs = await ref.read(sharedPrefsProvider.future);
    // String? landing = prefs.getString('landing');
    // state = LandingDataModel(loading: false, firstRunApp: landing?.isEmpty ?? true);
  }

  void gotoLogin() {
    state = LandingDataModel(loading: false, firstRunApp: false);
  }
}

final landingControllerProvider = StateNotifierProvider<LandingNotifier, LandingDataModel>((ref) {
  return LandingNotifier(ref);
});