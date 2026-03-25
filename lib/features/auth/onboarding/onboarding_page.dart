import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  String image;
  String title;
  String desc;
  int currentIndex;
  int total;
  VoidCallback onJoin;
  VoidCallback login;
  Color color;

  OnboardingPage({
    super.key,
    required this.currentIndex,
    required this.desc,
    required this.image,
    required this.title,
    required this.total,
    required this.onJoin,
    required this.login,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color,
      body: Column(
        children: [
          // ── Top image section ──────────────────
          Expanded(flex: 5, child: Image.asset(image, width: double.infinity, fit: BoxFit.cover)),

          // ── Bottom white card ──────────────────
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title + description
                  Column(
                    children: [
                      Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
                      const SizedBox(height: 20),
                      Text(desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Color(0xFF666666), height: 1.6)),
                    ],
                  ),

                  // Page indicator dots
                  _PageIndicator(currentIndex: currentIndex, total: total),

                  // Buttons
                  Column(
                    children: [
                      // Join button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: onJoin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Join the movement!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Login link
                      GestureDetector(
                        onTap: login,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1A1A1A),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF1A1A1A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Page indicator widget ──────────────────────
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.currentIndex, required this.total});

  final int currentIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFFCCCCCC), borderRadius: BorderRadius.circular(10)),
        );
      }),
    );
  }
}
