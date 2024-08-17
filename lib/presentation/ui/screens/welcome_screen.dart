import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/ui/screens/home_screen.dart';
import 'package:socialive/presentation/ui/screens/login_screen.dart';
import 'package:socialive/presentation/ui/screens/signup_screen.dart';
import 'package:socialive/presentation/ui/widgets/app_logo.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

class WelComeScreen extends StatelessWidget {
  const WelComeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              const SizedBox(
                height: 50,
              ),
              elevatedBtn(
                  btnName: 'Create Account',
                  onPressed: () {
                    Get.to(() => const SignUpScreen());
                  }),
              const SizedBox(
                height: 20,
              ),
              textBtn(
                btnName: 'Log In',
                onPressed: (){ // user will be logged in if he doesn't manually logout in homepage
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    print("User is logged-in in with UID: ${user.uid}");
                    Get.to(const HomeScreen());
                  } else {
                    print("No user is logged-in.");
                    Get.to(() => const LoginScreen());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
