import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';

class SendOtpView extends StatelessWidget {
  SendOtpView({super.key});
  FocusNode emailFocus = FocusNode();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: KeyboardActions(
            config: KeyboardActionsConfig(
              keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
              actions: [
                KeyboardActionsItem(
                  displayDoneButton: true,
                  displayArrows: true,
                  focusNode: emailFocus,
                  toolbarButtons: [
                    (node) {
                      return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                    },
                  ],
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),

                Text("FarmerEats", style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w400, fontSize: 16.sp)),
                SizedBox(height: 92.h),
                Text("Forgot Password?", style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w700, fontSize: 32.sp)),
                SizedBox(height: 32.h),

                RichText(
                  text: TextSpan(
                    style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.black),
                    children: [
                      TextSpan(text: "Remember your password? ", style: TextStyle(color: Colors.black26)),
                      TextSpan(text: " Login", style: TextStyle(color: Color(0xffD5715B))),
                    ],
                  ),
                ),
                SizedBox(height: 64.h),

                CustomTextField(controller: authController.phoneController, prefixIcon: Icons.phone, hintText: "Phone Number", focus: emailFocus),
                SizedBox(height: 40.h),
                customButton(
                  onPressed: () {
                    authController.sendOtpWithValidation(context);
                  },
                  text: "Send Code",
                  color: Color(0xffd4705b),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
