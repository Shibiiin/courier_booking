import 'package:courier_booking/Courier%20Booking/entities/courier_booking_modal.dart';
import 'package:courier_booking/Courier%20Booking/presentation/manager/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _trackingController = TextEditingController();
  CourierBookingModal? _trackedBooking;

  void _trackShipment() {
    final trackingNumber = _trackingController.text.trim();
    if (trackingNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter tracking number')),
      );
      return;
    }

    final booking = Provider.of<DashBoardController>(
      context,
      listen: false,
    ).getBookingByTrackingNumber(trackingNumber);

    setState(() {
      _trackedBooking = booking;
    });

    if (booking == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No shipment found with this tracking number'),
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('Track Shipment'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: 'Enter Tracking Number',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _trackShipment,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _trackShipment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Track Shipment'),
            ),
            const SizedBox(height: 24),

            if (_trackedBooking != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _getStatusIcon(_trackedBooking!.status),
                      const SizedBox(height: 16),
                      Text(
                        _trackedBooking!.status,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(_trackedBooking!.status),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tracking Number:'),
                          Text(
                            _trackedBooking!.trackingNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('From:'),
                          Text(_trackedBooking!.senderName),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('To:'),
                          Text(_trackedBooking!.receiverName),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Weight:'),
                          Text('${_trackedBooking!.packageWeight} kg'),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else if (_trackingController.text.isNotEmpty)
              const Text(
                'No shipment found with this tracking number',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }
}
