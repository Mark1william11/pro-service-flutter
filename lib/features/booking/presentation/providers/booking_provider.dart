import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/booking.dart';
import '../../data/firestore_booking_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final bookingRepositoryProvider = Provider((ref) => FirestoreBookingRepository());

final bookingsStreamProvider = StreamProvider<List<Booking>>((ref) {
  final user = ref.watch(authProvider).user;
  if (user == null) return Stream.value([]);
  
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getBookings(user.id);
});

class BookingNotifier extends StateNotifier<AsyncValue<void>> {
  final FirestoreBookingRepository _repository;

  BookingNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> addBooking(Booking booking) async {
    state = const AsyncValue.loading();
    try {
      await _repository.addBooking(booking);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelBooking(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.cancelBooking(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final bookingActionProvider = StateNotifierProvider<BookingNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(bookingRepositoryProvider);
  return BookingNotifier(repository);
});
