import 'package:courier_booking/Courier%20Booking/presentation/pages/dashboard.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/custom_page_animation.dart';
import 'package:go_router/go_router.dart';

import '../pages/booking_screen.dart';
import '../pages/splash_screen.dart';
import '../pages/tracking_page.dart';
import 'appRoutes.dart';

class GoRouterPage {
  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            buildCustomTransitionPage(state: state, child: SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        pageBuilder: (context, state) =>
            buildCustomTransitionPage(state: state, child: DashBoardPage()),
      ),
      GoRoute(
        path: AppRoutes.booking,
        pageBuilder: (context, state) =>
            buildCustomTransitionPage(state: state, child: BookingScreen()),
      ),
      GoRoute(
        path: AppRoutes.tracking,
        pageBuilder: (context, state) =>
            buildCustomTransitionPage(state: state, child: TrackingScreen()),
      ),
    ],
  );
}
