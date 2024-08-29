import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/edit_profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_share_controller.dart';
import 'package:socialive/presentation/controllers/widget/loading_controller.dart';
import 'package:socialive/presentation/controllers/auth/login_screen_controller.dart';
import 'package:socialive/presentation/controllers/main_bottom_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/auth/sign_up_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/controllers/welcome_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.lazyPut(() => LoadingController(), fenix: true);
    Get.put(FollowingFollowersListScreenController());
    Get.put(WelcomeController());
    Get.put(MainBottomNavigationController());
    Get.put(ProfileController());
    Get.put(EditProfileController());
    Get.put(StatusController());
    Get.put(StatusShareController());
    Get.put(PostController());
  }
}
