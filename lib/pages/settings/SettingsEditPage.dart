import 'package:easy_localization/easy_localization.dart';
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
        title: const Text("Edit information").tr(),
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
              Text("Basic information", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),).tr(),
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
                      offset: const Offset(0, 1), // changes position of shadow
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
                      decoration: InputDecoration(
                        hintText: 'Name'.tr(),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                      validator: (value) =>
                        value!.isEmpty ? "Name can't be left blank".tr() : null,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!)
                    )),
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Gender'.tr(),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                        ),
                        items: [
                          DropdownMenuItem(value: "nam",child: const Text("Man").tr()),
                          DropdownMenuItem(value: "nu",child: const Text("Woman").tr()),
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
                      decoration: InputDecoration(
                        hintText: 'Birthday'.tr(),
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
                      decoration: InputDecoration(
                        hintText: 'Address'.tr(),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      // controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone'.tr(),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      ),
                    ),
                  )
                ]),
              ),
        
              const SizedBox(height: 20,),
              Text("Advanced", style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),).tr(),
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
                      offset: const Offset(0, 1), // changes position of shadow
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
                      decoration: InputDecoration(
                        hintText: 'Account'.tr(),
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
                        hintText: 'Password'.tr(),
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