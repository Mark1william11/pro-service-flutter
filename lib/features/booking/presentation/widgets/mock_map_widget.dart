import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class MockMapWidget extends StatefulWidget {
  final LatLng initialLocation;
  final Function(LatLng) onLocationChanged;

  const MockMapWidget({
    super.key,
    required this.initialLocation,
    required this.onLocationChanged,
  });

  @override
  State<MockMapWidget> createState() => _MockMapWidgetState();
}

class _MockMapWidgetState extends State<MockMapWidget> {
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // High-quality placeholder map image from Unsplash
        Positioned.fill(
          child: Image.network(
            'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?q=80&w=2000&auto=format&fit=crop',
            fit: BoxFit.cover,
          ),
        ),
        // Dark overlay to make it look more like a map
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ),
        // Draggable Pin
        Center(
          child: Draggable(
            feedback: const Icon(
              Icons.location_on,
              size: 50,
              color: AppColors.primary,
            ),
            childWhenDragging: Icon(
              Icons.location_on,
              size: 40,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            onDragEnd: (details) {
              // In a real mock, we'd calculate the lat/lng based on pixel movement
              // For now, we'll return a slightly randomized location to simulate movement
              final newLocation = LatLng(
                _currentLocation.latitude + (0.001 * (details.offset.dy % 10 - 5)),
                _currentLocation.longitude + (0.001 * (details.offset.dx % 10 - 5)),
              );
              setState(() => _currentLocation = newLocation);
              widget.onLocationChanged(newLocation);
            },
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
        // Hint text
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Text(
              'Drag the pin to set your location',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
