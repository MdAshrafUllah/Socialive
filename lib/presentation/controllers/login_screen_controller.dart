import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/sign_up_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/main_bottom_nev.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  RxBool isSave = true.obs;
  final storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginUser(String email, String password) async {
    try {
      loadingController.showLoading();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (isSave.isTrue) {
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          await storage.write('token', token);
        }
      }

      loadingController.hideLoading();
      Get.snackbar(
        'Login Success',
        'Login successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
      Get.offAll(() => const MainBottomNavigation());
    } on FirebaseAuthException catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Login Failed',
        e.message ?? 'An unknown error occurred',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Login Failed',
        'An error occurred. Please try again.',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }
}
