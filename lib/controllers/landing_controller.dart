// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/services/shared_prefs.dart';

class LandingModel {
  final bool loading;
  final bool firstRunApp;
  LandingModel({
    required this.loading,
    required this.firstRunApp,
  });

  const LandingModel.unknown()
    : loading = false,
      firstRunApp = true;
}

class LandingNotifier extends StateNotifier<LandingModel> {
  final Ref ref;
  LandingNotifier(this.ref): super(const LandingModel.unknown()) {
    init();
  }
  
  void init() async {
    state = LandingModel(loading: true, firstRunApp: true);
    final prefs = await ref.read(sharedPrefsProvider.future);
    String? landing = prefs.getString('landing');
    state = LandingModel(loading: false, firstRunApp: landing?.isEmpty ?? true);
  }

  void gotoLogin() {
    state = LandingModel(loading: false, firstRunApp: false);
  }
}

final landingControllerProvider = StateNotifierProvider<LandingNotifier, LandingModel>((ref) {
  return LandingNotifier(ref);
});