import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';

class BreakSchoolsNotifier extends StateNotifier<BreakSchoolData> {
  final Ref ref;
 
  BreakSchoolsNotifier(this.ref): super(BreakSchoolData.unknown()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.changeState(true);
    var data = await ref.read(mainRepositoryProvider).getBreakSchools();
    state = BreakSchoolData(loading: false, current_page: data['current_page'], 
      per_page: data['per_page'], last_page: data['last_page'], breakSchools: data['data']);
  }

  Future loadMore() async {
    if (state.current_page >= state.last_page || state.moreLoading) {
      return;
    }

    state = state.changeMoreLoading(true);
    var data = await ref.read(teacherRepositoryProvider).getBreakSchools(page: state.current_page + 1);
    state = state.addBreakSchools(data['data'], data['current_page']);
  }

  Future refresh() async {
    
  }

  void dispose() {
    _breakSchoolsController.close();
  }
}

final breakSchoolControllerProvider = StateNotifierProvider<BreakSchoolsNotifier, BreakSchoolData>((ref) {
  return BreakSchoolsNotifier(ref);
});

class BreakSchoolData {
  bool loading;
  bool moreLoading;
  int current_page;
  int per_page;
  int last_page;
  List<BreakSchoolModel> breakSchools;

  BreakSchoolData({
    required this.loading,
    this.moreLoading = false,
    required this.current_page,
    required this.per_page,
    required this.last_page,
    required this.breakSchools,
  });

  BreakSchoolData.unknown()
    : loading = false,
      moreLoading = false,
      breakSchools = [],
      current_page = 1,
      per_page = 1,
      last_page = 1;
  
  BreakSchoolData.first()
    : loading = true,
      moreLoading = false,
      breakSchools = [],
      current_page = 1,
      per_page = 1,
      last_page = 1;

  BreakSchoolData changeState (bool loading) {
    return BreakSchoolData(loading: loading, current_page: current_page, per_page: per_page, last_page: last_page, breakSchools: breakSchools);
  }

  BreakSchoolData changeMoreLoading (bool moreLoading) {
    return BreakSchoolData(loading: loading, moreLoading: moreLoading, current_page: current_page, per_page: per_page, last_page: last_page, breakSchools: breakSchools);
  }

  BreakSchoolData addBreakSchools (List<BreakSchoolModel>  data, int current_page) {
    breakSchools.addAll(data);
    return BreakSchoolData(loading: loading, current_page: current_page, per_page: per_page, last_page: last_page, breakSchools: breakSchools);
  }
}