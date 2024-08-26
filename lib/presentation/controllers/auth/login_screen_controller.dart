import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/auth/sign_up_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/main_bottom_nev.dart';

final ProfileController profileController = Get.put(ProfileController());
final StatusController statusController = Get.put(StatusController());

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isSave = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      loadingController.showLoading();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      profileController.initializeUser();
      statusController.getCurrentUserStatus();
      Future.delayed(const Duration(seconds: 2), () {
        profileController.showIncompleteProfileAlert();
      });

      if (isSave.isTrue) {
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
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

  login() {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      loginUser(email: email, password: password);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
