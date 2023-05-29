import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/landing_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class Landing extends ConsumerStatefulWidget {
  const Landing({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF39b68e), Color(0xFF02756e)]
          ),
        ),
        child: Column(
          children: [
            Flexible(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: size.height / 2
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/landing.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    // const Spacer(flex: 1,),
                    const Text("Hãy bắt đầu", style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 10,),
                    const Text('Đến với Bắc Hà không phải là cuộc rong chơi lướt qua mà là một hành trình tận hưởng cảnh đẹp núi rừng.', style: TextStyle(color: Colors.white),),
                    const Spacer(flex: 2,),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () => ref.read(landingControllerProvider.notifier).gotoLogin(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text("Tham gia ngay", style: TextStyle(color: primary),),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text("Bạn đã có tài khoản?", style: TextStyle(color: Colors.white),),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: () => ref.read(landingControllerProvider.notifier).gotoLogin(),
                          child: const Text("Đăng nhập", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}