import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class PhanBonDetailsPage extends ConsumerStatefulWidget {
  final String Oid;
  const PhanBonDetailsPage({required this.Oid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhanBonDetailsPageState();
}

class _PhanBonDetailsPageState extends ConsumerState<PhanBonDetailsPage> {
  static double height = 300;
  var top = height - kToolbarHeight;
  var opacity = 0.0;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final topDistance = (height - kToolbarHeight) - scrollController.offset;
      // top = topDistance > 0 ? topDistance : 0;
      // setState(() {
      //   opacity = 1 - (top / (height - kToolbarHeight));
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final item = ref.watch(phanBonControllerProvider.notifier).getItem(widget.Oid);

    if (item == null) {
      return const Scaffold(
        body: Center(child: Text("Phân bón không tồn tại")),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            leadingWidth: 42,
            titleSpacing: 10,
            title: const Text("Fertilizer").tr(),
            leading: InkWell(
              onTap: () => context.pop(),
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: const Icon(CupertinoIcons.back),
              ),
            ),
            actions: [
              InkWell(
                // onTap: () => context.pop(),
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.edit_document),
                ),
              )
            ],
            floating: false,
            pinned: true,
            expandedHeight: height,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: double.infinity,
                // height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/phan_bon.jpg") as ImageProvider,
                    fit: BoxFit.fitHeight,
                  )
                ),
              )
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.TenPhanBon ?? "", style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(formatCurrency(context, item.Gia), style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),),
                      // const Text(" / ", style: TextStyle(
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.w500
                      // ),),
                      // Text(formatCurrency(context, item.Gia), style: const TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w500
                      // ),),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!)
                      )
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            )
                          ),
                          child: const Text("Ghi chú", style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),
                  Text(item.GhiChu ?? "Không có ghi chú"),

                  const SizedBox(height: 10,),

                  Container(height: 1000, decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}