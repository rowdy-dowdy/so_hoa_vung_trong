import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/topic_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';
import 'package:collection/collection.dart';

class TopicsNotifier extends StateNotifier<TopicData> {
  final Ref ref;
 
  TopicsNotifier(this.ref): super(TopicData.unknown()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.changeState(true);
    var data = await ref.read(mainRepositoryProvider).fetchTopic();
    state = state.addTopics(data);
  }

  Future loadMore() async {
    if (state.isLastPage || state.loading) {
      return;
    }

    state = state.changeState(true);
    var data = await ref.read(mainRepositoryProvider).fetchTopic(page: state.currentPage + 1);
    state = state.addTopics(data);
  }

  Future refresh() async {
    
  }
}

final topicsControllerProvider = StateNotifierProvider<TopicsNotifier, TopicData>((ref) {
  return TopicsNotifier(ref);
});

final topicDetailsProvider = Provider.family<TopicModel?, String>((ref, Oid) {
  return ref.watch(topicsControllerProvider).data.firstWhereOrNull((element) => element.Oid == Oid);
});

class TopicData {
  bool loading;
  int currentPage;
  int perPage = 8;
  bool isLastPage;
  List<TopicModel> data;

  TopicData({
    required this.loading,
    required this.currentPage,
    required this.perPage,
    required this.isLastPage,
    required this.data,
  });

  TopicData.unknown()
    : loading = false,
      data = [],
      currentPage = 1,
      perPage = 1,
      isLastPage = false;
  
  TopicData.first()
    : loading = true,
      data = [],
      currentPage = 1,
      perPage = 1,
      isLastPage = false;

  TopicData changeState (bool loading) {
    return TopicData(loading: loading, currentPage: currentPage, perPage: perPage, isLastPage: isLastPage, data: data);
  }


  TopicData addTopics (List<TopicModel>  dataAdd) {
    data.addAll(dataAdd);

    bool isLastPage = false;
    if (data.isEmpty || data.length < perPage) {
      isLastPage = true;
    }
    else {
      currentPage += currentPage;
    }

    return TopicData(loading: false, currentPage: currentPage, perPage: perPage, isLastPage: isLastPage, data: data);
  }
}