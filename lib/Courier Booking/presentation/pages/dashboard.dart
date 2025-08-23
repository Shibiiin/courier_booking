import 'package:courier_booking/Courier%20Booking/presentation/routes/appRoutes.dart';
import 'package:flutter/material.dart';
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
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.booking),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Book Courier'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.tracking),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Track Shipment'),
            ),
            const SizedBox(height: 24),
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
