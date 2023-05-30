import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiengviet/tiengviet.dart';

final expertsProvider = FutureProvider<List<dynamic>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return [1,2,3,4,5,6,7,8,9,10];
});

final filterTextProvider = StateProvider<String>((ref) {
  return "";
});

final expertsFilterProvider = Provider<List<dynamic>>((ref) {
  List<dynamic> experts = ref.watch(expertsProvider).whenData((value) => value).value ?? [];
  return experts;
  final filter = TiengViet.parse(ref.watch(filterTextProvider)).toLowerCase();
  return experts.where((expert) => TiengViet.parse(expert.name).toLowerCase().contains(filter.toLowerCase())).toList();
});

class ListExpert extends ConsumerStatefulWidget {
  const ListExpert({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListExpertState();
}

class _ListExpertState extends ConsumerState<ListExpert> {
   final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (ref.read(filterTextProvider.notifier).state.isNotEmpty) {
      searchController.text = ref.read(filterTextProvider.notifier).state;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final experts = ref.watch(expertsProvider);
     return Container(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.center,
            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) => ref.read(filterTextProvider.notifier).state = value,
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(expertsProvider.future),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: experts.when(
                        data: (data) {
                          final experts = ref.watch(expertsFilterProvider);
                          print(experts);
                    
                          if (experts.isEmpty) {
                            return Center(child: Text("Không có chuyên gia nào"),);
                          }
                    
                          return Column(
                            children: experts.map((item) => 
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(children: [
                                  SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: CachedNetworkImage(
                                      imageUrl: "",
                                      imageBuilder: (context, imageProvider) => Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider, fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  Expanded(
                                    child: Container(
                                      constraints: const BoxConstraints(minHeight: 55),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Nguyễn Việt Hùng", style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          ),),
                                          const SizedBox(height: 5,),
                                          Text("viet.hung.2898@gmail.com", style: const TextStyle(
                                            // color: Colors.grey[700]!,
                                            // // fontSize: 18,
                                            // fontWeight: FontWeight.w500
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  
                                  IconButton(
                                    onPressed: () => context.go('/'),
                                    icon: const Icon(CupertinoIcons.info, color: Colors.blue,)
                                  )
                                ],),
                              )
                            ).toList()
                          );
                        }, 
                        error: (_,__) => const Center(child: Text("Không thể tải dữ liệu")), 
                        loading: () => const StudentLoadingWidget()
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class StudentLoadingWidget extends ConsumerWidget {
  const StudentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey[300]!,
      child: Column(
        children: [
          for(var i = 0; i < 4; i ++) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  // color: Colors.grey
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Container(
                          width: 150, height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: 200, height: 15,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],),
            ),
          ]
        ],
      ),
    );
  }
}