import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/widget/loading_controller.dart';
import 'package:socialive/presentation/ui/screens/auth/login_screen.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

final LoadingController loadingController = Get.find<LoadingController>();

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordCheckVisible = false.obs;

  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordCheckVisible() {
    isPasswordCheckVisible.value = !isPasswordCheckVisible.value;
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      loadingController.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'profileImage': '',
        'username': '',
        'following': [],
        'followers': [],
        'posts': []
      });

      loadingController.hideLoading();
      Get.snackbar(
        'Sign in Success',
        'Account created successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
      Get.offAll(const LoginScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        loadingController.hideLoading();
        Get.snackbar(
          'Sign in Failed',
          'The email address is already in use.',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.foregroundColor,
        );
      } else {
        loadingController.hideLoading();
        Get.snackbar(
          'Sign in Failed',
          e.message ?? 'An error occurred.',
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.foregroundColor,
        );
      }
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Sign in Failed',
        e.toString(),
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }

  signUp() {
    if (passwordController.text == passwordCheckController.text) {
      if (formKey.currentState!.validate()) {
        emailController.text.trim();
        passwordController.text.trim();
        nameController.text.trim();
      }
    } else {
      showAlertDialog(
        title: 'Passwords did not match',
        content: 'Please enter the same password in both fields.',
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
