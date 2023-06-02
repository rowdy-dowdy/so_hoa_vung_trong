import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class TopicsLoading extends ConsumerStatefulWidget {
  const TopicsLoading({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopicsLoadingState();
}

class _TopicsLoadingState extends ConsumerState<TopicsLoading> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var i = 0; i < 3; i++) ...[
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width: 70, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),),
                                  const SizedBox(height: 5,),
                                  Container(width: 50, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Container(width: 200, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),),
                        const SizedBox(height: 5,),
                        Container(width: 250, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(CupertinoIcons.chat_bubble_2_fill),
                        const SizedBox(width: 10,),
                        Container(width: 50, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),),
                        const Spacer(),
                        Container(width: 100, height: 15, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}