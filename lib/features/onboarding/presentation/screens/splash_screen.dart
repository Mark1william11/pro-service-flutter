import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo Placeholder
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.handyman_rounded,
                size: 80,
                color: AppColors.primary,
              ),
            ).animate()
              .scale(duration: 800.ms, curve: Curves.easeOutBack)
              .fadeIn(duration: 600.ms),
            const SizedBox(height: 32),
            const Text(
              'Pro-Service',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ).animate()
              .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
              .fadeIn(duration: 600.ms),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ).animate()
              .fadeIn(delay: 1.seconds, duration: 500.ms),
          ],
        ).animate()
          .fadeOut(delay: 2.5.seconds, duration: 500.ms), // Fade out everything before transition
      ),
    );
  }
}
