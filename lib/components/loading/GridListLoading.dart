import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridListLoading extends StatefulWidget {
  const GridListLoading({super.key});

  @override
  State<GridListLoading> createState() => _GridListLoadingState();
}

class _GridListLoadingState extends State<GridListLoading> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Wrap(
          runSpacing: 12,
          spacing: 12,
          children: List.generate(8, (index) {
            return Container(
              width: (width - 36) / 2,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(width: 50, height: 15, decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),),
                  const SizedBox(height: 2,),
                  Container(width: 100, height: 15, decoration: BoxDecoration(
                    color: Colors.white,
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