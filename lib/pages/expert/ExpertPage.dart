import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/components/expert/ItemTopic.dart';
import 'package:so_hoa_vung_trong/components/loading/TopicsLoading.dart';
import 'package:so_hoa_vung_trong/controllers/expert/topic_controller.dart';
import 'package:so_hoa_vung_trong/models/topic_category_model.dart';
import 'package:so_hoa_vung_trong/pages/expert/topic/TopicAddPage.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

final searchTextProvider = StateProvider<String>((ref) {
  return "";
});

// final listSelectProvider = Provider<List<String>>((ref) {
//   List<String> list = ref.watch(topicCategoriesProvider).whenData((value) => value).value?.map((e) => e.Oid).toList() ?? [];
//   return list;
// });

final listSelectProvider = StateProvider<List<String>>((ref) {
  List<String> list = ref.watch(topicCategoriesProvider).whenData((value) => value).value?.map((e) => e.Oid).toList() ?? [];
  return list;
});

class ExpertPage extends ConsumerStatefulWidget {
  const ExpertPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertPageState();
}

class _ExpertPageState extends ConsumerState<ExpertPage> {
  @override
  Widget build(BuildContext context) {
    final topicsData = ref.watch(topicsControllerProvider);
    final topicCategories = ref.watch(topicCategoriesProvider);
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[primary, second]),
              ),
            ),
            title: const Text("Trao đổi với chuyên gia", style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => const TopicAddPage(),)
                ), 
                icon: const Icon(CupertinoIcons.add_circled, color: Colors.white,)
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        isDense: true,
                        hintText: 'Tìm kiếm',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12.0),
                        suffixIcon: IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search, color: primary,)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                    onPressed: () => showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => topicCategories.when(
                        data: (data) => ListCategory(items: data), 
                        error: (_,__) => const Text("Không thể tải danh mục"), 
                        loading: () => const Center(child: CircularProgressIndicator())
                      ),
                    ), 
                    icon: const Icon(Icons.filter_alt_rounded, color: primary,)
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(topicsControllerProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final topics = topicsData.data;

                        return Column(
                          children: [
                            for(var i = 0; i < topics.length; i++) ...[
                              ItemTopic(topic: topics[i])
                            ],

                            if (topicsData.loading) ...[
                              const TopicsLoading()
                            ],

                            if (topics.isEmpty && !topicsData.loading) ...[
                              SizedBox(
                                height: constraints.maxHeight,
                                child: const Center(child: Text("Không có câu hỏi nào"))
                              )
                            ]
                          ],
                        );
                      }
                    ),
                  )
                )
              );
            },
          ),
        ),
      ],
    );
  }
}

class ListCategory extends ConsumerStatefulWidget {
  final List<TopicCategoryModel> items;
  const ListCategory({required this.items, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListCategoryState();
}

class _ListCategoryState extends ConsumerState<ListCategory> {

  @override
  Widget build(BuildContext context) {
    final listSelect = ref.watch(listSelectProvider);
    return Material(
      child: SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        controller: ModalScrollController.of(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map((e) => 
            InkWell(
              onTap: () {
                setState(() {
                  int check = listSelect.indexWhere((element) => element == e.Oid);

                  if (check >= 0) {
                    ref.watch(listSelectProvider.notifier).update((state) => state.where((element) => element != e.Oid).toList());
                  }
                  else {
                    ref.watch(listSelectProvider.notifier).update((state) => [...state, e.Oid]);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CupertinoCheckbox(
                        activeColor: primary,
                        value: listSelect.indexWhere((element) => element == e.Oid) >= 0,
                        onChanged: (newValue) {},
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(e.TenDanhMuc ?? "", style: const TextStyle(fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ),
          ).toList()
        ),
      ),
    ));
  }
}