class CourierBookingModal {
  final String id;
  final String senderName;
  final String senderPhone;
  final String senderAddress;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final double packageWeight;
  final DateTime pickupDateTime;
  final double price;
  final String trackingNumber;
  final String status;

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

  CourierBookingModal copyWith({String? status}) {
    return CourierBookingModal(
      id: id,
      senderName: senderName,
      senderPhone: senderPhone,
      senderAddress: senderAddress,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
      receiverAddress: receiverAddress,
      packageWeight: packageWeight,
      pickupDateTime: pickupDateTime,
      price: price,
      trackingNumber: trackingNumber,
      status: status ?? this.status,
    );
  }
}
