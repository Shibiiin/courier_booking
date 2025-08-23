class MockTrackingData {
  final String status;
  final String trackingNumber;
  final String receiverName;
  final String receiverLocation;
  final String senderName;
  final double weight;

  MockTrackingData({
    required this.status,
    required this.trackingNumber,
    required this.receiverName,
    required this.receiverLocation,
    required this.senderName,
    required this.weight,
  });

  factory MockTrackingData.fromJson(Map<String, dynamic> json) {
    return MockTrackingData(
      status: json['status'] ?? 'Unknown',
      trackingNumber: json['trackingNumber'] ?? '',
      receiverName: json['receiverName'] ?? 'N/A',
      receiverLocation: json['receiverLocation'] ?? 'N/A',
      senderName: json['senderName'] ?? 'N/A',
      weight: (json['weight'] ?? 0.0).toDouble(),
    );
  }
}
