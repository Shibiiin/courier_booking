import 'dart:convert';

import 'package:courier_booking/Courier%20Booking/entities/courier_booking_modal.dart';
import 'package:courier_booking/Courier%20Booking/presentation/theme/local_storage.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/custom_print.dart';
import 'package:courier_booking/Courier%20Booking/presentation/widgets/common/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DashBoardController with ChangeNotifier {
  DashBoardController() {
    loadBookings();
  }

  /// Sender Form fields
  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final senderAddressController = TextEditingController();

  /// Receiver Form fields
  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();
  final receiverAddressController = TextEditingController();

  ///Pick up date
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();

  /// Track Shipment
  final trackingController = TextEditingController();

  ///Form Key
  final formKey = GlobalKey<FormState>();

  /// Package Details
  final packageWeightController = TextEditingController();

  DateTime? pickupDate;
  TimeOfDay? pickupTime;

  ///Select Date
  Future<void> selectDate(
    DashBoardController controller,
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      controller.pickupDate = picked;
      pickupDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      notifyListeners();
    }
  }

  ///Select Time
  Future<void> selectTime(
    DashBoardController controller,
    BuildContext context,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.pickupTime = picked;
      pickupTimeController.text = picked.format(context);
      notifyListeners();
    }
  }

  /// Calculates the estimated price based on weight.
  double get estimatedPrice {
    final weight = double.tryParse(packageWeightController.text) ?? 0;
    return weight * 10;
  }

  void submitForm(DashBoardController controller, BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (controller.pickupDate == null || controller.pickupTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select pickup date and time')),
        );
        return;
      }

      final pickupDateTime = DateTime(
        controller.pickupDate!.year,
        controller.pickupDate!.month,
        controller.pickupDate!.day,
        controller.pickupTime!.hour,
        controller.pickupTime!.minute,
      );

      final booking = CourierBookingModal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderName: controller.senderNameController.text,
        senderPhone: controller.senderPhoneController.text,
        senderAddress: controller.senderAddressController.text,
        receiverName: controller.receiverNameController.text,
        receiverPhone: controller.receiverPhoneController.text,
        receiverAddress: controller.receiverAddressController.text,
        packageWeight: double.parse(controller.packageWeightController.text),
        pickupDateTime: pickupDateTime,
        price: estimatedPrice,
        trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
      );

      /// Add booking to the list
      controller.addBooking(booking);

      /// Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Booking Confirmed'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tracking Number: ${booking.trackingNumber}'),
              const SizedBox(height: 8),
              Text('Sender: ${booking.senderName}'),
              Text('Receiver: ${booking.receiverName}'),
              Text('Weight: ${booking.packageWeight} kg'),
              Text('Price: \$${booking.price.toStringAsFixed(2)}'),
              Text(
                'Pickup: ${DateFormat('yyyy-MM-dd HH:mm').format(pickupDateTime)}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.clearBookingDetails();
                pickupDateController.clear();
                pickupTimeController.clear();

                context.pop();
                context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  final List<CourierBookingModal> bookingsList = [];
  final Box<CourierBookingModal> bookingBox = Hive.box(LocalStorage.bookings);

  List<CourierBookingModal> get bookings => bookingsList;

  void addBooking(CourierBookingModal booking) {
    bookingsList.insert(0, booking);
    bookingBox.put(booking.id, booking);
    successPrint("Booking added to hive storage");
    bookingsList.sort((a, b) => b.pickupDateTime.compareTo(a.pickupDateTime));
    notifyListeners();
  }

  void loadBookings() async {
    bookingsList.clear();
    bookingsList.addAll(bookingBox.values);
    successPrint("Booking List Length ${bookingsList.length}");

    /// sorting to show the recent first
    bookingsList.sort((a, b) => b.pickupDateTime.compareTo(a.pickupDateTime));
    notifyListeners();
  }

  CourierBookingModal? getBookingByTrackingNumber(String trackingNumber) {
    try {
      successPrint("Get Booking By Tracking Number");
      return bookingsList.firstWhere(
        (booking) => booking.trackingNumber == trackingNumber,
      );
    } catch (e) {
      return null;
    }
  }

  void updateBookingStatus(String trackingNumber, String newStatus) {
    final index = bookingsList.indexWhere(
      (booking) => booking.trackingNumber == trackingNumber,
    );

    if (index != -1) {
      bookingsList[index].status = newStatus;
      bookingsList[index].save();
      notifyListeners();
    }
  }

  /// ----------- Track shipment ------------
  String? mockedStatus;
  CourierBookingModal? trackedBooking;
  Future<void> trackShipment(BuildContext context) async {
    alertPrint("Tracking Shipment");
    final trackingNumber = trackingController.text.trim();
    if (trackingNumber.isEmpty) {
      showCustomToast('Please enter a tracking number');
      return;
    }

    trackedBooking = null;
    mockedStatus = null;

    final localBooking = getBookingByTrackingNumber(trackingNumber);

    try {
      final String response = await rootBundle.loadString(
        'assets/mock_tracking_data.json',
      );
      final data = json.decode(response);
      if (data[trackingNumber] != null) {
        mockedStatus = data[trackingNumber]['status'];
      }
    } catch (e) {
      errorPrint("Error Loading Mock Data $e");
    }

    if (localBooking == null) {
      showCustomToast('No shipment found with this tracking number');
    } else {
      trackedBooking = localBooking;
    }

    notifyListeners();
  }

  /// Clears all the controllers and date/time fields after a booking.
  void clearBookingDetails() {
    senderNameController.clear();
    senderPhoneController.clear();
    senderAddressController.clear();
    receiverNameController.clear();
    receiverPhoneController.clear();
    receiverAddressController.clear();
    packageWeightController.clear();
    pickupDate = null;
    pickupTime = null;
    pickupDateController.clear();
    pickupTimeController.clear();

    notifyListeners();
  }

  void clearTrackingDetails() {
    trackingController.clear();
    trackedBooking = null;
    mockedStatus = null;
    notifyListeners();
  }
}
