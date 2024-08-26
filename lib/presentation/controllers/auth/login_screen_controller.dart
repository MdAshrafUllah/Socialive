import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/auth/sign_up_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/screens/main_bottom_nev.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isSave = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProfileController profileController = Get.put(ProfileController());

  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginUser(String email, String password) async {
    try {
      loadingController.showLoading();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      profileController.initializeUser();
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
      emailController.text.trim();
      passwordController.text.trim();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
