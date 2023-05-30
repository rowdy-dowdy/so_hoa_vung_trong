import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/components/expert/ListExpert.dart';
import 'package:so_hoa_vung_trong/components/expert/ListTopic.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class ExpertPage extends ConsumerStatefulWidget {
  const ExpertPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpertPageState();
}

class _ExpertPageState extends ConsumerState<ExpertPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[primary, second]),
          ),
        ),
        title: const Text("Trao đổi với chuyên gia", style: TextStyle(color: Colors.white),),
      ),
      body:  Column(
        children: [
          Container(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12
                // color: Color.fromARGB(255, 202, 202, 202)
              ),
              child: TabBar(
                controller: tabController,
                
                tabs: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    child: const Text("Chủ đề", style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    child: const Text("Chuyên gia", style: TextStyle(fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                ListTopic(),
                ListExpert(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}