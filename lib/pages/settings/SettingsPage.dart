import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).user;
    if (user == null) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin tài khoản"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => context.go('/settings/edit'), 
            icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: user.Avatar != null ? MemoryImage(user.Avatar!) : const AssetImage("assets/img/user.png") as ImageProvider,
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.Ten ?? "Chưa cập nhập", style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: primary
                        ),),
                        const SizedBox(height: 10,),
                        Text(user.DiaChiEmail ?? "Chưa cập nhập", style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),),
                        const SizedBox(height: 10,),
                        const Text("Quản lý nông trại", style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Thông tin cá nhân", style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.arrowtriangle_down_square)
                  )
                ],
              ),
            ),
            const SizedBox(height: 1,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]
              ),
              child: Column(
                children: [
                  InfoWidget(
                    color: Colors.red,
                    icon: CupertinoIcons.person_fill,
                    label: "Họ tên",
                    value: user.Ten,
                  ),

                  InfoWidget(
                    color: Colors.green,
                    icon: CupertinoIcons.location_fill,
                    label: "Địa chỉ",
                    value: user.DiaChi,
                  ),

                  InfoWidget(
                    color: Colors.brown,
                    icon: CupertinoIcons.phone_fill,
                    label: "Số điện thoại liên hệ",
                    value: user.SDT,
                    border: false,
                  )
                ],
              )
            ),
          ],
        )
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class InfoWidget extends ConsumerWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String? value;
  final bool border;
  const InfoWidget({required this.color, required this.icon, required this.label, required this.value, this.border = true, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: border ? Border(
          bottom:  BorderSide(color: Colors.grey[300]!)
        ) : null
      ),
      child: Row(
        children: [
          Container(
            width: 35, height: 35,
            decoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(color: color),
              shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color)
          ),
          const SizedBox(width: 10,),
          
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 3,),
              Text(value ?? "Chưa cập nhập", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),),
            ],
          )),
        ],
      ),
    );
  }
}