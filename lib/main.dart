import 'package:courier_booking/Courier%20Booking/presentation/theme/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Courier Booking/entities/courier_booking_modal.dart';
import 'Courier Booking/presentation/manager/dashboard_controller.dart';
import 'Courier Booking/presentation/manager/themeController.dart';
import 'Courier Booking/presentation/theme/appColors.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.green,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(CourierBookingModalAdapter());

  await Hive.openBox<CourierBookingModal>(LocalStorage.bookings);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashBoardController()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
