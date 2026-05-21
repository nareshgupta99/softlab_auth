import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/otp_fields.dart';
import 'package:softlab_auth/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:softlab_auth/helper/routes.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key, required this.id});
  final String id;

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  String otp = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: KeyboardActions(
                config: KeyboardActionsConfig(
                  keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                  actions: [
                    // KeyboardActionsItem(
                    //   displayDoneButton: true,
                    //   displayArrows: true,
                    //   focusNode: newPasswordFocus,
                    //   toolbarButtons: [
                    //     (node) {
                    //       return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                    //     },
                    //   ],
                    // ),
                    // KeyboardActionsItem(
                    //   displayDoneButton: true,
                    //   focusNode: confirmPasswordFocus,
                    //   toolbarButtons: [
                    //     (node) {
                    //       return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                    //     },
                    //   ],
                    // ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h),

                    Text("FarmerEats", style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w400, fontSize: 16.sp)),
                    SizedBox(height: 92.h),
                    Text("Verify OTP", style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w700, fontSize: 32.sp)),
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

                    OtpFields(
                      onChanged: (value) {
                        print(value);
                        otp = value;
                      },
                      controllers: [
                        TextEditingController(),
                        TextEditingController(),
                        TextEditingController(),
                        TextEditingController(),
                        TextEditingController(),
                      ],
                    ),

                    SizedBox(height: 40.h),
                    customButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(VerifyOtPEvent(otp));
                      },
                      text: "Submit",
                      color: Color(0xffd4705b),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'BeVietnam',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
