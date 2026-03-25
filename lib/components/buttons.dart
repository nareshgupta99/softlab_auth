import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const customButton({super.key, required this.onPressed, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // pill shape
          ),
          elevation: 0,
        ),
        child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  const SocialButton({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 50.h,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20.r)),
      child: IconButton(onPressed: onTap, icon: Image.asset(imageUrl)),
    );
  }
}
