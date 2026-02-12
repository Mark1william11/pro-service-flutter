import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_strings.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../booking/domain/booking.dart';
import '../../../booking/presentation/providers/booking_provider.dart';
import '../../../booking/presentation/screens/location_picker_screen.dart';

class ServiceDetailsScreen extends ConsumerWidget {
  final String serviceId;
  const ServiceDetailsScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: 'https://i.pravatar.cc/600?u=$serviceId',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                ).animate(onPlay: (controller) => controller.repeat())
                 .shimmer(duration: 1200.ms, color: Colors.grey[100]),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Directionality.of(context) == TextDirection.rtl
                        ? Icons.arrow_forward
                        : Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Expert Electrician',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 4),
                            Text(
                              '4.9',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    strings.bio,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Over 10 years of experience in residential and commercial electrical work. Certified professional dedicated to high-quality service and safety.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    strings.gallery,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/200?random=$index',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                            ).animate(onPlay: (controller) => controller.repeat())
                             .shimmer(duration: 1200.ms, color: Colors.grey[100]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            _showBookingBottomSheet(context, serviceId);
          },
          child: Text(strings.bookNow),
        ),
      ),
    );
  }

  void _showBookingBottomSheet(BuildContext context, String serviceId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => BookingBottomSheet(serviceId: serviceId),
    );
  }
}


class BookingBottomSheet extends ConsumerStatefulWidget {
  final String serviceId;
  const BookingBottomSheet({super.key, required this.serviceId});

  @override
  ConsumerState<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends ConsumerState<BookingBottomSheet> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:00 AM';
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    final bookingAction = ref.watch(bookingActionProvider);
    final user = ref.watch(authProvider).user;
    final strings = ref.watch(stringsProvider);

    ref.listen(bookingActionProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}'), backgroundColor: AppColors.error),
        );
      }
      if (next is AsyncData && previous is AsyncLoading) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.bookingConfirmed),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.selectDateTime,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Simple Date Picker
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = date.day == selectedDate.day;
                return GestureDetector(
                  onTap: () => setState(() => selectedDate = date),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1],
                          style: TextStyle(
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Available Slots',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: ['09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '04:00 PM'].map((time) {
              final isSelected = time == selectedTime;
              return ChoiceChip(
                label: Text(time),
                selected: isSelected,
                onSelected: (val) => setState(() => selectedTime = time),
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Service Location',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              final location = await Navigator.push<LatLng>(
                context,
                MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
              );
              if (location != null) {
                setState(() => pickedLocation = location);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: pickedLocation != null ? AppColors.primary : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: pickedLocation != null ? AppColors.primary : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      pickedLocation != null
                          ? 'Location selected: ${pickedLocation!.latitude.toStringAsFixed(4)}, ${pickedLocation!.longitude.toStringAsFixed(4)}'
                          : 'Select service location on map',
                      style: TextStyle(
                        color: pickedLocation != null ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: bookingAction.isLoading || user == null || pickedLocation == null
                  ? null
                  : () {
                      final booking = Booking(
                        userId: user.id,
                        serviceName: 'Electrical Repair',
                        proName: 'John Doe',
                        date: selectedDate,
                        time: selectedTime,
                        price: 50.0,
                        latitude: pickedLocation!.latitude,
                        longitude: pickedLocation!.longitude,
                      );

                      ref.read(bookingActionProvider.notifier).addBooking(booking);
                    },
              child: bookingAction.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(pickedLocation == null ? 'Please select location' : 'Confirm Booking'),
            ),
          ),
        ],
      ),
    );
  }
}
