import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/features/auth/bloc/auth_bloc/auth_bloc.dart';

class SendOtpView extends StatefulWidget {
  const SendOtpView({super.key});

  @override
  State<SendOtpView> createState() => _SendOtpViewState();
}

class _SendOtpViewState extends State<SendOtpView> {
  FocusNode emailFocus = FocusNode();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return current is AuthLoading || current is AuthFailure;
      },
      builder: (context, state) {
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

                    CustomTextField(controller: phoneController, prefixIcon: Icons.phone, hintText: "Phone Number", focus: emailFocus),
                    SizedBox(height: 40.h),
                    customButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SendOtpEvent(phoneController.text));
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
      },
    );
  }
}
