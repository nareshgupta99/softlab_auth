import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/constants/image_constants.dart';
import 'package:softlab_auth/features/auth/bloc/auth_bloc.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/utils/app_overlay.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode emailFocus = FocusNode();

  FocusNode passwordFocus = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      buildWhen: (previous, current) {
        return current is AuthLoading || current is AuthFailure;
      },
      listenWhen: (previous, current) {
        return current is AuthSuccess || current is AuthValidationError;
      },
      listener: (context, state) {
        if (state is AuthValidationError) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: state.errorTitle, message: state.error);
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, MRoutes.home);
        }
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
                    KeyboardActionsItem(
                      displayDoneButton: true,
                      focusNode: passwordFocus,
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
                    Text("Welcome back!", style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w700, fontSize: 32.sp)),
                    SizedBox(height: 32.h),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.black),
                        children: [
                          TextSpan(text: "New here? ", style: TextStyle(color: Colors.black26)),
                          TextSpan(
                            text: "Create account",
                            style: TextStyle(color: Color(0xffD5715B)),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offNamed(Routes.getRegisterStep1());
                                  },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 64.h),

                    CustomTextField(controller: emailController, prefixIcon: Icons.alternate_email, hintText: "Email Address", focus: emailFocus),
                    SizedBox(height: 20.h),
                    CustomTextFieldWithSuffixText(
                      suffixText: "Forgot?",
                      onTapSuffix: () {
                        Get.toNamed(Routes.getSendOtp());
                      },
                      controller: passwordController,
                      prefixIcon: Icons.lock_outline,
                      hintText: "Password",
                      focus: passwordFocus,
                    ),
                    SizedBox(height: 40.h),
                    customButton(
                      onPressed: () {
                        authBloc.add(LoginSubmittedEvent(emailController.text, passwordController.text));
                      },
                      text: "Login",
                      color: Color(0xffd4705b),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        "or login with",
                        style: TextStyle(fontFamily: 'BeVietnam', fontWeight: FontWeight.w500, fontSize: 12.sp, color: Colors.black.withAlpha(60)),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(imageUrl: Images.google, onTap: () {}),
                        SizedBox(width: 12.w),
                        SocialButton(imageUrl: Images.facebook, onTap: () {}),
                        SizedBox(width: 12.w),
                        SocialButton(imageUrl: Images.apple, onTap: () {}),
                      ],
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
