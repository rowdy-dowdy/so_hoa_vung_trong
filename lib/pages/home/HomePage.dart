import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/components/BottomBar.dart';
import 'package:so_hoa_vung_trong/components/Logo.dart';
import 'package:so_hoa_vung_trong/components/loading/HomeListLoading.dart';
import 'package:so_hoa_vung_trong/controllers/diary/diary_controller.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/pages/home/nguyen-lieu/NguyenLieuDetailsPage.dart';
import 'package:so_hoa_vung_trong/pages/home/phan-bon/PhanBonDetailsPage.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<HomePage> {

  String getCurrentDay() {
    return DateFormat.EEEE(context.locale.toString()).format(DateTime.now());
  }

  String getCurrentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final diaryData = ref.watch(diaryControllerProvider);
    final nguyenLieuData = ref.watch(nguyenLieuControllerProvider);
    final phanBonData = ref.watch(phanBonControllerProvider);
    final thietBiData = ref.watch(listThietBiProvider);
    final thuocData = ref.watch(listThuocProvider);

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Container(
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(getCurrentDay(), style: const TextStyle(fontSize: 14),),
                    Text(getCurrentDate(), style: const TextStyle(fontSize: 14),)
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(diaryControllerProvider);
                  ref.invalidate(nguyenLieuControllerProvider);
                  ref.invalidate(phanBonControllerProvider);
                  ref.invalidate(listThietBiProvider);
                  ref.invalidate(listThuocProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                        onPressed: () => context.go('/diary/edit-add'), 
                                        icon: const Icon(CupertinoIcons.add, color: Colors.white,),
                                        label: const Text("Thêm mới", style: TextStyle(color: Colors.white),),
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
                                    onTap: () => context.go('/diary/edit-add'),
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
                                          Text(diary.TenNhatKy ?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                          const SizedBox(height: 2,),
                                          Text(diary.NgayBatDau != null ? DateFormat("dd/MM/yyyy").format(diary.NgayBatDau!) : "", style: const TextStyle(
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
                  
                        // nguyen lieu
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nguyên vật liệu", style: TextStyle(fontWeight: FontWeight.w500),),
                              TextButton(
                                onPressed: () => context.go('/nguyen-lieu'), 
                                child: const Text("Xem thêm")
                              )
                            ],
                          ),
                        ),
                        Consumer(builder: (context, ref, child) {
                          if (nguyenLieuData.loading) {
                            return const HomeListLoading();
                          }
        
                          if (nguyenLieuData.data.isEmpty) {
                            return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: const Text("Không có nguyên liệu nào")
                            );
                          }
        
                          final int dataLength = nguyenLieuData.data.length < 4 ? nguyenLieuData.data.length : 4;
        
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                            child: ListView.separated(
                              itemCount: dataLength,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => const SizedBox(width: 10,),
                              itemBuilder: (context, index) {
                                final item = nguyenLieuData.data[index];
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => NguyenLieuDetailsPage(Oid: item.Oid)
                                    ),
                                  ),
                                  child: Container(
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/nguyen_lieu.jpg") as ImageProvider,
                                        fit: BoxFit.cover
                                      )
                                    ),
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 12 : 0,
                                      right: index == (dataLength - 1) ? 12 : 0,
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
                                          Text(item.TenNguyenLieu?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                          const SizedBox(height: 2,),
                                          Text(formatCurrency(context, item.Gia), style: const TextStyle(
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
        
                        // phanbon
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Phân bón", style: TextStyle(fontWeight: FontWeight.w500),),
                              TextButton(
                                onPressed: () => context.go('/phan-bon'), 
                                child: const Text("Xem thêm")
                              )
                            ],
                          ),
                        ),
                        Consumer(builder: (context, ref, child) {
                          if (phanBonData.loading) {
                            return const HomeListLoading();
                          }
        
                          if (phanBonData.data.isEmpty) {
                            return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: const Text("Không có phân bón nào")
                            );
                          }
        
                          final int dataLength = phanBonData.data.length < 4 ? phanBonData.data.length : 4;
        
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                            child: ListView.separated(
                              itemCount: dataLength,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => const SizedBox(width: 10,),
                              itemBuilder: (context, index) {
                                final item = phanBonData.data[index];
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => PhanBonDetailsPage(Oid: item.Oid)
                                    ),
                                  ),
                                  child: Container(
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/phan_bon.jpg") as ImageProvider,
                                        fit: BoxFit.cover
                                      )
                                    ),
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 12 : 0,
                                      right: index == (dataLength - 1) ? 12 : 0,
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
                                          Text(item.TenPhanBon?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                          const SizedBox(height: 2,),
                                          Text(formatCurrency(context, item.Gia), style: const TextStyle(
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
                        
                        // thiet bi
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                          child: const Text("Thiết bị - Máy móc", style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        thietBiData.when(
                          skipLoadingOnRefresh: false,
                          data: (data) {
                            if (data.isEmpty) {
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                child: const Text("Không có thiết bị - máy móc nào")
                              );
                            }
        
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              child: ListView.separated(
                                itemCount: data.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => const SizedBox(width: 10,),
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return InkWell(
                                    // onTap: () => context.go('/${item.Oid}'),
                                    child: Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: primary.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/nguyen_lieu.jpg") as ImageProvider,
                                          fit: BoxFit.cover
                                        )
                                      ),
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 12 : 0,
                                        right: index == data.length ? 12 : 0,
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
                                            Text(item.TenThietBi?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                            const SizedBox(height: 2,),
                                            Text("Hạn sử dụng: ${formatTimeToString2(item.ThoiHanSuDung)}", style: const TextStyle(
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
                          },
                          loading: () => const HomeListLoading(),
                          error: (_, __) => Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: const Text("Không thể tải thiết bị - máy móc")
                          )
                        ),
        
                        const SizedBox(height: 10,),
                        
                        // Thuoc BVTV
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 12, right:12, top: 10),
                          child: const Text("Thuốc bảo vệ thực vật", style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        thuocData.when(
                          skipLoadingOnRefresh: false,
                          data: (data) {
                            if (data.isEmpty) {
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                child: const Text("Không có thuốc BVTV nào")
                              );
                            }
        
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              child: ListView.separated(
                                itemCount: data.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => const SizedBox(width: 10,),
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return InkWell(
                                    // onTap: () => context.go('/${item.Oid}'),
                                    child: Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: primary.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: item.HinhAnh != null ? MemoryImage(item.HinhAnh!) : const AssetImage("assets/img/nguyen_lieu.jpg") as ImageProvider,
                                          fit: BoxFit.cover
                                        )
                                      ),
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 12 : 0,
                                        right: index == data.length ? 12 : 0,
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
                                            Text(item.TenThuoc ?? "", style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                                            const SizedBox(height: 2,),
                                            Text(formatCurrency(context, item.Gia), style: const TextStyle(
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
                          },
                          loading: () => const HomeListLoading(),
                          error: (_, __) => Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: const Text("Không thể tải thuốc BVTV")
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}