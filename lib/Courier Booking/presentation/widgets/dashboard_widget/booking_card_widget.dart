import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entities/courier_booking_modal.dart';

class BookingCard extends StatelessWidget {
  final CourierBookingModal booking;

  const BookingCard({super.key, required this.booking});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'picked up':
        return Colors.blue;
      case 'in transit':
        return Colors.orange;
      case 'out for delivery':
        return Colors.green;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Tracking Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Tracking #: ${booking.trackingNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.grey[800],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: booking.trackingNumber),
                    ).then((_) {
                      showCustomToast('Tracking ID copied!');
                    });
                  },
                  child: Icon(Icons.copy, size: 18.w, color: Colors.blue),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Divider
            Divider(height: 1.h, color: Colors.grey[300]),

            SizedBox(height: 12.h),

            // Booking Details
            _buildDetailRow('From', booking.senderName),
            SizedBox(height: 8.h),
            _buildDetailRow('To', booking.receiverName),
            SizedBox(height: 8.h),
            _buildDetailRow('Weight', '${booking.packageWeight} kg'),
            SizedBox(height: 8.h),
            _buildDetailRow('Price', '\$${booking.price.toStringAsFixed(2)}'),
            SizedBox(height: 8.h),

            // Status with colored indicator
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Status: ',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                Text(
                  booking.status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: _getStatusColor(booking.status),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
