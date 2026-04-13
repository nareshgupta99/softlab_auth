import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:softlab_auth/features/auth/auth_dataservice.dart';
import 'package:softlab_auth/features/auth/auth_repository.dart';
import 'package:softlab_auth/helper/routes.dart';
import 'package:softlab_auth/network/request/network_request.dart';
import 'package:softlab_auth/utils/app_overlay.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository repository;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  AuthController({required this.repository});

  RxBool loading = false.obs;
  Rx<String> registrationProof = Rx("");
  Rx<String?> state = Rx<String?>(null);
  Rx<Map<String, List<String>>> businessHours = Rx<Map<String, List<String>>>({});
  //text Editing controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordcontroller = TextEditingController();
  TextEditingController businessNamecontroller = TextEditingController();
  TextEditingController informalNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  reset() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    passwordController.text = "";
    cPasswordcontroller.text = "";
    businessNamecontroller.text = "";
    informalNameController.text = "";
    addressController.text = "";
    cityController.text = "";
    stateController.text = "";
    zipcodeController.text = "";
  }

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
      AuthRequest authPayload = AuthRequest();
      authPayload.email = emailController.text;
      authPayload.password = passwordController.text;
      authPayload.role = "farmer";
      authPayload.socialId = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
      login("email", authPayload);
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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication auth = account.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      final credentail = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = credentail.user;
      AuthRequest authPayload = AuthRequest();
      authPayload.email = user?.email;
      authPayload.role = "farmer";
      authPayload.socialId = user?.providerData.first.uid;
      login("google", authPayload);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        print("User cancelled login $e");
      } else {
        print("Google error: ${e.code} - ${e.description}");
      }
      return;
    } catch (e) {
      print('Error: $e');
      return;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);

        final credentail = await FirebaseAuth.instance.signInWithCredential(credential);
        final user = credentail.user;
        final userData = await FacebookAuth.instance.getUserData();

        AuthRequest authPayload = AuthRequest();
        authPayload.email = user?.email ?? userData['email'];
        authPayload.role = "farmer";
        authPayload.socialId = user?.providerData.first.uid;
        login("facebook", authPayload);
      } else {
        print("Facebook login failed: ${result.status}");
      }
    } catch (e) {
      print("Facebook error: $e");
    }
  }
}
