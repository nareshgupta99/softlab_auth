import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softlab_auth/components/app_bar.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key});

  @override
  State<RegisterStep3> createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3> {
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);
  static const kBgField = Color(0xFFF2F2F0);
  static const kPrimary = Color(0xFFCD6B5A);

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FarmerEatsAppBar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.arrow_back, color: kTextDark), onPressed: () => Navigator.pop(context)),
              // const Spacer(),
              Expanded(
                child: customButton(
                  onPressed: () {
                    authController.registerWithValidation(3, context);
                  },
                  text: authController.registrationProof.value.isNotEmpty ? 'Submit' : 'Continue',
                  color: kPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text("Signup 3 of 4", style: TextStyle(color: kSubtitle, fontSize: 13, fontWeight: FontWeight.w400)),

                const SizedBox(height: 4),
                const Text("Verification", style: TextStyle(color: kTextDark, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5)),

                const SizedBox(height: 12),
                const Text(
                  'Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic',
                  style: TextStyle(color: kSubtitle, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 32),

                // Attach row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Attach proof of registration', style: TextStyle(color: kTextDark, fontSize: 15, fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: authController.attachFile,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),

                // Attached file chip
                if (authController.registrationProof.value.isNotEmpty) ...[
                  const SizedBox(height: 16),

                  Container(
                    height: 48,
                    decoration: BoxDecoration(color: kBgField, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(child: Text(authController.registrationProof.value, style: const TextStyle(fontSize: 14, color: kTextDark))),
                        GestureDetector(onTap: authController.removeFile, child: const Icon(Icons.close, size: 18, color: kSubtitle)),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Bottom bar
                const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }
}
