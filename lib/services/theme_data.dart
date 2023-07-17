// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/utils/colors.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme({
    required this.themeData,
  });
}

final appThemeProvider = Provider<AppTheme>((ref) {
  return AppTheme(themeData: ThemeData(
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: primary,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      }
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xfff0f2f5),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      titleTextStyle:  TextStyle(
        color: primary,
        fontSize: 16, 
        fontWeight: FontWeight.w600
      ),
      iconTheme: IconThemeData(
        size: 20,
        color: primary
      ),
    ),
    primaryColor: primary,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // backgroundColor: primary2,
        minimumSize: const Size(double.infinity, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: primary,
        foregroundColor : Colors.white,
      ),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     // foregroundColor: primary
    //   )
    // ),
    textTheme: const TextTheme(
      // bodyMedium: TextStyle(color: Colors.grey[900]!),
    ),
    // iconTheme: IconThemeData(
    //   color: Colors.grey[900]
    // ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey[700]),
      floatingLabelStyle: const TextStyle(color: primary),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(6)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(6)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(6)
      ),
      
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.0),
    ),
    // tabBarTheme: TabBarTheme(
    //   labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //   indicatorColor: Colors.transparent,
    //   dividerColor: Colors.transparent,
    //   indicatorSize: TabBarIndicatorSize.label,
    //   indicator: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2),
    //         spreadRadius: 1,
    //         blurRadius: 5,
    //         offset: const Offset(0, 1), // changes position of shadow
    //       ),
    //     ]
    //   ),
    //   labelColor: primary,
    //   unselectedLabelColor: Colors.black,
    // ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: primary,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
      ),
      elevation: 0,
    ),
  ));
});