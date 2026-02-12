# 🛠️ Pro-Service: Professional Home Services Marketplace

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)](https://firebase.google.com)
[![Riverpod](https://img.shields.io/badge/Riverpod-blue?style=for-the-badge&logo=riverpod&logoColor=white)](https://riverpod.dev)

Pro-Service is a high-performance, production-ready mobile application designed to bridge the gap between skilled professionals and homeowners. Built with a focus on scalability and user experience, it provides a seamless interface for booking everything from plumbing and electrical work to professional cleaning and gardening.

---

## 🚀 Core Features

- **🔐 Robust Authentication**: Secure Email/Password authentication powered by Firebase Auth, featuring real-time state management and advanced input validation (Regex-based).
- **🔥 Real-time Firestore Integration**: Live data synchronization for user profiles, booking histories, and service availability.
- **📍 Smart Location Services**: Integrated `Google Maps` for precise service location picking with custom `MockMapWidget` fallbacks for development.
- **🌍 Full RTL & Multi-language Support**: Native support for **Arabic** and **English**, including dynamic layout mirroring and instant language switching.
- **📊 Real-time Statistics**: Live dashboard metrics for users, including total bookings and membership history.
- **🖼️ Profile Management**: Advanced profile editing with real-time Firestore updates and dynamic profile picture management (Unsplash integration).
- **✨ Smooth UX/UI**: Beautifully crafted animations using `flutter_animate` and a modern glassmorphism-inspired design system.

---

## 🏗️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Latest Stable)
- **State Management**: [Riverpod 2.x](https://riverpod.dev) (ProviderScope, StateNotifier, StreamProvider)
- **Architecture**: **Clean Architecture** (Feature-driven)
  - `core/`: Shared constants, themes, and localization logic.
  - `features/`: Domain-driven modules (Auth, Booking, Home, Profile).
- **Backend**: [Firebase](https://firebase.google.com) (Authentication, Cloud Firestore)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) (Declarative routing with redirect logic)
- **UI & Animation**: `flutter_animate`, custom specialized widgets.

---

## 💻 Getting Started

### Prerequisites
- Flutter SDK (Latest)
- Firebase Account & Project

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/pro_service.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Setup Firebase:
   - Run `flutterfire configure` to link your Firebase project.
4. Launch the app:
   ```bash
   flutter run
   ```

---

## 🌐 Web Demo

Experience the Pro-Service interface directly in your browser:

1. Ensure you have the Chrome browser installed.
2. Run the following command in your terminal:
   ```bash
   flutter run -d chrome
   ```
3. Alternatively, if a web build is deployed, visit: `[Your-Live-Demo-URL-Here]`

---

## 🛡️ Security & Validation

Pro-Service implements senior-level security practices:
- **Email Validation**: Strict regex checks for professional email formats.
- **Password Policy**: Minimum 8 characters with alphanumeric requirements for sign-up.
- **Type-Safe Data**: Explicit `Map<String, dynamic>` handling for Firestore `FieldValue` operations.

---

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

**Developed with ❤️ by Mark William**
