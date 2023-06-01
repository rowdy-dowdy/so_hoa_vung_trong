import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

GlobalKey<MessageBottomBarState> globalKey = GlobalKey();

class TopicDetails extends ConsumerStatefulWidget {
  final String id;
  const TopicDetails({required this.id, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopicDetailsState();
}

class _TopicDetailsState extends ConsumerState<TopicDetails> {
  late ScrollController scrollController;
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  bool isScroll = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > 5 && !isScroll) {
        setState(() {
          isScroll = true;
        });
      }
      else if (scrollController.offset < 5 && isScroll) {
        setState(() {
          isScroll = false;
        });
      }
    });
  }

  @override void dispose() {
    unitCodeCtrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        titleSpacing: 0,
        shape: isScroll ? Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1
          )
        ) : null,
        title: Row(
          children: [
            Container(
              width: kTextTabBarHeight * 0.8,
              height: kTextTabBarHeight * 0.8,
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
        leading: IconButton(
          onPressed: () => context.go('/expert'),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: const Text("data"),
                  ),
                  CachedNetworkImage( 
                    imageUrl: "https://cdn.tgdd.vn/Files/2020/01/04/1229938/cach-nau-nui-thit-bo-nhanh-day-nang-luong-cho-bua-sang-202202231241209373.jpg",
                    imageBuilder: (context, imageProvider) => Hero(
                      tag: 'topic-${0}',
                      child: Image(
                        image: imageProvider, 
                        fit: BoxFit.cover
                      ),
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
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                        bottom: BorderSide(color: Colors.grey[300]!)
                      )
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.chat_bubble_2_fill),
                        const SizedBox(width: 10,),
                        const Text("5 thảo luận"),
                        const Spacer(),
                        TextButton(
                          onPressed: () => unitCodeCtrlFocusNode.requestFocus(), 
                          child: Text("Thảo luận")
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/img/user.png"),
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Nguyễn Việt Hùng", style: TextStyle(fontWeight: FontWeight.w500),),
                                          const SizedBox(height: 3,),
                                          const Text("Nguyễnfsadf sdfsad fasdf sadfsadf asdfasdfdsa sdafsd fasdf ")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: const Text("8 phút", style: TextStyle(fontSize: 12, color: grey),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: MessageBottomBar(id: "1", unitCodeCtrlFocusNode: unitCodeCtrlFocusNode),
    );
  }
}

class MessageBottomBar extends ConsumerStatefulWidget {
  final String id;
  FocusNode? unitCodeCtrlFocusNode;
  MessageBottomBar({required this.id, this.unitCodeCtrlFocusNode, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MessageBottomBarState();
}

class MessageBottomBarState extends ConsumerState<MessageBottomBar> {
  final textMessageController = TextEditingController();
  bool isTextEmpty = true;

  void sendTextMessage() {

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          // width: double.infinity,
          color: Color.fromARGB(255, 215, 214, 221).withOpacity(0.8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60)
                  ),
                  child: TextField(
                    controller: textMessageController,
                    focusNode: widget.unitCodeCtrlFocusNode,
                    style: TextStyle(fontSize: 14),
                    onChanged: (value) {
                      if (value.isEmpty && !isTextEmpty) {
                        setState(() {
                          isTextEmpty = true;
                        });
                      }
                      else if (value.isNotEmpty && isTextEmpty) {
                        setState(() {
                          isTextEmpty = false;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      hintText: "Nội dung"
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(
                onTap: !isTextEmpty ? sendTextMessage : null,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: !isTextEmpty ? primary : grey,
                    shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.send, color: Colors.white, size: 18,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
