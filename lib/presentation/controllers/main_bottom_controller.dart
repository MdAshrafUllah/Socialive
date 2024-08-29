import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';

class MainBottomNavigationController extends GetxController {
  final ProfileController profileController = Get.put(ProfileController());
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    profileController.initializeUser();
    Future.delayed(const Duration(seconds: 2), () {
      profileController.showIncompleteProfileAlert();
    });
  }

  void onItemTapped(int index) {
    if (index == 2) {
      // showUploadImageDialog();
    } else {
      selectedIndex.value = index;
    }
    update();
  }
}
