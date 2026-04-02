import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/app_bar.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/drop_down.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';
import 'package:softlab_auth/helper/routes.dart';

class RegisterStep2 extends StatelessWidget {
  RegisterStep2({super.key});
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);
  FocusNode businessNameFocus = FocusNode();
  FocusNode informalNameFocus = FocusNode();
  FocusNode streetAddressFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode zipCodeFocus = FocusNode();
  static const _states = [
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY',
  ];

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FarmerEatsAppBar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Row(
            children: [
              TextButton(
                onPressed: () =>  Navigator.pushReplacementNamed(context, MRoutes.login),
                child: Text('Login', style: TextStyle(color: kTextDark, fontSize: 15.sp, decoration: TextDecoration.underline)),
              ),
              Expanded(
                child: customButton(onPressed: () => authController.registerWithValidation(2, context), text: "Continue", color: Color(0xFFCD6B5A)),
              ),
            ],
          ),
        ),
      ),
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
          actions: [
            KeyboardActionsItem(
              displayDoneButton: true,
              displayArrows: true,
              focusNode: businessNameFocus,
              toolbarButtons: [
                (node) {
                  return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                },
              ],
            ),
            KeyboardActionsItem(
              displayDoneButton: true,
              displayArrows: true,
              focusNode: informalNameFocus,
              toolbarButtons: [
                (node) {
                  return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                },
              ],
            ),
            KeyboardActionsItem(
              displayDoneButton: true,
              displayArrows: true,
              focusNode: streetAddressFocus,
              toolbarButtons: [
                (node) {
                  return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                },
              ],
            ),
            KeyboardActionsItem(
              displayDoneButton: true,
              focusNode: cityFocus,
              toolbarButtons: [
                (node) {
                  return TextButton(onPressed: () => node.unfocus(), child: Text("Done"));
                },
              ],
            ),
            KeyboardActionsItem(
              displayDoneButton: true,
              displayArrows: true,
              focusNode: zipCodeFocus,
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
                const Text("Signup 2 of 4", style: TextStyle(color: kSubtitle, fontSize: 13, fontWeight: FontWeight.w400)),
                const SizedBox(height: 4),
                const Text("Farm Info", style: TextStyle(color: kTextDark, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                SizedBox(height: 16.h),

                // Form fields
                CustomTextField(
                  prefixIcon: Icons.alternate_email,
                  hintText: 'Business Name',
                  controller: authController.businessNamecontroller,
                  focus: businessNameFocus,
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 12.h),
                CustomTextField(
                  prefixIcon: Icons.sentiment_satisfied_outlined,
                  hintText: 'Informal Name',
                  controller: authController.informalNameController,
                  focus: informalNameFocus,
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 12.h),
                CustomTextField(
                  prefixIcon: Icons.home_outlined,
                  hintText: 'Street Address',
                  controller: authController.addressController,
                  focus: streetAddressFocus,
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 12.h),
                CustomTextField(
                  prefixIcon: Icons.location_on_outlined,
                  hintText: 'City',
                  controller: authController.cityController,
                  focus: cityFocus,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        String? selected = authController.state.value;
                        return StateDropdown(
                          states: _states,
                          onchanged: (value) {
                            authController.state.value = value;
                          },
                          selected: selected,
                        );
                      }),
                    ),
                    SizedBox(width: 7.w),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(hintText: 'Enter Zipcode', controller: authController.zipcodeController, focus: zipCodeFocus),
                    ),
                  ],
                ),
                SizedBox(height: 64.h),
                // Bottom bar
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         Get.offNamed(Routes.getRegisterStep1());
                //       },
                //       icon: Icon(Icons.arrow_back_sharp),
                //     ),
                //     Expanded(
                //       child: customButton(
                //         onPressed: () {
                //           authController.registerWithValidation(2, context);
                //         },
                //         text: "Continue",
                //         color: Color(0xFFCD6B5A),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
