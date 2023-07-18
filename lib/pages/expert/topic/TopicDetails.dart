import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/loading/CommentLoading.dart';
import 'package:so_hoa_vung_trong/controllers/expert/comment_controller.dart';
import 'package:so_hoa_vung_trong/controllers/expert/topic_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

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
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topic = ref.watch(topicsControllerProvider.notifier).getTopic(widget.id);
    final commentsData = ref.watch(commentsControllerProvider(widget.id));

    if (topic == null) {
      return Scaffold(
        body: Center(child: const Text("The question does not exist").tr()),
      );
    }

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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: topic.NguoiTao?.Avatar != null ? MemoryImage(topic.NguoiTao!.Avatar!) : const AssetImage("assets/img/user.png") as ImageProvider,
                  fit: BoxFit.fill,
                )
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.NguoiTao?.Ten ?? "Farming households".tr(), style: const TextStyle(
                    fontWeight: FontWeight.w500
                  ),),
                  Text(formatTimeToString(context, topic.NgayTao), style: const TextStyle(
                    fontSize: 12,
                    color: grey
                  ),)
                ],
              ),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
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
                    child: Text(topic.NoiDung ?? ""),
                  ),
                  if (topic.File != null) ...[
                    Hero(
                      tag: 'topic-${topic.Oid}',
                      child: Image(
                        image: MemoryImage(topic.File!), 
                        fit: BoxFit.cover
                      ),
                    ),
                  ],
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
                        Consumer(
                          builder: (context, ref, child) {
                            if (commentsData.loading) {
                              return const CommentCountLoading();
                            }
                            return Text("${commentsData.data.length} ${"comments".tr()}");
                          }
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => unitCodeCtrlFocusNode.requestFocus(), 
                          child: const Text("Start the discussion").tr()
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Consumer(
                      builder: (context, ref, child) {
                        if (commentsData.loading) {
                          return const CommentLoading();
                        }

                        if (commentsData.data.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(child: const Text("No questions asked").tr())
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: commentsData.data.length,
                          itemBuilder: (context, index) {
                            final comment = commentsData.data[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: comment.NguoiTao?.Avatar != null ? MemoryImage(comment.NguoiTao!.Avatar!) : AssetImage("assets/img/user.png") as ImageProvider,
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
                                              Text(comment.NguoiTao?.Ten ?? "Farming households".tr(), style: const TextStyle(fontWeight: FontWeight.w500),),
                                              const SizedBox(height: 3,),
                                              Text(comment.NoiDung ?? "")
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(formatTimeToString(context, comment.NgayTao), style: const TextStyle(fontSize: 12, color: grey),),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: MessageBottomBar(id: widget.id, unitCodeCtrlFocusNode: unitCodeCtrlFocusNode, onChange: () {
        if(scrollController.hasClients){
          Future.delayed(const Duration(microseconds: 300), () {
            scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        }
      },),
    );
  }
}

class MessageBottomBar extends ConsumerStatefulWidget {
  final String id;
  Function() onChange;
  FocusNode? unitCodeCtrlFocusNode;
  MessageBottomBar({required this.id, required this.onChange, this.unitCodeCtrlFocusNode, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MessageBottomBarState();
}

class MessageBottomBarState extends ConsumerState<MessageBottomBar> {
  final textMessageController = TextEditingController();
  bool isTextEmpty = true;
  bool loading = false;

  Future sendTextMessage() async {
    if (loading) return;

    String tempText = textMessageController.text;

    setState(() {
      loading = true;
      textMessageController.text = "";
      isTextEmpty = true;
    });


    bool check = await ref.watch(commentsControllerProvider(widget.id).notifier).createComment(NoiDung: tempText);

    if (check) {
      widget.onChange();
    }

    setState(() {
      loading = false;
    });
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
          color: const Color.fromARGB(255, 215, 214, 221).withOpacity(0.8),
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
                    style: const TextStyle(fontSize: 14),
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
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      hintText: "Content".tr()
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              loading ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),)
              : InkWell(
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
