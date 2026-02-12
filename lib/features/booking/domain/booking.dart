class Booking {
  final String? id;
  final String userId;
  final String serviceName;
  final String proName;
  final DateTime date;
  final String time;
  final double price;
  final String status;
  final double? latitude;
  final double? longitude;

  Booking({
    this.id,
    required this.userId,
    required this.serviceName,
    required this.proName,
    required this.date,
    required this.time,
    required this.price,
    this.status = 'Pending',
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceName': serviceName,
      'proName': proName,
      'date': date.toIso8601String(),
      'time': time,
      'price': price,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map, String id) {
    return Booking(
      id: id,
      userId: map['userId'] ?? '',
      serviceName: map['serviceName'] ?? '',
      proName: map['proName'] ?? '',
      date: DateTime.parse(map['date']),
      time: map['time'] ?? '',
      price: (map['price'] as num).toDouble(),
      status: map['status'] ?? 'Pending',
      latitude: map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null ? (map['longitude'] as num).toDouble() : null,
    );
  }
}
