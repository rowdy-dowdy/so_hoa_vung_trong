import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/DatePickerCustom.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class DiaryAddPage extends ConsumerStatefulWidget {
  const DiaryAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryAddPageState();
}

class _DiaryAddPageState extends ConsumerState<DiaryAddPage> {
  late TextEditingController _nameDiaryController;
  late TextEditingController _yearDiaryController;
  bool statusDiary = true;

  @override
  void initState() {
    super.initState();
    _nameDiaryController = TextEditingController();
    _yearDiaryController = TextEditingController();
  }

  @override
  void dispose() {
    _nameDiaryController.dispose();
    _yearDiaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thêm mới nhật ký sản xuất"),
          leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(CupertinoIcons.back),
          ),
          bottom: TabBar(
            // isScrollable: true,
            tabs: [
              Tab(text: 'Chi tiết',),
              Tab(text: 'Đất - Cơ sở',),
              Tab(text: 'Thông tin khác',),
            ]
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text("Tên nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: _nameDiaryController,
                          decoration: const InputDecoration(
                            hintText: 'VD: Vụ hè thu'
                          ),
                        ),

                        const SizedBox(height: 20,),

                        const Row(
                          children: [
                            Text("Năm nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: _yearDiaryController,
                          decoration: const InputDecoration(
                            hintText: 'VD: 2023'
                          ),
                        ),

                        const SizedBox(height: 20,),

                        const Row(
                          children: [
                            Text("Trạng thái nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            CupertinoSwitch(
                              value: statusDiary,
                              onChanged: (bool? value) {
                                setState(() {
                                  statusDiary = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(width: 10,),
                            statusDiary ? const Text("Đã hoàn thành") : const Text("Đang xử lý")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text("Tên nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: _nameDiaryController,
                          decoration: const InputDecoration(
                            hintText: 'VD: Vụ hè thu'
                          ),
                        ),

                        const SizedBox(height: 20,),

                        const Row(
                          children: [
                            Text("Năm nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: _yearDiaryController,
                          decoration: const InputDecoration(
                            hintText: 'VD: 2023'
                          ),
                        ),

                        const SizedBox(height: 20,),

                        const Row(
                          children: [
                            Text("Trạng thái nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            CupertinoSwitch(
                              value: statusDiary,
                              onChanged: (bool? value) {
                                setState(() {
                                  statusDiary = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(width: 10,),
                            statusDiary ? const Text("Đã hoàn thành") : const Text("Đang xử lý")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text("Tên nhật ký", style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            Text("*", style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        DatePickerCustom(initialDate: DateTime.now(), onDateSelected: (selectedDate) {
                          print(selectedDate);
                        }, child: Text("data")),

                        InkWell(
                          onTap: () async {
                            final a = await selectDate(context);
                            print(a);
                          },
                          child: const Text("data")
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Thêm mới nhật ký"),
          ),
        ),
      ),
    );
  }
}