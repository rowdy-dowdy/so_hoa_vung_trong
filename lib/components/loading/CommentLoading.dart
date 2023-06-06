import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommentLoading extends StatefulWidget {
  const CommentLoading({super.key});

  @override
  State<CommentLoading> createState() => _CommentLoadingState();
}

class _CommentLoadingState extends State<CommentLoading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var i = 0; i < 5; i ++) ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(width: 70, height: 15, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),)
                        ),
                        const SizedBox(height: 3,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(width: 150, height: 13, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(width: 50, height: 10, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),)
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        ]
      ],
    );
  }
}

class CommentCountLoading extends StatefulWidget {
  const CommentCountLoading({super.key});

  @override
  State<CommentCountLoading> createState() => _CommentCountLoadingState();
}

class _CommentCountLoadingState extends State<CommentCountLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: 70, height: 20, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),)
    );
  }
}