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

  Widget _buildNoBookingsState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inventory_2_outlined, size: 80.w, color: Colors.grey[300]),
        20.height,
        Text(
          'No Bookings Yet',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        10.height,
        Text(
          'Start by booking your first courier\nservice to see them here',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Courier App'),
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Navigation Buttons
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
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
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Book Courier',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  10.height,
                  SizedBox(
                    width: 300.w,
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRoutes.tracking),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Track Shipment',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            20.height,
            Text(
              'Recent Bookings',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// ListView of order details
            Expanded(
              child: Consumer<DashBoardController>(
                builder: (context, provider, child) {
                  if (provider.bookings.isEmpty) {
                    return _buildNoBookingsState();
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
