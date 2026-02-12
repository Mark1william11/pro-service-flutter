import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/constants/app_colors.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int currentPage = 0;
  late LiquidController liquidController;

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final pages = [
      _buildPage(
        color: AppColors.primary,
        title: strings.onboardingTitle1,
        desc: strings.onboardingDesc1,
        icon: Icons.search_rounded,
      ),
      _buildPage(
        color: AppColors.secondary,
        title: strings.onboardingTitle2,
        desc: strings.onboardingDesc2,
        icon: Icons.security_rounded,
      ),
      _buildPage(
        color: const Color(0xFF673AB7),
        title: strings.onboardingTitle3,
        desc: strings.onboardingDesc3,
        icon: Icons.bolt_rounded,
        isLast: true,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: liquidController,
            onPageChangeCallback: (index) {
              setState(() {
                currentPage = index;
              });
            },
            ignoreUserGestureWhileAnimating: true,
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: currentPage == index ? 1 : 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                if (currentPage == pages.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => context.go('/login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                          ),
                          child: Text(strings.getStarted),
                        ).animate().fadeIn().scale(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required Color color,
    required String title,
    required String desc,
    required IconData icon,
    bool isLast = false,
  }) {
    return Container(
      color: color,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassContainer(
            height: 200,
            width: 200,
            blur: 20,
            color: Colors.white.withValues(alpha: 0.1),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.05),
              ],
            ),
            border: const Border.fromBorderSide(BorderSide(color: Colors.white24)),
            borderRadius: BorderRadius.circular(100),
            child: Center(
              child: Icon(
                icon,
                size: 100,
                color: Colors.white,
              ).animate(onPlay: (controller) => controller.repeat())
               .shimmer(duration: 2.seconds, color: Colors.white30)
               .moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut)
               .then()
               .moveY(begin: 10, end: -10, duration: 2.seconds, curve: Curves.easeInOut),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                const SizedBox(height: 16),
                Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
