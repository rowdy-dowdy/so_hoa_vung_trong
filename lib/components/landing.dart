import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                    fit: BoxFit.contain,
                  ),
                ),
              ).animate().fade(duration: 500.ms).scale(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    // const Spacer(flex: 1,),
                    Text("Let's start".tr(), style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),).animate().fade(duration: 500.ms).slideY(),
                    const SizedBox(height: 10,),
                    Text('Coming to Bac Ha is not a passing tour but a journey to enjoy the beautiful scenery of the mountains.'.tr(), style: const TextStyle(color: Colors.white),).animate().fade(delay: 300.ms).slideY(),
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
                      child: Text("Join now".tr(), style: const TextStyle(color: primary),),
                    ).animate().fade(delay: 600.ms, duration: 500.ms).slideY(),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text("Do you already have an account?", style: TextStyle(color: Colors.white),).tr(),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: () => ref.read(landingControllerProvider.notifier).gotoLogin(),
                          child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),).tr()
                        ),
                      ],
                    ).animate().fade(delay: 900.ms, duration: 500.ms).slideY(),
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