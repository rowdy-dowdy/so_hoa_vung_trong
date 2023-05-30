import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/TimeLine.dart';
import 'package:so_hoa_vung_trong/components/TimeLineTop.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class DiaryPage extends ConsumerStatefulWidget {
  final String id;
  const DiaryPage({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryStatePage();
}

class _DiaryStatePage extends ConsumerState<DiaryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhật ký sản xuất"),
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(CupertinoIcons.back),
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/diary/${widget.id}/edit'), 
            icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle)
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.white,
        child: SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/img/diary.png"),
                            fit: BoxFit.contain
                          )
                        ),
                      ),
                    ),
                    const Text("NKSX Chè BĐHk (mẫu) (2023)", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      // color: primary
                    ),),
                    const SizedBox(height: 5,),
                    const Text("Năm 2023", style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.w500,
                      color: second
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Builder(
                  builder: (context) {
                    final list = <Map>[
                      { "icon": CupertinoIcons.square_arrow_right, "label": 'Ngày bắt đầu', "value": 'fsdf'},
                      { "icon": CupertinoIcons.square_arrow_left, "label": 'Ngày kết thúc', "value": 'fsdf'},
                      { "icon": CupertinoIcons.chart_bar_square, "label": 'Diện tích', "value": 'fsdf'},
                      { "icon": CupertinoIcons.square_grid_2x2, "label": 'Sản lượng', "value": 'fsdf'}
                    ];
                    return AlignedGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: list.length,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Row(
                            children: [
                              Icon(list[index]['icon'], size: 30, color: primary,),
                              const SizedBox(width: 10,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index]['label'], style: TextStyle(fontWeight: FontWeight.w500),),
                                  Text(list[index]['value'])
                                ],
                              ),)
                            ],
                          ),
                        );
                      },
                    );
                  }
                ),
              ),

              const SizedBox(height: 10,),
              
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    const Text("Chi tiết nhật ký sản xuất", style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),),
                    const SizedBox(height: 10,),
                    // const Divider(height: 1, color: Colors.grey,),
                    // const SizedBox(height: 10,),

                    TimeLineTop(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
    ],
                          ),
                        ),
                        Container(height: 100, color: primary,)
                      ],
                      indicators: [
                        const Text("18/10/2023", style: TextStyle(color: primary, fontWeight: FontWeight.w500),),
                        const Text("data")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}