import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/loading_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/category_results_screen.dart';
import '../../features/booking/presentation/screens/bookings_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/service_details/presentation/screens/service_details_screen.dart';
import 'responsive_shell.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (previous, next) {
      // Notify if user changed (login/logout) or if initialization status changed
      if (previous?.user != next.user || previous?.isInitialized != next.isInitialized) {
        print('ROUTER_DEBUG: Auth state changed. User: ${next.user?.email}, Initialized: ${next.isInitialized}');
        notifyListeners();
      }
    });
  }
}

final routerNotifierProvider = Provider((ref) => RouterNotifier(ref));

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);
  
  return GoRouter(
    initialLocation: '/loading',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      
      // 1. Wait for initialization
      if (!authState.isInitialized) {
        return '/loading';
      }

      final isLoggedIn = authState.user != null;
      final path = state.uri.path;
      
      final isAuthPath = path == '/login' || 
                         path == '/signup' || 
                         path == '/onboarding';
      final isSplash = path == '/splash';
      final isLoadingPath = path == '/loading';

      // 2. Handle Non-Logged In Users
      if (!isLoggedIn) {
        // If we are on loading, splash, or any non-auth page, go to onboarding
        if (isLoadingPath || isSplash || !isAuthPath) {
          return '/onboarding';
        }
        return null;
      }

      // 3. Handle Logged In Users
      // If logged in, they shouldn't be on auth screens, splash, or loading
      if (isAuthPath || isSplash || isLoadingPath) {
        return '/';
      }
      
      // Otherwise, let them go where they want
      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ResponsiveShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/bookings',
            builder: (context, state) => const BookingsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/category/:name',
        builder: (context, state) {
          final name = state.pathParameters['name']!;
          return CategoryResultsScreen(categoryName: name);
        },
      ),
      GoRoute(
        path: '/service-details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ServiceDetailsScreen(serviceId: id);
        },
      ),
    ],
  );
});
