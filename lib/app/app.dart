import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/theme/light_theme_data.dart';
import 'package:socialive/controller_binder.dart';
import 'package:socialive/presentation/ui/screens/welcome_screen.dart';

class Socialive extends StatelessWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const Socialive({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Live',
      theme: lightThemeDataStyle(),
      initialBinding: ControllerBinder(),
      home: const WelComeScreen(),
    );
  }
}
