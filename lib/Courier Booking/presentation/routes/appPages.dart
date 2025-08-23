import 'package:courier_booking/Courier%20Booking/presentation/pages/dashboard.dart';
import 'package:go_router/go_router.dart';

import '../pages/booking_screen.dart';
import '../pages/tracking_page.dart';
import 'appRoutes.dart';

class GoRouterPage {
  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.booking,
    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) {
          return DashBoardPage();
        },
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: AppRoutes.tracking,
        builder: (context, state) => const TrackingScreen(),
      ),
    ],
  );
}
