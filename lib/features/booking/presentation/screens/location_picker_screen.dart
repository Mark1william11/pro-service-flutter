import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/mock_map_widget.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _selectedLocation;
  final Location _location = Location();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          _setFallbackLocation();
          return;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          _setFallbackLocation();
          return;
        }
      }

      final locationData = await _location.getLocation();
      if (mounted) {
        setState(() {
          _selectedLocation = LatLng(locationData.latitude!, locationData.longitude!);
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        _setFallbackLocation();
      }
    }
  }

  void _setFallbackLocation() {
    setState(() {
      _selectedLocation = const LatLng(37.7749, -122.4194); // SF default
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          if (_selectedLocation != null)
            TextButton(
              onPressed: () => Navigator.pop(context, _selectedLocation),
              child: const Text('Confirm',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : MockMapWidget(
              initialLocation: _selectedLocation!,
              onLocationChanged: (latLng) => setState(() => _selectedLocation = latLng),
            ),
    );
  }
}

class PositionErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const PositionErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder for error handling
  }
}
