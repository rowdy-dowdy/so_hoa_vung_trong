// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class TimeLineTop extends ConsumerStatefulWidget {
  final double strokeWidth = 1;
  final Color strokeColor = Colors.grey;
  final double size = 14;
  final double gap = 10;
  final List<Widget> children;
  final List<Widget> indicators;
  const TimeLineTop({required this.children, required this.indicators, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeLineTopState();
}

class _TimeLineTopState extends ConsumerState<TimeLineTop> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        return Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: widget.size,
                    child: Column(
                      children: [
                        Expanded(child: Container(width: widget.strokeWidth, color: widget.strokeColor,)),
                        Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            shape: BoxShape.circle
                          ),
                        ),
                        Expanded(child: Container(width: widget.strokeWidth, color: widget.strokeColor,)),
                      ],
                    ),
                  ),
                  SizedBox(width: widget.gap,),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 13),
                    child: widget.indicators[index])
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: widget.size,
                    child: Center(
                      child: Container(
                        width: widget.strokeWidth, 
                        color: widget.strokeColor,
                        // margin: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ),
                  SizedBox(width: widget.gap,),
                  Expanded(child: widget.children[index])
                ],
              ),
            )
          ],
        );
      },
    );
  }
}