import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/auth/login_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';
import 'package:socialive/app/utility/app_font_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _loginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.07),
                backBtn(),
                SizedBox(height: height * 0.07),
                Text(
                  'Welcome back!\nEnter your Email & Password',
                  style: AppFontStyle.inter400S22C,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Email',
                  style: AppFontStyle.satoshi700S18,
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  prefixIcon: AssetsPath.envelope,
                  controllerTE: _loginController.emailController,
                  hint: 'Input Email',
                  validator: "Enter Your Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Password',
                  style: AppFontStyle.satoshi700S18,
                ),
                const SizedBox(height: 5),
                Obx(
                  () => TextFieldWidget(
                    prefixIcon: AssetsPath.lock,
                    controllerTE: _loginController.passwordController,
                    hint: 'Input Password',
                    obscure: !_loginController.isPasswordVisible.value,
                    suffixIcon: _loginController.isPasswordVisible.value
                        ? AssetsPath.eye
                        : AssetsPath.eyeSlash,
                    textInputAction: TextInputAction.done,
                    validator: "Enter Your Password",
                    onTap: () {
                      _loginController.togglePasswordVisible();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: _loginController.isSave.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: _loginController.isSave.call,
                      ),
                    ),
                    const Text('Save Password'),
                  ],
                ),
                const SizedBox(height: 10),
                elevatedBtn(
                  btnName: 'Log In',
                  onPressed: _loginController.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
