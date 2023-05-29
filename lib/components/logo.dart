import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/config/app.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class Logo extends ConsumerWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.jpg'),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 5,),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(APP_NAME, style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: primary,
            ),),
            Text('Số hóa vùng trồng', style: TextStyle(
              fontSize: 10,
              color: primary
            ),),
          ],
        )
      ],
    );
  }
}