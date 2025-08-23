import 'package:courier_booking/Courier%20Booking/presentation/routes/appRoutes.dart';
import 'package:courier_booking/Courier%20Booking/presentation/theme/appColors.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../manager/dashboard_controller.dart';
import '../widgets/dashboard_widget/booking_card_widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courier App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Navigation Buttons
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.ogbackgroundcolor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.w,
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRoutes.booking),
                      style: ElevatedButton.styleFrom(
                        // padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Book Courier'),
                    ),
                  ),
                  15.height,
                  SizedBox(
                    width: 300.w,
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRoutes.tracking),
                      style: ElevatedButton.styleFrom(
                        // padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Track Shipment'),
                    ),
                  ),
                ],
              ),
            ),

            20.height,
            const Text(
              'Recent Bookings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// ListView of order details
            Expanded(
              child: Consumer<DashBoardController>(
                builder: (context, provider, child) {
                  if (provider.bookings.isEmpty) {
                    return const Center(child: Text('No bookings yet'));
                  }
                  return ListView.builder(
                    itemCount: provider.bookings.length,
                    itemBuilder: (context, index) {
                      final booking = provider.bookings[index];
                      return BookingCard(booking: booking);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
