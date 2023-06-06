import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/comment_model.dart';
import 'package:so_hoa_vung_trong/repositories/main_repository.dart';
import 'package:collection/collection.dart';

class CommentsNotifier extends StateNotifier<CommentData> {
  final Ref ref;
  final String TopicOid;
 
  CommentsNotifier(this.ref, this.TopicOid): super(CommentData.unknown()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.changeState(true);
    var data = await ref.read(mainRepositoryProvider).fetchComments(TopicOid: TopicOid);
    state = state.addComments(data);
  }

  Future<bool> createComment({required String NoiDung}) async {
    CommentModel? data = await ref.read(mainRepositoryProvider).createComment(TopicOid: TopicOid, NoiDung: NoiDung);

    if (data != null) {
      state = state.addComment(data);
      return true;
    }

    return false;
  }

  Future refresh() async {
    
  }
}

final commentsControllerProvider = StateNotifierProvider.family<CommentsNotifier, CommentData, String>((ref, TopicOid) {
  return CommentsNotifier(ref, TopicOid);
});

class CommentData {
  bool loading;
  List<CommentModel> data;

  CommentData({
    required this.loading,
    required this.data,
  });

  CommentData.unknown()
    : loading = false,
      data = [];

  CommentData changeState (bool loading) {
    return CommentData(loading: loading, data: data);
  }

  CommentData addComments (List<CommentModel>  dataAdd) {
    data.addAll(dataAdd);

    return CommentData(loading: false, data: data);
  }

  CommentData addComment (CommentModel  dataAdd) {
    data.add(dataAdd);

    return CommentData(loading: false, data: data);
  }
}