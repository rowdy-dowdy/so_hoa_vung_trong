import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/components/Logo.dart';
import 'package:so_hoa_vung_trong/components/loading/HomeListLoading.dart';
import 'package:so_hoa_vung_trong/controllers/diary/diary_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<HomePage> {

  String getCurrentDay() {
    return DateFormat.EEEE('vi').format(DateTime.now());
  }

  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final diaryData = ref.watch(diaryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarHeight: 120,
        flexibleSpace: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Logo(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(getCurrentDay()),
                  Text(getCurrentDate())
                ],
              )
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.wait([
                ref.watch(diaryControllerProvider.notifier).loadData(),
              ]);
            },
            child: SingleChildScrollView(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Nhật ký đã nhập gần đây"),
                          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Consumer(builder: (context, ref, child) {
                      if (diaryData.loading) {
                        return const HomeListLoading();
                      }
              
                      if (diaryData.data.isEmpty) {
                        return Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Row(
                            children: [
                              const Text("Chưa có Nhật ký nào", style: TextStyle(fontWeight: FontWeight.w500),),
                              const Spacer(),
                              Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          colors: [primary, second],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => context.go('/diary/add'), 
                                    icon: Icon(CupertinoIcons.add, color: Colors.white,),
                                    label: Text("Thêm mới", style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
              
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: ListView.separated(
                          itemCount: diaryData.data.length + 1,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(width: 10,),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return InkWell(
                                onTap: () => context.go('/diary/add'),
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: second,
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  margin: EdgeInsets.only(
                                    left: index == 0 ? 12 : 0,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.add, color: Colors.white,),
                                      Text("Tạo nhật ký mới", style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                ),
                              );
                            }
              
                            final diary = diaryData.data[index - 1];
              
                            return InkWell(
                              onTap: () => context.go('/diary/${diary.Oid}'),
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(6),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/img/diary2.jpg"),
                                    fit: BoxFit.cover
                                  )
                                ),
                                margin: EdgeInsets.only(
                                  right: index == diaryData.data.length ? 12 : 0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.black.withOpacity(0.6),
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0),
                                        Colors.black.withOpacity(0),
                                      ],
                                    )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(diary.TenNhatKy ?? "", style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                      const SizedBox(height: 2,),
                                      Text(diary.NgayBatDau != null ? DateFormat("dd/mm/yyyy").format(diary.NgayBatDau!) : "", style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },),
                    const SizedBox(height: 10,),
              
                    // san pham
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                      child: const Text("Loại cây trồng", style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      child: ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            margin: EdgeInsets.only(
                              left: index == 0 ? 12 : 0,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Vụ hè 2012", style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 2,),
                                Text(DateFormat("dd/mm/yyyy").format(DateTime.now()), style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                ),),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              
                    
                    const SizedBox(height: 10,),
                    // san pham
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                      child: const Text("Phân bón", style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      child: ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(width: 10,),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(6)
                            ),
                            margin: EdgeInsets.only(
                              left: index == 0 ? 12 : 0,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Vụ hè 2012", style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 2,),
                                Text(DateFormat("dd/mm/yyyy").format(DateTime.now()), style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                ),),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}