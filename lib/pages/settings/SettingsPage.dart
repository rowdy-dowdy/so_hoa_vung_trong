import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage("assets/img/user.png"),
                        fit: BoxFit.fill,
                      )
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nguyễn Việt Hùng", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: primary
                        ),),
                        const SizedBox(height: 10,),
                        Text("viet.hung.2898@gmail.com", style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),),
                        const SizedBox(height: 10,),
                        Text("Quản lý nông trại", style: TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Text("Thông tin cá nhân", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),),
            ),
            const SizedBox(height: 5,),
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
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]
              ),
              child: Column(
                children: [
                  InfoWidget(
                    color: Colors.red,
                    icon: CupertinoIcons.person_fill,
                    label: "Họ tên",
                    value: "Chưa cập nhập",
                  ),

                  InfoWidget(
                    color: Colors.blue,
                    icon: CupertinoIcons.person_2_alt,
                    label: "Giới tính",
                    value: "Chưa cập nhập",
                  ),

                  InfoWidget(
                    color: Colors.orange,
                    icon: CupertinoIcons.time_solid,
                    label: "Ngày sinh",
                    value: DateFormat("dd/MM,yyyy").format(DateTime.now()),
                  ),

                  InfoWidget(
                    color: Colors.green,
                    icon: CupertinoIcons.location_fill,
                    label: "Địa chỉ",
                    value: "Chưa cập nhập",
                  ),

                  InfoWidget(
                    color: Colors.brown,
                    icon: CupertinoIcons.phone_fill,
                    label: "Số điện thoại liên hệ",
                    value: "Chưa cập nhập",
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
              Text(label, style: TextStyle(
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