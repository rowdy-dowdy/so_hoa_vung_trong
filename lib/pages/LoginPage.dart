import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  const Text("Chào mừng quay trở lại! 👋", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 5,),
                  const Text("Xin chào một lần nữa, bạn có bị bỏ lỡ", style: TextStyle(
                    color: grey,
                  ),),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 300,
                                child: Lottie.asset(
                                  'assets/lotties/login.json',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text("Tài khoản", style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập tài khoản của bạn'
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text("Mật khẩu", style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5),
                          TextField(
                            controller: passwordController,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              hintText: 'Nhập mật khẩu',
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
                              const Text("Ghi nhớ tôi", style: TextStyle(fontWeight: FontWeight.w500),),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text("Quên mật khẩu?")
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: loading ? null : signInWithPassword,
                            child: loading ? const CircularProgressIndicator() : const Text("Login"),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Số hóa vùng trồng", textAlign: TextAlign.center, style: TextStyle(color: grey),)
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