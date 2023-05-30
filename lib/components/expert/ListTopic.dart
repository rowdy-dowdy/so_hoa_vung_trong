import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/ExpandedText.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class ListTopic extends ConsumerStatefulWidget {
  const ListTopic({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTopicState();
}

class _ListTopicState extends ConsumerState<ListTopic> {
  Future test() async {

  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () => test(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  for(var i = 0; i < 10; i++) ...[
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage("assets/img/user.png"),
                                          fit: BoxFit.fill,
                                        )
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Nguyễn Việt Hùng", style: TextStyle(
                                            fontWeight: FontWeight.w500
                                          ),),
                                          Text("5 ngày trước", style: TextStyle(
                                            fontSize: 12,
                                            color: grey
                                          ),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                ExpandedText(text: "lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321 lofsda f 321321",),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          CachedNetworkImage( 
                            imageUrl: "https://cdn.tgdd.vn/Files/2020/01/04/1229938/cach-nau-nui-thit-bo-nhanh-day-nang-luong-cho-bua-sang-202202231241209373.jpg",
                            imageBuilder: (context, imageProvider) => Image(
                              image: imageProvider, 
                              fit: BoxFit.cover
                            ),
                            placeholder: (context, url) => Container(
                              height: 200,
                              child: const Center(child: CircularProgressIndicator())
                            ),
                            errorWidget: (context, url, error) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text("Không thể tải lịch học"),),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.chat_bubble_2_fill),
                                const SizedBox(width: 10,),
                                const Text("5 thảo luận"),
                                const Spacer(),
                                TextButton(onPressed: () {}, child: Text("Tham gia Thảo luận"))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                ],
              ),
            )
          )
        );
      },
    );
  }
}