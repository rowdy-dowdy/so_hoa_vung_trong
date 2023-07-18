import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/pages/action/ActionPage.dart';
import 'package:so_hoa_vung_trong/pages/expert/ExpertPage.dart';
import 'package:so_hoa_vung_trong/pages/home/HomePage.dart';
import 'package:so_hoa_vung_trong/pages/settings/SettingsPage.dart';

class MainPage extends ConsumerStatefulWidget {
  final String path;
  const MainPage({required this.path, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int currentPageIndex = 0;

  late List<Map<String, dynamic>> menu;

  void changePage(String? path) {
    int index = menu.indexWhere((element) => element['path'] == (path ?? widget.path));
    if (index < 0) {
      index = 0;
    }

    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    menu = [
      {
        "icon": CupertinoIcons.home,
        "label": "Home",
        "path": "/",
        "page": const HomePage(),
      },
      {
        "icon": CupertinoIcons.person_2,
        "label": "Expert",
        "path": "/expert",
        "page": const ExpertPage(),
      },
      {
        "icon": CupertinoIcons.list_bullet_below_rectangle,
        "label": "Action",
        "path": "/action",
        "page": ActionPage(changePageCallback: changePage),
      },
      {
        "icon": CupertinoIcons.settings,
        "label": "Personal",
        "path": "/settings",
        "page": const SettingsPage(),
      }
    ];

    changePage(null);
  }

  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // changePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: menu.map((e) => 
          e['page'] as Widget
        ).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!))
        ),
        child: NavigationBar(
          destinations: menu.mapIndexed((i, e) => 
            NavigationDestination(
              icon: Icon(e['icon'], color: currentPageIndex == i ? Colors.white : Colors.grey[800],), 
              label: tr(e['label'])
            )
          ).toList(),
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
            // context.go("${menu[index]['path']}");
          },
          animationDuration: const Duration(milliseconds: 100),
          height: 70,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}