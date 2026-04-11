import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softlab_auth/features/auth/auth_dataservice.dart';
import 'package:softlab_auth/features/auth/auth_repository.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/utils/app_overlay.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository repository;

  AuthController({required this.repository});

  RxBool loading = false.obs;
  Rx<String> registrationProof = Rx("");
  Rx<String?> state = Rx<String?>(null);
  Rx<Map<String, List<String>>> businessHours = Rx<Map<String, List<String>>>({});
  //text Editing controller
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController cPasswordcontroller = TextEditingController();
  // TextEditingController businessNamecontroller = TextEditingController();
  // TextEditingController informalNameController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController cityController = TextEditingController();
  // TextEditingController stateController = TextEditingController();
  // TextEditingController zipcodeController = TextEditingController();

  
  void registerWithValidation(int step, BuildContext context) {
    switch (step) {
      case 1:
        if (nameController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid Name', message: 'Please enter a valid Name.');
        } else if (emailController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid email', message: 'Please enter a valid email address.');
        } else if (phoneController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid Number', message: 'Please enter a valid number.');
        } else if (passwordController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid password', message: 'Please enter a valid password.');
        } else if (cPasswordcontroller.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid password', message: 'Please enter a valid password.');
        } else if (cPasswordcontroller.text != passwordController.text) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid password', message: 'Password and confirm password must be same.');
        } else {
          Get.toNamed(Routes.getRegisterStep2());
        }
      case 2:
        if (businessNamecontroller.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid business name', message: 'Please enter a valid business Name');
        } else if (informalNameController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid informal name', message: 'Please enter a valid informal Name');
        } else if (addressController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid address', message: 'Please enter a valid Street address');
        } else if (cityController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid city', message: 'Please enter a valid city');
        } else if (zipcodeController.text.isEmpty) {
          AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid zipcode', message: 'Please enter a valid zipcode');
        } else {
          Get.toNamed(Routes.getRegisterStep3());
        }
      case 3:
        if (registrationProof.value.isEmpty) {
        } else {
          Get.toNamed(Routes.getRegisterStep4());
        }
      case 4:
        register("email");
    }
  }

  void loginWithValidation(BuildContext context) {
    if (emailController.text.isEmpty) {
      AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid email', message: 'Please enter a valid email address.');
    } else if (passwordController.text.isEmpty) {
      AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid password', message: 'Please enter a valid password.');
    } else {
      login("email");
    }
  }

  void sendOtpWithValidation(BuildContext context) {
    if (phoneController.text.isEmpty) {
      AppOverlay.showMessage(context, type: OverlayType.error, title: 'Invalid phone', message: 'Please enter a valid number.');
    } else {
      forgotPassword();
      Get.toNamed(Routes.getVerifyOtpView());
    }
  }

  void attachFile() {
    registrationProof.value = "One.pdf";
  }

  void removeFile() {
    registrationProof.value = "";
  }
}
