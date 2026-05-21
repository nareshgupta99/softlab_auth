import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:softlab_auth/components/app_bar.dart';
import 'package:softlab_auth/components/buttons.dart';
import 'package:softlab_auth/components/drop_down.dart';
import 'package:softlab_auth/components/input_fields.dart';
import 'package:softlab_auth/features/auth/bloc/register_bloc/register_bloc.dart';
import 'package:softlab_auth/helper/routes.dart';

class RegisterStep2 extends StatefulWidget {
  RegisterStep2({super.key});
  static const kSubtitle = Color(0xFF888888);
  static const kTextDark = Color(0xFF1A1A1A);
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

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  FocusNode businessNameFocus = FocusNode();

  FocusNode informalNameFocus = FocusNode();

  FocusNode streetAddressFocus = FocusNode();

  FocusNode cityFocus = FocusNode();

  FocusNode zipCodeFocus = FocusNode();

  TextEditingController businessNamecontroller = TextEditingController();

  TextEditingController informalNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, UserRegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const FarmerEatsAppBar(),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, MRoutes.login),
                    child: Text('Login', style: TextStyle(color: RegisterStep2.kTextDark, fontSize: 15.sp, decoration: TextDecoration.underline)),
                  ),
                  Expanded(
                    child: customButton(
                      onPressed: () {
                        context.read<RegisterBloc>().add(
                          UpdateBusinessInfo(
                            businessName: businessNamecontroller.text,
                            informalName: informalNameController.text,
                            address: addressController.text,
                            city: cityController.text,
                            state: stateController.text,
                            zipCode: zipcodeController.text,
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
                    const Text("Signup 2 of 4", style: TextStyle(color: RegisterStep2.kSubtitle, fontSize: 13, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    const Text("Farm Info", style: TextStyle(color: RegisterStep2.kTextDark, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                    SizedBox(height: 16.h),

                    // Form fields
                    CustomTextField(
                      prefixIcon: Icons.alternate_email,
                      hintText: 'Business Name',
                      controller: businessNamecontroller,
                      focus: businessNameFocus,
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.sentiment_satisfied_outlined,
                      hintText: 'Informal Name',
                      controller: informalNameController,
                      focus: informalNameFocus,
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.home_outlined,
                      hintText: 'Street Address',
                      controller: addressController,
                      focus: streetAddressFocus,
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      prefixIcon: Icons.location_on_outlined,
                      hintText: 'City',
                      controller: cityController,
                      focus: cityFocus,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: StateDropdown(
                            states: RegisterStep2._states,
                            onchanged: (value) {
                              setState() {
                              stateController.text = value ?? "";
                              }
                            },
                            selected: stateController.text,
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(flex: 2, child: CustomTextField(hintText: 'Enter Zipcode', controller: zipcodeController, focus: zipCodeFocus)),
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
      },
    );
  }
}
