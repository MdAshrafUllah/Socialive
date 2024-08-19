import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/loading_controller.dart';
import 'package:socialive/presentation/controllers/login_screen_controller.dart';
import 'package:socialive/presentation/controllers/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/sign_up_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileScreenController());
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.put(LoadingController());
  }
}
