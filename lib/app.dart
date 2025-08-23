import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Courier Booking/presentation/manager/themeController.dart';
import 'Courier Booking/presentation/routes/appPages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: Platform.isAndroid
          ? MaterialApp.router(
              themeMode: themeProvider.themeMode,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.blue,
                scaffoldBackgroundColor: Colors.grey[100],
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.teal,
                scaffoldBackgroundColor: Colors.grey[900],
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.grey[850],
                  foregroundColor: Colors.white,
                ),
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: GoRouterPage().goRouter,
            )
          : CupertinoApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: GoRouterPage().goRouter,
            ),
    );
  }
}
