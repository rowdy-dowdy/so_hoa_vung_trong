import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/controllers/diary/diary_details_controller.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/models/dat_model.dart';
import 'package:so_hoa_vung_trong/models/diary_model.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

class DiaryEditAddPage extends ConsumerStatefulWidget {
  final String Oid;
  const DiaryEditAddPage({required this.Oid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryEditAddPageState();
}

class _DiaryEditAddPageState extends ConsumerState<DiaryEditAddPage> {
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  bool statusDiary = true;
  List<String> selectedDats = [];
  late TextEditingController _ngayBatDauController;
  late TextEditingController _ngayThuHoachController;
  late TextEditingController _ngayNuoiTrongController;
  late TextEditingController _ngayKetThucController;
  late TextEditingController _sanLuongController;
  late TextEditingController _donViTinhController;
  late TextEditingController _ghiChuController;

  bool loading = false;

  void loadData(previous, DiaryDetailsDataModel next) async {
    if (!next.loading) {
      setInitData(next.data);
      setState(() {
        loading = false;
      });
    }
  }

  void setInitData(DiaryModel? data) {
    if (data == null) return;

    _nameController.text = data.TenNhatKy ?? "";
    _yearController.text = data.Nam ?? "";
    selectedDats = data.Dat_CoSos.fold([], (previousValue, element) => [...previousValue, element.Oid]);
    _ngayBatDauController.text = formatTimeToString2(data.NgayBatDau);
    _ngayThuHoachController.text = formatTimeToString2(data.NgayThuHoach);
    _ngayNuoiTrongController.text = formatTimeToString2(data.NgayNuoiTrong);
    _ngayKetThucController.text = formatTimeToString2(data.NgayKetThuc);
    _sanLuongController.text = data.SanLuong  ?? "";
    _donViTinhController.text = data.DonViSanLuong?.type ?? "";
    _ghiChuController.text = data.GhiChu ?? "";
  }

  String findNameDat() {
    int i = 0;
    return selectedDats.fold("", (previousValue, element) {
      String name = ref.watch(datControllerProvider).data.firstWhere((e) => e.Oid == element).TenDatCoSo ?? "";
      if (i > 0) {
        previousValue += ", ";
      }
      i++;
      return previousValue += name;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _yearController = TextEditingController();
    _ngayBatDauController = TextEditingController();
    _ngayThuHoachController = TextEditingController();
    _ngayNuoiTrongController = TextEditingController();
    _ngayKetThucController = TextEditingController();
    _sanLuongController = TextEditingController();
    _donViTinhController = TextEditingController();
    _ghiChuController = TextEditingController();

    if (widget.Oid != "") {
      final diary = ref.read(diaryDetailsControllerProvider(widget.Oid));

      if (diary.loading) {
        setState(() {
          loading = true;
        });
      }
      else {
        setInitData(diary.data);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    _ngayBatDauController.dispose();
    _ngayThuHoachController.dispose();
    _ngayNuoiTrongController.dispose();
    _ngayKetThucController.dispose();
    _sanLuongController.dispose();
    _donViTinhController.dispose();
    _ghiChuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(diaryDetailsControllerProvider(widget.Oid), loadData);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: widget.Oid != "" ? const Text("Chỉnh sửa nhật ký sản xuất") : const Text("Thêm mới nhật ký sản xuất"),
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(CupertinoIcons.back),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: const TabBar(
                tabs: [
                  Tab(text: 'Chi tiết',),
                  Tab(text: 'Đất - Cơ sở',),
                  Tab(text: 'Thông tin khác',),
                ]
              ),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                TabBarView(
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
                              controller: _nameController,
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
                              controller: _yearController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                        child: Consumer(
                          builder: (context, ref, child) {
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
                          }
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
                                Text("Ngày bắt đầu", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ngayBatDauController,
                              readOnly: true,
                              onTap: () async {
                                DateTime initialDate;
                                try {
                                  initialDate = DateFormat("dd/MM/yyyy").parse(_ngayBatDauController.text);
                                } catch (e) {
                                  initialDate = DateTime.now();
                                }
                                DateTime? picked = await selectDate(context, initialDate);
                                
                                if (picked != null) {
                                  _ngayBatDauController.text = DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nhập ngày bắt đầu'
                              ),
                            ),

                            const SizedBox(height: 20,),

                            const Row(
                              children: [
                                Text("Ngày kết thúc", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ngayKetThucController,
                              readOnly: true,
                              onTap: () async {
                                DateTime initialDate;
                                try {
                                  initialDate = DateFormat("dd/MM/yyyy").parse(_ngayKetThucController.text);
                                } catch (e) {
                                  initialDate = DateTime.now();
                                }
                                DateTime? picked = await selectDate(context, initialDate);
                                
                                if (picked != null) {
                                  _ngayKetThucController.text = DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nhập ngày kết thúc'
                              ),
                            ),

                            const SizedBox(height: 20,),

                            const Row(
                              children: [
                                Text("Ngày nuôi trồng", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ngayNuoiTrongController,
                              readOnly: true,
                              onTap: () async {
                                DateTime initialDate;
                                try {
                                  initialDate = DateFormat("dd/MM/yyyy").parse(_ngayNuoiTrongController.text);
                                } catch (e) {
                                  initialDate = DateTime.now();
                                }
                                DateTime? picked = await selectDate(context, initialDate);
                                
                                if (picked != null) {
                                  _ngayNuoiTrongController.text = DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nhập ngày nuôi trồng'
                              ),
                            ),

                            const SizedBox(height: 20,),

                            const Row(
                              children: [
                                Text("Ngày thu hoạch", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ngayThuHoachController,
                              readOnly: true,
                              onTap: () async {
                                DateTime initialDate;
                                try {
                                  initialDate = DateFormat("dd/MM/yyyy").parse(_ngayThuHoachController.text);
                                } catch (e) {
                                  initialDate = DateTime.now();
                                }
                                DateTime? picked = await selectDate(context, initialDate);
                                
                                if (picked != null) {
                                  _ngayThuHoachController.text = DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nhập ngày thu hoạch'
                              ),
                            ),

                            const SizedBox(height: 20,),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Sản lượng", style: TextStyle(fontWeight: FontWeight.w500),),
                                          SizedBox(width: 3,),
                                          Text("*", style: TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      TextField(
                                        controller: _sanLuongController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: 'Nhập ngày thu hoạch'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Đơn vị", style: TextStyle(fontWeight: FontWeight.w500),),
                                          SizedBox(width: 3,),
                                          Text("*", style: TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.only(top: 12, bottom: 12.0, right: 10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Chọn đơn vị',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: DonViEnum.values.fold([], (arr, item) {
                                          if (item.type != '') {
                                            arr.add(DropdownMenuItem<String>(
                                              value: item.type,
                                              child: Text(
                                                donViToString(item),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ));
                                          }
                                          return arr;
                                        }),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20,),
                            const Row(
                              children: [
                                Text("Ghi chú", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ghiChuController,
                              keyboardType: TextInputType.multiline,
                              minLines: 4,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Nhập ghi chú'
                              ),
                            ),
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
            );
          }
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
            child: const Text("Lưu nhật ký"),
          ),
        ),
      ),
    );
  }
}