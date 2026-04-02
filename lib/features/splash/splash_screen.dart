import 'package:flutter/material.dart';
import 'package:softlab_auth/constants/keys.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/utils/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // ── Animation controllers ──────────────────────────────────
  late final AnimationController _leafController;
  late final AnimationController _logoController;
  late final AnimationController _taglineController;
  late final AnimationController _ringController;

  // ── Animations ─────────────────────────────────────────────
  late final Animation<double> _leafScale;
  late final Animation<double> _leafOpacity;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;

  @override
  void initState() {
    super.initState();

    // Decorative pulsing ring behind logo
    _ringController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);

    _ringScale = Tween<double>(begin: 0.85, end: 1.1).animate(CurvedAnimation(parent: _ringController, curve: Curves.easeInOut));
    _ringOpacity = Tween<double>(begin: 0.12, end: 0.22).animate(CurvedAnimation(parent: _ringController, curve: Curves.easeInOut));

    // Leaf / icon entrance
    _leafController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _leafScale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _leafController, curve: Curves.elasticOut));
    _leafOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _leafController, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));

    // Logo text entrance
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    // Tagline entrance
    _taglineController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _taglineController, curve: Curves.easeOut));
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _taglineController, curve: Curves.easeOut));

    // Staggered sequence
    _startAnimations(context);
  }

  Future<void> _startAnimations(final context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _leafController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _taglineController.forward();

    // Navigate after splash
    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    String? isOnboardSetup = await LocalStorage.getStringData(key: Keys.isOnboardSetup);
    if (isOnboardSetup == "true") {
      Navigator.pushReplacementNamed(context, MRoutes.registerStep1);
    } else {
      Navigator.pushReplacementNamed(context, MRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    _leafController.dispose();
    _logoController.dispose();
    _taglineController.dispose();
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // warm off-white
      body: Stack(
        children: [
          // ── Background organic blobs ───────────────────────
          Positioned(top: -80, right: -60, child: _Blob(size: 280, color: const Color(0xFFCD6B5A).withOpacity(0.08))),
          Positioned(bottom: -100, left: -80, child: _Blob(size: 320, color: const Color(0xFFE8A87C).withOpacity(0.10))),
          Positioned(bottom: 160, right: -40, child: _Blob(size: 160, color: const Color(0xFFCD6B5A).withOpacity(0.06))),

          // ── Center content ─────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pulsing ring + leaf icon
                AnimatedBuilder(
                  animation: _ringController,
                  builder: (_, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer pulse ring
                        Transform.scale(
                          scale: _ringScale.value,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFCD6B5A).withOpacity(_ringOpacity.value), width: 2),
                            ),
                          ),
                        ),
                        // Inner fill circle
                        Container(
                          width: 108,
                          height: 108,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFCD6B5A).withOpacity(0.10)),
                        ),
                        child!,
                      ],
                    );
                  },
                  child: ScaleTransition(
                    scale: _leafScale,
                    child: FadeTransition(
                      opacity: _leafOpacity,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFCD6B5A)),
                        child: const Center(child: Text('🌿', style: TextStyle(fontSize: 36))),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // App name
                FadeTransition(
                  opacity: _logoFade,
                  child: SlideTransition(
                    position: _logoSlide,
                    child: const Text(
                      'FarmerEats',
                      style: TextStyle(color: Color(0xFF1A1A1A), fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1.0),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tagline
                FadeTransition(
                  opacity: _taglineFade,
                  child: SlideTransition(
                    position: _taglineSlide,
                    child: const Text(
                      'Farm fresh, delivered with care.',
                      style: TextStyle(color: Color(0xFF888888), fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom version tag ─────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _taglineFade,
              child: const Center(child: Text('v1.0.0', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 12))),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple organic blob using a CircleAvatar-style container
class _Blob extends StatelessWidget {
  final double size;
  final Color color;

  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }
}
