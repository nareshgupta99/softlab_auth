import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softlab_auth/features/auth/auth_controller.dart';
import 'package:softlab_auth/features/auth/auth_repository.dart';
import 'package:softlab_auth/network/network_manager.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => NetworkManager());

  // repository
  Get.lazyPut(() => AuthRepository(network: Get.find()));

  // controller
  Get.lazyPut(() => AuthController(repository: Get.find()));
}
