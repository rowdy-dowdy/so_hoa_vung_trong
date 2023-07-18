import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/expert/topic_controller.dart';
import 'package:so_hoa_vung_trong/models/topic_category_model.dart';
import 'package:so_hoa_vung_trong/models/topic_model.dart';

class TopicAddPage extends ConsumerStatefulWidget {
  const TopicAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopicAddPageState();
}

class _TopicAddPageState extends ConsumerState<TopicAddPage> {
  List<TopicCategoryModel> categories = [];
  late TextEditingController _tieuDeController;
  late TextEditingController _noiDungController;
  bool trangThai = true;
  String selectCategory = "";

  void load() async {
    categories = await ref.read(topicCategoriesProvider.future).onError((error, stackTrace) => []);
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();

    _tieuDeController = TextEditingController();
    _noiDungController = TextEditingController();

    load();
  }

  @override
  void dispose() {
    _tieuDeController.dispose();
    _noiDungController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create a new question").tr(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Title", style: TextStyle(fontWeight: FontWeight.w500),).tr(),
                const SizedBox(width: 3,),
                const Text("*", style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 5,),
            TextFormField(
              controller: _tieuDeController,
              decoration: InputDecoration(
                hintText: 'Enter title'.tr()
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                const Text("Content", style: TextStyle(fontWeight: FontWeight.w500),).tr(),
                const SizedBox(width: 3,),
                const Text("*", style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 5,),
            TextFormField(
              controller: _noiDungController,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter content'.tr()
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                const Text("Category", style: TextStyle(fontWeight: FontWeight.w500),).tr(),
                const SizedBox(width: 3,),
                const Text("*", style: TextStyle(color: Colors.red),),
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
              // isExpanded: true,
              hint: Text(
                'Choose category'.tr(),
                style: const TextStyle(fontSize: 14),
              ),
              items: categories.map((e) => 
                DropdownMenuItem<String>(
                  value: e.Oid,
                  child: Text(
                    e.TenDanhMuc ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select a category.'.tr();
                }
                return null;
              },
              onChanged: (value) {
                selectCategory = value.toString();
              },
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 20,
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                const Text("Status", style: TextStyle(fontWeight: FontWeight.w500),).tr(),
                const SizedBox(width: 3,),
                const Text("*", style: TextStyle(color: Colors.red),),
              ],
            ),
            const SizedBox(height: 5,),
            CupertinoSwitch(
              value: trangThai,
              onChanged: (bool? value) {
                setState(() {
                  trangThai = value ?? false;
                });
              },
            ),
          ],
        ),
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
          child: const Text("Create question").tr(),
        ),
      ),
    );
  }
}