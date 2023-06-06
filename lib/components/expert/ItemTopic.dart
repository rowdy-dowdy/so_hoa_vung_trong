import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/ExpandedText.dart';
import 'package:so_hoa_vung_trong/components/loading/CommentLoading.dart';
import 'package:so_hoa_vung_trong/controllers/expert/comment_controller.dart';
import 'package:so_hoa_vung_trong/models/topic_model.dart';
import 'package:so_hoa_vung_trong/pages/expert/topic/TopicDetails.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class ItemTopic extends ConsumerStatefulWidget {
  final TopicModel topic;
  const ItemTopic({required this.topic, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemTopicState();
}

class _ItemTopicState extends ConsumerState<ItemTopic> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                InkWell(
                  // onTap: () => context.go('/expert/${widget.topic.Oid}'),
                  onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => TopicDetails(id: widget.topic.Oid)
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: widget.topic.NguoiTao?.Avatar != null ? MemoryImage(widget.topic.NguoiTao!.Avatar!) : const AssetImage("assets/img/user.png") as ImageProvider,
                            fit: BoxFit.fill,
                          )
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.topic.NguoiTao?.Ten ?? "Nông hộ", style: const TextStyle(
                              fontWeight: FontWeight.w500
                            ),),
                            Text(formatTimeToString(widget.topic.NgayTao), style: const TextStyle(
                              fontSize: 12,
                              color: grey
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                ExpandedText(text: widget.topic.NoiDung ?? "",),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          if (widget.topic.File != null) ...[
            Hero(
              tag: 'topic-${widget.topic.Oid}',
              child: Image(
                image: MemoryImage(widget.topic.File!), 
                fit: BoxFit.cover
              ),
            ),
            const SizedBox(height: 10,),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(CupertinoIcons.chat_bubble_2_fill),
                const SizedBox(width: 10,),
                Consumer(
                  builder: (context, ref, child) {
                    final commentsData = ref.watch(commentsControllerProvider(widget.topic.Oid));
                    if (commentsData.loading) {
                      return const CommentCountLoading();
                    }
                    return Text("${commentsData.data.length} thảo luận");
                  }
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => TopicDetails(id: widget.topic.Oid,)),
                  ),
                  child: const Text("Tham gia Thảo luận")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  
  MyPageRoute({required this.child})
    : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return CupertinoPageTransition(
        child: child,
        linearTransition: false,
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
      );
    }
  );
}