import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/navigation/profile/edit_profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/post_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_share_controller.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/controllers/share_content_controller.dart';
import 'package:socialive/presentation/controllers/widget/loading_controller.dart';
import 'package:socialive/presentation/controllers/auth/login_screen_controller.dart';
import 'package:socialive/presentation/controllers/main_bottom_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/auth/sign_up_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/controllers/welcome_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.put(LoadingController());
    Get.put(WelcomeController());
    Get.put(MainBottomNavigationController());
    Get.put(ProfileController());
    Get.put(FollowingFollowersListController());
    Get.put(EditProfileController());
    Get.put(StatusController());
    Get.put(StatusShareController());
    Get.put(PostController());
    Get.put(ImageSelectionController());
    Get.put(ShareContentController());
  }
}
