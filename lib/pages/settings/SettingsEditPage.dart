import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsEditPage extends ConsumerStatefulWidget {
  const SettingsEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends ConsumerState<SettingsEditPage> {
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa thông tin cá nhân"),
        leading: IconButton(
          onPressed: () => context.go('/settings'),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  // onTap: selectImage,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      shape: BoxShape.circle,
                      // image: file != null ? DecorationImage(
                      //   image: FileImage(File(file!.path)),
                      //   fit: BoxFit.cover
                      // ) : imageUrl != null ? DecorationImage(
                      //   image: NetworkImage(toImage(imageUrl!)),
                      //   fit: BoxFit.cover
                      // ) : null
                    ),
                    child: const Icon(CupertinoIcons.camera, color: Colors.green,),
                    // child: imageUrl != null ? null : const Icon(CupertinoIcons.camera, color: Colors.green,),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text("Thông tin cơ bản", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Container(
                // padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]
                ),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: TextFormField(
                      // controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Họ tên',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                      validator: (value) =>
                        value!.isEmpty ? 'Họ tên không được để trống' : null,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: Container(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          hintText: 'Giới tính',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                        ),
                        items: const [
                          DropdownMenuItem(value: "nam",child: Text("Nam")),
                          DropdownMenuItem(value: "nu",child: Text("Nữ")),
                        ],
                        // value: genderValue,
                        onChanged: (value) {
                          setState(() {
                            // genderValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: TextField(
                      // controller: dateController,
                      readOnly: true,
                      // onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        hintText: 'Ngày sinh',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: TextField(
                      // controller: addressController,
                      decoration: const InputDecoration(
                        hintText: 'Địa chỉ',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      // controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Số điện thoại',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  )
                ]),
              ),
        
              const SizedBox(height: 20,),
              Text("Nâng cao", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Container(
                // padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]
                ),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: TextField(
                      // controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Tài khoản',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      // controller: passwordController,
                      // obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        // suffixIcon: IconButton(
                          // onPressed: () => setState(() {showPassword = !showPassword;}),
                          // icon: Icon(showPassword ? CupertinoIcons.lock_open : CupertinoIcons.lock)
                        // ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}