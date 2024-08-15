import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_font_style.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Socialive',
      style: AppFontStyle.lobster400S24,
    );
  }
}
