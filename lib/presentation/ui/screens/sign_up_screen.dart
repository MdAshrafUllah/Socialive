import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/sign_up_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  final SignUpController _signUpController = Get.find<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.07),
                backBtn(),
                SizedBox(height: height * 0.07),
                Text(
                  'Join us!\nShare your moments with others.',
                  style: AppFontStyle.inter400S22C,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Name',
                  style: AppFontStyle.satoshi700S18,
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  prefixIcon: AssetsPath.person,
                  controllerTE: _nameController,
                  hint: 'Input Name',
                  validator: "Enter Your Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Email',
                  style: AppFontStyle.satoshi700S18,
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  prefixIcon: AssetsPath.envelope,
                  controllerTE: _emailController,
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
                    controllerTE: _passwordController,
                    hint: 'Input Password',
                    obscure: !_signUpController.isPasswordVisible.value,
                    suffixIcon: _signUpController.isPasswordVisible.value
                        ? AssetsPath.eye
                        : AssetsPath.eyeSlash,
                    textInputAction: TextInputAction.next,
                    validator: "Enter Your Password",
                    onTap: () {
                      _signUpController.togglePasswordVisible();
                    },
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Confirm Password',
                  style: AppFontStyle.satoshi700S18,
                ),
                const SizedBox(height: 5),
                Obx(
                  () => TextFieldWidget(
                    prefixIcon: AssetsPath.lock,
                    controllerTE: _passwordCheckController,
                    hint: 'Confirm Password',
                    obscure: !_signUpController.isPasswordCheckVisible.value,
                    suffixIcon: _signUpController.isPasswordCheckVisible.value
                        ? AssetsPath.eye
                        : AssetsPath.eyeSlash,
                    textInputAction: TextInputAction.done,
                    validator: "Enter Confirm Password",
                    onTap: () {
                      _signUpController.togglePasswordCheckVisible();
                    },
                  ),
                ),
                const SizedBox(height: 25),
                elevatedBtn(
                  btnName: 'Sign Up',
                  onPressed: _signUp,
                ),
                SizedBox(height: height * 0.07),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() {
    if (_passwordController.text == _passwordCheckController.text) {
      if (_formKey.currentState!.validate()) {
        _signUpController.createUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        );
      }
    } else {
      showAlertDialog(
        context: context,
        title: 'Passwords did not match',
        content: 'Please enter the same password in both fields.',
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
