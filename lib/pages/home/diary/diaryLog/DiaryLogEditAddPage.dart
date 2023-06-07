import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class DiaryLogEditAddPage extends ConsumerStatefulWidget {
  final String Oid;
  const DiaryLogEditAddPage({required this.Oid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryLogEditAddPageState();
}

class _DiaryLogEditAddPageState extends ConsumerState<DiaryLogEditAddPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primary, second]),
            ),
          ),
          title: widget.Oid != "" 
            ? const Text("Chỉnh sửa chi tiết nhật ký", style: TextStyle(color: Colors.white),) 
            : const Text("Thêm mới chi tiết nhật ký", style: TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(CupertinoIcons.back, color: Colors.white,),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black87,
            isScrollable: true,
            tabs: [
              Tab(text: 'Chi tiết',),
              Tab(text: 'Bón phân',),
              Tab(text: 'Sử dụng thuốc',),
              Tab(text: 'Thời gian làm việc',),
              Tab(text: 'Thông tin khác',),
            ]
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final datCosoData = ref.watch(datControllerProvider);

                          if (datCosoData.loading) {
                            return const Center(child: CircularProgressIndicator(),);
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text("Đất - Cơ sở", style: TextStyle(fontWeight: FontWeight.w500),),
                                  SizedBox(width: 3,),
                                  Text("*", style: TextStyle(color: Colors.red),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  isExpanded: true,
                                  hint: const Text(
                                    'Chọn đất',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  items: datCosoData.data.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.Oid,
                                      //disable default onTap to avoid closing menu when selecting an item
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) {
                                          final _isSelected = selectedDats.contains(item.Oid);
                                          return InkWell(
                                            onTap: () {
                                              _isSelected
                                                ? selectedDats.remove(item.Oid)
                                                : selectedDats.add(item.Oid);
                                              //This rebuilds the StatefulWidget to update the button's text
                                              setState(() {});
                                              //This rebuilds the dropdownMenu Widget to update the check mark
                                              menuSetState(() {});
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  _isSelected
                                                    ? const Icon(Icons.check_box_outlined)
                                                    : const Icon(Icons.check_box_outline_blank),
                                                  const SizedBox(width: 16),
                                                  Text(
                                                    item.TenDatCoSo ?? "",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Vui lòng chọn đơn vị.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _donViTinhController.text = value.toString();
                                  },
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 20,
                                  ),
                                  value: selectedDats.isEmpty ? null : selectedDats.last,
                                  selectedItemBuilder: (context) {
                                    return datCosoData.data.map((item) {
                                        return Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                          child: Text(
                                            findNameDat(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            loading ? Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(.7),
                child: const Center(child: CircularProgressIndicator(),),
              ),
            ) : const SizedBox()
          ],
        ),
        bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[300]!)
          )
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Lưu chi tiết nhật ký"),
        ),
      ),
      ),
    );
  }
}