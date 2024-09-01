import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/images_selection_screen.dart';
import 'package:socialive/presentation/ui/widgets/upload_image_dialog.dart';

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
      showUploadImageDialog(
        fromCamera: () {},
        fromGallery: () => Get.off(() => const ImagesSelectionScreen()),
      );
    } else {
      selectedIndex.value = index;
    }
    update();
  }
}
