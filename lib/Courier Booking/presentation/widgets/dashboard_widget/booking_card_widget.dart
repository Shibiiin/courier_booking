import 'package:flutter/material.dart';

import '../../../entities/courier_booking_modal.dart';

class BookingCard extends StatelessWidget {
  final CourierBookingModal booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tracking #: ${booking.trackingNumber}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('From: ${booking.senderName}'),
            Text('To: ${booking.receiverName}'),
            Text('Weight: ${booking.packageWeight} kg'),
            Text('Price: \$${booking.price.toStringAsFixed(2)}'),
            Text('Status: ${booking.status}'),
          ],
        ),
      ),
    );
  }
}
