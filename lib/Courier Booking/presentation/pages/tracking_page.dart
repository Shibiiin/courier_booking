import 'package:courier_booking/Courier%20Booking/entities/courier_booking_modal.dart';
import 'package:courier_booking/Courier%20Booking/presentation/manager/dashboard_controller.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashBoardController>(
        context,
        listen: false,
      ).clearTrackingDetails();
    });
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'picked up':
        return const Icon(Icons.inventory_2, color: Colors.blue, size: 40);
      case 'in transit':
        return const Icon(Icons.local_shipping, color: Colors.orange, size: 40);
      case 'out for delivery':
        return const Icon(Icons.delivery_dining, color: Colors.green, size: 40);
      case 'delivered':
        return const Icon(Icons.check_circle, color: Colors.green, size: 40);
      default:
        return const Icon(Icons.pending, color: Colors.grey, size: 40);
    }
  }

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

  Widget _buildNoDataState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off, size: 80.w, color: Colors.grey[300]),
        20.height,
        Text(
          'No Shipment Found',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        10.height,
        Text(
          'Please check the tracking number\nand try again',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildTrackingCard(CourierBookingModal booking, String status) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.r,
            spreadRadius: 2.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _getStatusIcon(status),
            15.height,
            Text(
              status.toUpperCase(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(status),
                letterSpacing: 1.2,
              ),
            ),
            16.height,
            const Divider(color: Colors.grey, height: 1),
            16.height,
            _buildInfoRow('Tracking Number', booking.trackingNumber, true),
            12.height,
            _buildInfoRow('Sender', booking.senderName),
            12.height,
            _buildInfoRow('Receiver', booking.receiverName),
            12.height,
            _buildInfoRow('Weight', '${booking.packageWeight} kg'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, [bool isBold = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[800],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashBoardController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('Track Shipment'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'Track Your Shipment',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  10.height,
                  Text(
                    'Enter your tracking number to check the status',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                  20.height,
                  TextField(
                    controller: controller.trackingController,
                    decoration: InputDecoration(
                      labelText: 'Tracking Number',
                      hintText: 'Enter your tracking number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.green),
                        onPressed: () => controller.trackingController.clear(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                    onSubmitted: (_) => controller.trackShipment(context),
                  ),
                  15.height,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.trackShipment(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Track Shipment',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            30.height,
            Expanded(
              child: Consumer<DashBoardController>(
                builder: (context, provider, child) {
                  if (provider.trackingController.text.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 80.w, color: Colors.grey[300]),
                        20.height,
                        Text(
                          'Enter Tracking Number',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        10.height,
                        Text(
                          'Please enter a tracking number\nto search for your shipment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    );
                  } else if (provider.trackedBooking != null) {
                    final booking = provider.trackedBooking!;
                    final status = provider.mockedStatus ?? booking.status;
                    return SingleChildScrollView(
                      child: _buildTrackingCard(booking, status),
                    );
                  } else {
                    return _buildNoDataState();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
