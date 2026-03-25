import 'package:get/get.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/network/network_manager.dart';
import 'package:softlab_auth/network/request/network_request.dart';
import 'package:softlab_auth/utils/device_utils.dart';

extension AuthDataservice on AuthController {
  Future<void> register(type) async {
    loading.value = true;
    AuthRequest authPayload = AuthRequest();
    authPayload.fullName = nameController.text;
    authPayload.email = emailController.text;
    authPayload.phone = "+${phoneController.text}";
    authPayload.password = passwordController.text;
    authPayload.confirmPassword = cPasswordcontroller.text;
    authPayload.businessName = businessNamecontroller.text;
    authPayload.informalName = informalNameController.text;
    authPayload.address = addressController.text;
    authPayload.city = cityController.text;
    authPayload.role = "farmer";
    authPayload.state = state.value;
    authPayload.zipCode = zipcodeController.text;
    authPayload.registrationProof = registrationProof.value;
    authPayload.businessHours = businessHours.value;
    authPayload.socialId = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
    authPayload.type = type;
    authPayload.deviceToken = await DeviceUtils.getDeviceId();
    print("authPayload.deviceToken := ${authPayload.deviceToken}");

    await repository.register(authPayload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          Get.toNamed(Routes.getCompleteRegistration());
          loading.value = false;
          //  LocalStorage.setStringData(key: Keys.bearerToken,value: )
          break;
        case Result.onFailed:
          loading.value = false;
          Get.snackbar('Error', message ?? "error");
          break;
        case Result.onException:
          loading.value = false;
          Get.snackbar('Error', "error");
          break;
      }
    });
  }

  Future<void> login(String type) async {
    loading.value = true;
    AuthRequest authPayload = AuthRequest();
    authPayload.email = emailController.text;
    authPayload.password = passwordController.text;
    authPayload.role = "farmer";
    authPayload.deviceToken = await DeviceUtils.getDeviceId();
    authPayload.type = type;
    authPayload.socialId = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
    await repository.login(authPayload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading.value = false;
          Get.snackbar('Success', message ?? "error");
          break;
        case Result.onFailed:
          loading.value = false;
          Get.snackbar('Error', message ?? "error");
          break;
        case Result.onException:
          loading.value = false;
          Get.snackbar('Error', "error");
          break;
      }
    });
  }

  Future<void> forgotPassword() async {
    loading.value = true;
    AuthRequest authPayload = AuthRequest();
    authPayload.phone = "+${phoneController.text}";
    await repository.forgotPassword(authPayload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading.value = false;
          Get.snackbar('Success', message ?? "error");
          break;
        case Result.onFailed:
          loading.value = false;
          Get.snackbar('Error', message ?? "error");
          break;
        case Result.onException:
          loading.value = false;
          Get.snackbar('Error', "error");
          break;
      }
    });
  }

  Future<void> verifyOtp() async {
    loading.value = true;
    AuthRequest authPayload = AuthRequest();
    authPayload.otp = "";
    await repository.verifyOtp(authPayload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading.value = false;
          Get.snackbar('Success', message ?? "error");
          break;
        case Result.onFailed:
          loading.value = false;
          Get.snackbar('Error', message ?? "error");
          break;
        case Result.onException:
          loading.value = false;
          Get.snackbar('Error', "error");
          break;
      }
    });
  }

  Future<void> resetPassword(String token) async {
    loading.value = true;
    AuthRequest authPayload = AuthRequest();
    authPayload.password = passwordController.text;
    authPayload.confirmPassword = cPasswordcontroller.text;
    authPayload.token = token;

    await repository.resetPassword(authPayload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading.value = false;
          Get.snackbar('Success', message ?? "error");
          break;
        case Result.onFailed:
          loading.value = false;
          Get.snackbar('Error', message ?? "error");
          break;
        case Result.onException:
          loading.value = false;
          Get.snackbar('Error', "error");
          break;
      }
    });
  }
}
