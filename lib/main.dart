import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/services/firebase_cloud_messaging.dart';
import 'package:so_hoa_vung_trong/services/theme_data.dart';
import 'package:so_hoa_vung_trong/controllers/router_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // final container = ProviderContainer();
  // // 2. Use it to read the provider 
  // container.read(firebaseCloudMessagingServiceProvider);

  // runApp(UncontrolledProviderScope(
  //   container: container,
  //   child: const MyApp(),
  // ));

  runApp(const ProviderScope(child: MyApp()));
  // initializeDateFormatting()
  //   .then((value) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final appTheme = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Flutter Chat App',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), 
        Locale('vi'), // arabic, no country code
      ],
      theme: appTheme.themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}