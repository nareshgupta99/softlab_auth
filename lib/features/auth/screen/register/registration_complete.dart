import 'package:flutter/material.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/helper/routes.dart';

class RegistrationComplete extends StatelessWidget {
  const RegistrationComplete({super.key});
  static const kPrimary = Color(0xFFCD6B5A);
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);
  static const kBgField = Color(0xFFF2F2F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Check icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (_, v, child) => Transform.scale(scale: v, child: child),
                child: const Icon(Icons.check, color: Color(0xFF22C55E), size: 80),
              ),

              const SizedBox(height: 32),

              const Text("You're all done!", style: TextStyle(color: kTextDark, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.3)),

              const SizedBox(height: 16),

              const Text(
                'Hang tight!  We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.',
                textAlign: TextAlign.center,
                style: TextStyle(color: kSubtitle, fontSize: 14, height: 1.6),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: customButton(
                  text: 'Got it!',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MRoutes.login);
                  },
                  color: kPrimary,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
