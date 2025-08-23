import 'package:hive/hive.dart';

part 'courier_booking_modal.g.dart';

@HiveType(typeId: 0)
class CourierBookingModal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String senderName;

  @HiveField(2)
  final String senderPhone;

  @HiveField(3)
  final String senderAddress;

  @HiveField(4)
  final String receiverName;

  @HiveField(5)
  final String receiverPhone;

  @HiveField(6)
  final String receiverAddress;

  @HiveField(7)
  final double packageWeight;

  @HiveField(8)
  final DateTime pickupDateTime;

  @HiveField(9)
  final double price;

  @HiveField(10)
  final String trackingNumber;

  @HiveField(11)
  String status;

  CourierBookingModal({
    required this.id,
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.packageWeight,
    required this.pickupDateTime,
    required this.price,
    required this.trackingNumber,
    this.status = 'Booked',
  });
}
