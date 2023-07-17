import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/loading/GridListLoading.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class PhanBonPage extends ConsumerStatefulWidget {
  const PhanBonPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhanBonPageState();
}

class _PhanBonPageState extends ConsumerState<PhanBonPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phân bón"),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(CupertinoIcons.back),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add_circled)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(phanBonControllerProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(phanBonControllerProvider);

                    if (data.loading) {
                      return const GridListLoading();
                    }

                    if (data.data.isEmpty) {
                      return const Center(child: Text("Không có phân bón nào"),);
                    }

                    return AlignedGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.data.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        final item = data.data[index];
                        return InkWell(
                          onTap: () => context.go('/phan-bon/${item.Oid}'),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/phan_bon.jpg") as ImageProvider,
                                fit: BoxFit.cover
                              )
                            ),
                            // margin: EdgeInsets.only(
                            //   left: index == 0 ? 12 : 0,
                            //   right: index == data.data.length ? 12 : 0,
                            // ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.2),
                                    Colors.black.withOpacity(0),
                                    Colors.black.withOpacity(0),
                                  ],
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(item.TenPhanBon?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 2,),
                                  Text(formatCurrency(context, item.Gia), style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}