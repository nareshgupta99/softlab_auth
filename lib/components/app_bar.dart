import 'package:flutter/material.dart';

class FarmerEatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FarmerEatsAppBar({super.key});
  static const  kTextDark = Color(0xFF1A1A1A);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text('FarmerEats', style: TextStyle(color: kTextDark, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
    );
  }
}
