import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class Routes {
  static const String _onboardingScreen = "/onboarding_screen";
  static const String _loginView = "/login_view";
  static const String _sendOtdView = "/send_otp_view";
  static const String _verifyOtpVerify = "/verify_otp_view";
  static const String _resetPasswordView = "/reset_password_view";
  static const String _registerStep1 = "/register_step1";
  static const String _registerStep2 = "/register_step2";
  static const String _registerStep3 = "/register_step3";
  static const String _registerStep4 = "/register_step4";
  static const String _completeRegistration = "/complete_registration";
  static const String _splashView = "/splash_view";

  static String getOnboardingScreen() => _onboardingScreen;
  static String getLoginView() => _loginView;
  static String getSendOtp() => _sendOtdView;
  static String getVerifyOtpView() => _verifyOtpVerify;
  static String getResetPasswordView() => _resetPasswordView;
  static String getRegisterStep1() => _registerStep1;
  static String getRegisterStep2() => _registerStep2;
  static String getRegisterStep3() => _registerStep3;
  static String getRegisterStep4() => _registerStep4;
  static String getCompleteRegistration() => _completeRegistration;
  static String getSplashView() => _splashView;

  static List<GetPage> routes = [
    GetPage(name: _onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: _loginView, page: () => LoginView()),
    GetPage(name: _sendOtdView, page: () => SendOtpView()),
    GetPage(name: _verifyOtpVerify, page: () => VerifyOtpView(id: "")),
    GetPage(name: _resetPasswordView, page: () => UpdatePasswordView()),
    GetPage(name: _registerStep1, page: () => RegisterStep1()),
    GetPage(name: _registerStep2, page: () => RegisterStep2()),
    GetPage(name: _registerStep3, page: () => RegisterStep3()),
    GetPage(name: _registerStep4, page: () => RegisterStep4()),
    GetPage(name: _completeRegistration, page: () => RegistrationComplete()),
    GetPage(name: _splashView, page: () => SplashScreen()),
  ];
}

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
      home:(_)=>Home()
    };
  }
}
