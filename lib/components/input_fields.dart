import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final TextEditingController controller;
  String? suffixText;
  final String hintText;
  FocusNode focus;
  bool obsecureText;
  final TextInputType keyboardType;
  CustomTextField({
    super.key,
    this.prefixIcon,
    required this.controller,
    this.suffixText,
    required this.hintText,
    required this.focus,
    this.obsecureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obsecureText,
        focusNode: focus,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: 'BeVietnam', color: Colors.black.withAlpha(60)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe9e8e8)), borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe9e8e8)), borderRadius: BorderRadius.circular(12.r)),
          fillColor: Color(0xFFEFEDED),
          filled: true,
        ),
      ),
    );
  }
}

class CustomTextFieldWithSuffixText extends StatelessWidget {
  final IconData prefixIcon;
  final TextEditingController controller;
  final String suffixText;
  final VoidCallback onTapSuffix;
  bool obsecureText;
  final String hintText;
  FocusNode focus;

  CustomTextFieldWithSuffixText({
    super.key,
    required this.prefixIcon,
    required this.controller,
    required this.suffixText,
    required this.onTapSuffix,
    this.obsecureText = false,
    required this.hintText,
    required this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        focusNode: focus,
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffix: InkWell(
            onTap: onTapSuffix,
            child: Text(suffixText, style: TextStyle(color: Color(0xffD5715B), fontSize: 14, fontFamily: 'BeVietnam')),
          ),
          // suffixIcon: Text(suffixText, style: TextStyle(color: Color(0xffD5715B), fontSize: 14, fontFamily: 'BeVietnam')),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: 'BeVietnam', color: Colors.black.withAlpha(60)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe9e8e8)), borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEFEDED)), borderRadius: BorderRadius.circular(12.r)),
          fillColor: Color(0xffe9e8e8),
          filled: true,
        ),
      ),
    );
  }
}
