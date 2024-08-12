import 'package:flutter/material.dart';
import 'package:socialive/app/utility/font_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inter your Email and password',
              style: FontStyle.inter400S24,
            )
          ],
        ),
      ),
    );
  }
}
