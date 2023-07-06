import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/controllers/router_controller.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  static const menu = <Map>[
    {
      "icon": CupertinoIcons.home,
      "label": "Trang chủ",
      "path": "/",
    },
    {
      "icon": CupertinoIcons.person_2,
      "label": "Chuyên gia",
      "path": "/expert",
    },
    {
      "icon": CupertinoIcons.list_bullet_below_rectangle,
      "label": "Tác vụ",
      "path": "/action",
    },
    {
      "icon": CupertinoIcons.settings,
      "label": "Cá nhân",
      "path": "/settings",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final location = "/${"${GoRouterState.of(context).location}/".split("/")[1]}";
    final currentPageIndex = menu.indexWhere((v) => v['path'] == location);
    final selectedIndex = currentPageIndex < 0 ? 0 : currentPageIndex;

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!))
      ),
      child: NavigationBar(
        destinations: [
          for(var i = 0; i < menu.length; i++) ...[
            NavigationDestination(
              icon: Icon(menu[i]['icon'], color: selectedIndex == i ? Colors.white : Colors.grey[800],), 
              label: menu[i]['label']
            )
          ],
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          // setState(() {
          //   currentPageIndex = index;
          // });
          context.go("${menu[index]['path']}");
        },
        // animationDuration: const Duration(seconds: 1),
        height: 70,
        backgroundColor: Colors.white,
      ),
    );
  }
}