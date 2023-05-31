import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class HomeListLoading extends ConsumerStatefulWidget {
  const HomeListLoading({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeListLoadingState();
}

class _HomeListLoadingState extends ConsumerState<HomeListLoading> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Wrap(
          direction: Axis.vertical,
          runSpacing: 12,
          children: List.generate(10, (index) {
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 12 : 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(width: 50, height: 15, decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6)
                  ),),
                  const SizedBox(height: 2,),
                  Container(width: 100, height: 15, decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6)
                  ),),
                ],
              ),
            );
          })
        )
      ),
    );
  }
}