import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/booking.dart';

class FirestoreBookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Booking>> getBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final bookings = snapshot.docs.map((doc) {
        return Booking.fromMap(doc.data(), doc.id);
      }).toList();
      
      // Sort client-side to avoid index requirement
      bookings.sort((a, b) => b.date.compareTo(a.date));
      return bookings;
    });
  }

  Future<void> addBooking(Booking booking) async {
    try {
      await _firestore.collection('bookings').add(booking.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelBooking(String id) async {
    try {
      await _firestore.collection('bookings').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
