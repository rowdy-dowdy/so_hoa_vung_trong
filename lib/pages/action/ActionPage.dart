import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ActionPage extends ConsumerStatefulWidget {
  final void Function(String?) changePageCallback;
  const ActionPage({required this.changePageCallback, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActionPageState();
}

class _ActionPageState extends ConsumerState<ActionPage> {
  static const list = <Map>[
    { "icon": CupertinoIcons.archivebox_fill, "label": 'Fertilizer', "color": Color(0xffFF4858), "path": '/phan-bon' },
    { "icon": CupertinoIcons.ant, "label": 'Plant protection products', "color": Color(0xffBD2A2E), "path": '/' },
    { "icon": CupertinoIcons.arrow_3_trianglepath, "label": 'Materials', "color": Color.fromARGB(255, 216, 122, 59), "path": '/' },
    { "icon": CupertinoIcons.tree, "label": 'Type tree', "color": Color(0xFFDDAA33), "path": '/' },
    { "icon": CupertinoIcons.briefcase_fill, "label": 'Job - Status', "color": Color(0xFF44803F), "path": '/' },
    { "icon": CupertinoIcons.bolt_circle, "label": 'Production process', "color": Color(0xFF146152), "path": '/' },
    { "icon": CupertinoIcons.arrow_2_circlepath_circle, "label": 'Soil - Base', "color": Color(0xff284F8F), "path": '/' },
    { "icon": CupertinoIcons.gamecontroller_fill, "label": 'Equipment', "color": Color(0xff592F64), "path": '/' },
  ];

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Column(
      children: [
        AppBar(
          title: const Text("Category").tr(),
          leading: IconButton(
            onPressed: () => widget.changePageCallback('/'),
            icon: const Icon(CupertinoIcons.back),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: AlignedGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              itemCount: list.length,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1/1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: list[index]['color'],
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(list[index]['icon'], size: 30, color: Colors.white,),
                        const SizedBox(height: 5,),
                        Text(tr(list[index]['label']), style: const TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center,)
                      ],
                    ),
                  ),
                );
              },
            )
          ),
        ),
      ],
    );
  }
}