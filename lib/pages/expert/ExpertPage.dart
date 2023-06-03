import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/components/expert/ItemTopic.dart';
import 'package:so_hoa_vung_trong/components/loading/TopicsLoading.dart';
import 'package:so_hoa_vung_trong/controllers/expert/topic_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class ExpertPage extends ConsumerStatefulWidget {
  const ExpertPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertPageState();
}

class _ExpertPageState extends ConsumerState<ExpertPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topicsData = ref.watch(topicsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[primary, second]),
          ),
        ),
        title: const Text("Trao đổi với chuyên gia", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
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
                        builder: (context) => const ListCategory(items: [
                          {"label" : "fasdf", "value": true},
                          {"label" : "fasdf", "value": true}
                        ]),
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

                              if (topics.isEmpty) ...[
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
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class ListCategory extends StatefulWidget {
  final List<Map> items;
  const ListCategory({required this.items, super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  @override
  Widget build(BuildContext context) {
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
                  e['value'] = !e['value'];
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
                        value: e['value'],
                        onChanged: (newValue) {
                          // setState(() {
                          //   e['value'] = newValue ?? false;
                          // });
                        },
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(e['label'], style: const TextStyle(fontWeight: FontWeight.w500),),
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