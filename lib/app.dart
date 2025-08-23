import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Courier Booking/presentation/manager/dashboard_controller.dart';
import 'Courier Booking/presentation/routes/appPages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Platform.isAndroid
          ? ChangeNotifierProvider(
              create: (context) => DashBoardController(),
              child: MaterialApp.router(
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                routerConfig: GoRouterPage().goRouter,
              ),
            )
          : CupertinoApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: GoRouterPage().goRouter,
            ),
    );
  }
}
