import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/app_bar.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/constants/image_constants.dart';
import 'package:softlab_auth/features/auth/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:softlab_auth/helper/routes.dart';

class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    cPasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: context.read<RegisterBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, MRoutes.login),
                    child: Text('Login', style: TextStyle(color: RegisterStep1.kTextDark, fontSize: 15.sp, decoration: TextDecoration.underline)),
                  ),
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        context.read<RegisterBloc>().add(
                          UpdatePersonalInfo(
                            fullName: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            cpassword: cPasswordcontroller.text,
                          ),
                        );
                        context.read<RegisterBloc>().add(NextStep());
                      },
                      text: "Continue",
                      color: Color(0xFFCD6B5A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: const FarmerEatsAppBar(),
          body: KeyboardActions(
            config: KeyboardActionsConfig(
              keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
              actions: [
                KeyboardActionsItem(
                  displayDoneButton: true,
                  displayArrows: true,
                  focusNode: nameFocus,
                  toolbarButtons: [
                    (node) {
                      return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                    },
                  ],
                ),
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
                  displayArrows: true,
                  focusNode: phoneFocus,
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
                KeyboardActionsItem(
                  displayDoneButton: true,
                  displayArrows: true,
                  focusNode: confirmPasswordFocus,
                  toolbarButtons: [
                    (node) {
                      return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                    },
                  ],
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text("Signup 1 of 4", style: TextStyle(color: RegisterStep1.kSubtitle, fontSize: 13, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    const Text(
                      "Farm Info",
                      style: TextStyle(color: RegisterStep1.kTextDark, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 28),

                    // Social buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(imageUrl: Images.google, onTap: () {}),
                        SizedBox(width: 16.h),
                        SocialButton(imageUrl: Images.facebook, onTap: () {}),
                        SizedBox(width: 16.h),
                        SocialButton(imageUrl: Images.apple, onTap: () {}),
                      ],
                    ),

                    SizedBox(height: 20.h),
                    const Center(child: Text('or signup with', style: TextStyle(color: RegisterStep1.kSubtitle, fontSize: 13))),
                    SizedBox(height: 16.h),

                    // Form fields
                    CustomTextField(prefixIcon: Icons.person_outline, hintText: 'Full Name', controller: nameController, focus: nameFocus),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.alternate_email,
                      hintText: 'Email Address',
                      controller: emailController,
                      focus: emailFocus,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.phone_outlined,
                      hintText: 'Phone Number',
                      controller: phoneController,
                      focus: phoneFocus,
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.lock_outline,
                      hintText: 'Password',
                      controller: passwordController,
                      focus: passwordFocus,
                      keyboardType: TextInputType.text,
                      obsecureText: true,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.lock_outline,
                      hintText: 'Re-enter Password',
                      controller: cPasswordcontroller,
                      focus: confirmPasswordFocus,
                      keyboardType: TextInputType.text,
                      obsecureText: true,
                    ),
                    // const Spacer(),
                    // Expanded(child: SizedBox()),
                    SizedBox(height: 64.h),
                    // Bottom bar
                    // Row(
                    //   children: [
                    //     TextButton(
                    //       onPressed: () {
                    //         Get.offNamed(Routes.getLoginView());
                    //       },
                    //       child: Text('Login', style: TextStyle(color: kTextDark, fontSize: 15.sp, decoration: TextDecoration.underline)),
                    //     ),
                    //     // const Spacer(),
                    //     Expanded(
                    //       child: customButton(
                    //         onPressed: () {
                    //           authController.registerWithValidation(1, context);
                    //         },
                    //         text: "Continue",
                    //         color: Color(0xFFCD6B5A),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 16),
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
