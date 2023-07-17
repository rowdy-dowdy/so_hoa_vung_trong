import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/ExpandedSection.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool infoShow = true;
  bool settingsShow = true;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).user;
    if (user == null) {
      return const Scaffold();
    }

    return Column(
      children: [
        AppBar(
          title: const Text("Account information").tr(),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => context.go('/settings/edit'), 
              icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle)
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: user.Avatar != null ? MemoryImage(user.Avatar!) : const AssetImage("assets/img/user.png") as ImageProvider,
                            fit: BoxFit.contain,
                          )
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.Ten ?? "Not update".tr(), style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: primary
                            ),),
                            const SizedBox(height: 10,),
                            Text(user.DiaChiEmail ?? "Not update".tr(), style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),),
                            const SizedBox(height: 10,),
                            const Text("Farm management", style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),).tr()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Information", style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600
                        ),).tr(),
                      ),
                      IconButton(
                        onPressed: () => setState(() {
                          infoShow = !infoShow;
                        }),
                        icon: Icon(infoShow ? CupertinoIcons.arrowtriangle_down_square : CupertinoIcons.arrowtriangle_up_square)
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 1,),
                ExpandedSection(
                  expand: infoShow,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ]
                    ),
                    child: Column(
                      children: [
                        InfoWidget(
                          color: Colors.red,
                          icon: CupertinoIcons.person_fill,
                          label: "Name".tr(),
                          value: user.Ten,
                        ),
                        
                        InfoWidget(
                          color: Colors.green,
                          icon: CupertinoIcons.location_fill,
                          label: "Address".tr(),
                          value: user.DiaChi,
                        ),
                        
                        InfoWidget(
                          color: Colors.brown,
                          icon: CupertinoIcons.phone_fill,
                          label: "Contact phone number".tr(),
                          value: user.SDT,
                          border: false,
                        )
                      ],
                    )
                  ),
                ),

                const SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Settings", style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600
                        ),).tr(),
                      ),
                      IconButton(
                        onPressed: () => setState(() {
                          settingsShow = !settingsShow;
                        }),
                        icon: Icon(settingsShow ? CupertinoIcons.arrowtriangle_down_square : CupertinoIcons.arrowtriangle_up_square)
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 1,),
                ExpandedSection(
                  expand: settingsShow,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ]
                    ),
                    child: Column(
                      children: [
                        InfoWidget2(
                          color: Colors.red, 
                          icon: CupertinoIcons.bell_solid, 
                          label: "Notifications".tr(),
                          cupertinoSwitch: CupertinoSwitch(
                            // This bool value toggles the switch.
                            value: true,
                            // activeColor: CupertinoColors.activeBlue,
                            onChanged: (bool? value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                // boolValue = value ?? false;
                              });
                            },
                          ),
                        ),
                        InfoWidget2(
                          color: Colors.purple, 
                          icon: Icons.language, 
                          label: "Language".tr(),
                          value: tr('country_names.${context.locale.toString()}'),
                          border: false,
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20)
                              )
                            ), 
                            builder: (context) => const LanguageModal()
                          ),
                        ),
                      ],
                    )
                  ),
                ),

                const SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    onPressed: () => ref.read(authControllerProvider.notifier).logout(), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text("Logout").tr()
                  )
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}

class InfoWidget extends ConsumerWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String? value;
  final bool border;
  const InfoWidget({required this.color, required this.icon, required this.label, required this.value, this.border = true, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: border ? Border(
          bottom:  BorderSide(color: Colors.grey[300]!)
        ) : null
      ),
      child: Row(
        children: [
          Container(
            width: 35, height: 35,
            decoration: BoxDecoration(
              // color: Colors.red,
              border: Border.all(color: color),
              shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color)
          ),
          const SizedBox(width: 10,),
          
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 3,),
              Text(value ?? "Not update".tr(), style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w600
              ),),
            ],
          )),
        ],
      ),
    );
  }
}

class InfoWidget2 extends ConsumerWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String? value;
  final CupertinoSwitch ? cupertinoSwitch;
  final bool border;
  final Function()? onTap;
  const InfoWidget2({required this.color, required this.icon, required this.label, this.value, this.cupertinoSwitch, this.border = true, this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color,),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              height: 42,
              // padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: border ? Border(
                  bottom: BorderSide(color: Colors.grey[300]!)
                ) : null
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(label, style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                  const SizedBox(width: 10,),
                  if (cupertinoSwitch != null) ...[
                    Transform.scale(
                      scale: 0.8,
                      child: cupertinoSwitch!
                    )
                  ],
                  if (value != null) ...[
                    Text(value!, style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(width: 10,),
                    const Icon(CupertinoIcons.right_chevron, color: Colors.grey, size: 18,),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LanguageModal extends ConsumerWidget {
  const LanguageModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Locale> langs = context.supportedLocales;
    String lang = context.locale.toString();
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: IntrinsicHeight(
        child: Column(
          children: [
            const Text("Choose language", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),).tr(),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < langs.length; i++) ...[
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        context.setLocale(Locale(langs[i].toString()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: i < langs.length - 1 ? Border(
                            bottom: BorderSide(color: Colors.grey[300]!)
                          ) : null
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(tr('country_names.${langs[i].toString()}'), style: const TextStyle(
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                            const SizedBox(width: 10,),
                            Icon(CupertinoIcons.check_mark, 
                              color: lang == langs[i].toString() ? Colors.blue : Colors.transparent, 
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
