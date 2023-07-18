import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/components/Landing.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/controllers/landing_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool showPassword = false;
  bool rememberMe = true;

  void signInWithPassword() async {
    if (loading) {
      return;
    }

    setState(() {
      loading = true;
    });

    await ref.read(authControllerProvider.notifier).signInWithPassword(
      context,
      emailController.text, 
      passwordController.text,
      rememberMe
    );

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Consumer(
      builder: (context, ref, child) {
        final landing = ref.watch(landingControllerProvider);

        if (landing.loading) return const SizedBox();

        if (landing.firstRunApp) {
          return const Landing();
        }

        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              constraints: BoxConstraints(
                minHeight: size.height,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 50,),
                  const Text("Welcome back! 👋", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),).tr().animate().fade(duration: 500.ms).slideY(begin: 2),
                  const SizedBox(height: 5,),
                  const Text("Hello again, did you miss", style: TextStyle(
                    color: grey,
                  ),).tr().animate().fade(delay: 200.ms, duration: 500.ms).slideY(begin: 2),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 300,
                                child: Lottie.asset(
                                  'assets/lotties/login.json',
                                ),
                              ).animate().fade(delay: 400.ms, duration: 500.ms).scale(),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text("Account", style: TextStyle(
                                fontWeight: FontWeight.w500
                              ),).tr(),
                              const SizedBox(height: 5),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your account'.tr()
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text("Password", style: TextStyle(
                                fontWeight: FontWeight.w500
                              ),).tr(),
                              const SizedBox(height: 5),
                              TextField(
                                controller: passwordController,
                                obscureText: !showPassword,
                                decoration: InputDecoration(
                                  hintText: 'Enter password'.tr(),
                                  suffixIcon: IconButton(
                                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off,
                                      color: primary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CupertinoCheckbox(
                                      activeColor: primary,
                                      // title: Text("title text"),
                                      value: rememberMe,
                                      onChanged: (newValue) {
                                        setState(() {
                                          rememberMe = newValue ?? false;
                                        });
                                      },
                                      
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  const Text("Remember me", style: TextStyle(fontWeight: FontWeight.w500),).tr(),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("Forgot password?").tr()
                                  )
                                ],
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: loading ? null : signInWithPassword,
                                child: loading ? const CircularProgressIndicator() : const Text("Login"),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ].animate(interval: 100.ms, delay: 600.ms).fade(duration: 500.ms).slideY(begin: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: const Text("Digitizing planting areas", 
                      textAlign: TextAlign.center, 
                      style: TextStyle(color: grey),
                    ).tr().animate().fade(delay: 800.ms, duration: 500.ms).slideY(begin: 2),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}