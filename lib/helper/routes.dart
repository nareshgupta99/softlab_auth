import 'package:flutter/material.dart';
import 'package:softlab_auth/features/auth/screen/login/login_view.dart';
import 'package:softlab_auth/features/auth/screen/register/register_step1.dart';
import 'package:softlab_auth/features/auth/screen/register/register_step2.dart';
import 'package:softlab_auth/features/auth/screen/register/register_step3.dart';
import 'package:softlab_auth/features/auth/screen/register/register_step4.dart';
import 'package:softlab_auth/features/auth/screen/register/registration_complete.dart';
import 'package:softlab_auth/features/auth/screen/reset_password/send_otp.dart';
import 'package:softlab_auth/features/auth/screen/reset_password/update_password.dart';
import 'package:softlab_auth/features/auth/screen/reset_password/verify_otp.dart';
import 'package:softlab_auth/features/home/home.dart';
import 'package:softlab_auth/features/onboarding/onboarding_screen.dart';
import 'package:softlab_auth/features/splash/splash_screen.dart';

class MRoutes {
  // Route Names — same rakhe
  static const String onboarding = "/onboarding_screen";
  static const String login = "/login_view";
  static const String sendOtp = "/send_otp_view";
  static const String verifyOtp = "/verify_otp_view";
  static const String resetPassword = "/reset_password_view";
  static const String registerStep1 = "/register_step1";
  static const String registerStep2 = "/register_step2";
  static const String registerStep3 = "/register_step3";
  static const String registerStep4 = "/register_step4";
  static const String completeRegistration = "/complete_registration";
  static const String splash = "/splash_view";
  static const String home = "/home";

  // Flutter built-in routes map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (_) => SplashScreen(),
      onboarding: (_) => OnboardingScreen(),
      login: (_) => LoginView(),
      sendOtp: (_) => SendOtpView(),
      verifyOtp: (_) => VerifyOtpView(id: ""),
      resetPassword: (_) => UpdatePasswordView(),
      registerStep1: (_) => RegisterStep1(),
      registerStep2: (_) => RegisterStep2(),
      registerStep3: (_) => RegisterStep3(),
      registerStep4: (_) => RegisterStep4(),
      completeRegistration: (_) => RegistrationComplete(),
      home: (_) => Home(),
    };
  }
}
