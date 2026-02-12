import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is a mock implementation of Firebase Firestore
class MockFirestore {
  // Simulate fetching data
  Future<List<Map<String, dynamic>>> getTopPros() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': '1',
        'name': 'John Doe',
        'service': 'Electrician',
        'rating': 4.9,
        'price': 25.0,
        'imageUrl': 'https://i.pravatar.cc/150?u=1',
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'service': 'Plumber',
        'rating': 4.8,
        'price': 30.0,
        'imageUrl': 'https://i.pravatar.cc/150?u=2',
      },
    ];
  }
}

final firestoreProvider = Provider((ref) => MockFirestore());
