import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:so_hoa_vung_trong/controllers/home_controller.dart';
import 'package:so_hoa_vung_trong/models/congviec_model.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class DiaryLogEditAddPage extends ConsumerStatefulWidget {
  final String Oid;
  const DiaryLogEditAddPage({required this.Oid, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryLogEditAddPageState();
}

class _DiaryLogEditAddPageState extends ConsumerState<DiaryLogEditAddPage> {
  bool loading = false;
  String? selectCongviec;
  late TextEditingController _ngayLamViecController;
  late TextEditingController _ghiChuController;
  String? selectPhanBon;
  late TextEditingController _luongSuDungPhanController;
  String? selectThuoc;
  late TextEditingController _nongDoPhaLoangController;
  late TextEditingController _luongSuDungThuocController;
  late TextEditingController _thoiGianBatDauController;
  late TextEditingController _thoiGianKetThucController;
  late TextEditingController _tongThoiGianController;
  String? selectMayMoc;
  late TextEditingController _nhienLieuTieuThuController;
  late TextEditingController _sanLuongController;
  late TextEditingController _tacNhanGayHaiController;

  // void loadData(previous, DiaryDetailsDataModel next) async {
  //   if (!next.loading) {
  //     setInitData(next.data);
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // void setInitData(DiaryModel? data) {
  //   if (data == null) return;

  //   _nameController.text = data.TenNhatKy ?? "";
  //   _yearController.text = data.Nam ?? "";
  //   selectedDats = data.Dat_CoSos.fold([], (previousValue, element) => [...previousValue, element.Oid]);
  //   _ngayBatDauController.text = formatTimeToString2(data.NgayBatDau);
  //   _ngayThuHoachController.text = formatTimeToString2(data.NgayThuHoach);
  //   _ngayNuoiTrongController.text = formatTimeToString2(data.NgayNuoiTrong);
  //   _ngayKetThucController.text = formatTimeToString2(data.NgayKetThuc);
  //   _sanLuongController.text = data.SanLuong  ?? "";
  //   _donViTinhController.text = data.DonViSanLuong?.type ?? "";
  //   _ghiChuController.text = data.GhiChu ?? "";
  // }

  @override
  void initState() {
    super.initState();
    _ngayLamViecController = TextEditingController();
    _ghiChuController = TextEditingController();
    _luongSuDungPhanController = TextEditingController();
    _nongDoPhaLoangController = TextEditingController();
    _luongSuDungThuocController = TextEditingController();
    _thoiGianBatDauController = TextEditingController();
    _thoiGianKetThucController = TextEditingController();
    _tongThoiGianController = TextEditingController();
    _nhienLieuTieuThuController = TextEditingController();
    _sanLuongController = TextEditingController();
    _tacNhanGayHaiController = TextEditingController();

    // if (widget.Oid != "") {
    //   final diary = ref.read(diaryDetailsControllerProvider(widget.Oid));

    //   if (diary.loading) {
    //     setState(() {
    //       loading = true;
    //     });
    //   }
    //   else {
    //     setInitData(diary.data);
    //   }
    // }
  }

  @override
  void dispose() {
    _ngayLamViecController.dispose();
    _ghiChuController.dispose();
    _luongSuDungPhanController.dispose();
    _nongDoPhaLoangController.dispose();
    _luongSuDungThuocController.dispose();
    _thoiGianBatDauController.dispose();
    _thoiGianKetThucController.dispose();
    _tongThoiGianController.dispose();
    _nhienLieuTieuThuController.dispose();
    _sanLuongController.dispose();
    _tacNhanGayHaiController.dispose();
    super.dispose();
  }

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
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(builder: (context, ref, child) {
                        final datCosoData = ref.watch(congViecControllerProvider);

                        if (datCosoData.loading) {
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text("Công việc - Tình trạng", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                hint: const Text(
                                  'Chọn công việc',
                                  style: TextStyle(fontSize: 14),
                                ),
                                items: datCosoData.data.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.Oid,
                                    child: Text(
                                      item.TenCongViec ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Vui lòng chọn công việc.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  selectCongviec = value.toString();
                                },
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 20,
                                ),
                                // value: selectedCongViecs.isEmpty ? null : selectedCongViecs.last,
                                dropdownStyleData: DropdownStyleData(
                                  offset: const Offset(0, -10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20,),

                            const Row(
                              children: [
                                Text("Ngày bắt đầu", style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(width: 3,),
                                Text("*", style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            TextField(
                              controller: _ngayLamViecController,
                              readOnly: true,
                              onTap: () async {
                                DateTime initialDate;
                                try {
                                  initialDate = DateFormat("dd/MM/yyyy").parse(_ngayLamViecController.text);
                                } catch (e) {
                                  initialDate = DateTime.now();
                                }
                                DateTime? picked = await selectDate(context, initialDate);
                                
                                if (picked != null) {
                                  _ngayLamViecController.text = DateFormat("dd/MM/yyyy").format(picked);
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nhập ngày bắt đầu'
                              ),
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
                        );
                      },)
                    ],
                  ),
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ]
                  )
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ]
                  )
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ]
                  )
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ]
                  )
                )
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