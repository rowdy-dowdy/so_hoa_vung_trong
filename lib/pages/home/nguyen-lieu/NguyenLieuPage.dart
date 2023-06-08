import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/loading/GridListLoading.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class NguyenLieuPage extends ConsumerStatefulWidget {
  const NguyenLieuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NguyenLieuPageState();
}

class _NguyenLieuPageState extends ConsumerState<NguyenLieuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Nguyên liệu"),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(CupertinoIcons.back),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add_circled)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(nguyenLieuControllerProvider);
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
                    final nguyenLieuData = ref.watch(nguyenLieuControllerProvider);

                    if (nguyenLieuData.loading) {
                      return const GridListLoading();
                    }

                    if (nguyenLieuData.data.isEmpty) {
                      return const Center(child: Text("Không có nguyên liệu nào"),);
                    }

                    return AlignedGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nguyenLieuData.data.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        final item = nguyenLieuData.data[index];
                        return InkWell(
                          onTap: () => context.go('/nguyen-lieu/${item.Oid}'),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/nguyen_lieu.jpg") as ImageProvider,
                                fit: BoxFit.cover
                              )
                            ),
                            // margin: EdgeInsets.only(
                            //   left: index == 0 ? 12 : 0,
                            //   right: index == nguyenLieuData.data.length ? 12 : 0,
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
                                  Text(item.TenNguyenLieu?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 2,),
                                  Text(formatCurrency(item.Gia), style: const TextStyle(
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