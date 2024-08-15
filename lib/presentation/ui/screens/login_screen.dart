// ui only
import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/font_style.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool save = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            children: [
              const SizedBox( height: 180),
              Text(
                'Welcome back!\nEnter your Email & Password',
                textAlign: TextAlign.center,
                style: AppFontStyle.headLineMedium,
              ),
              const SizedBox(height: 36),
              const Row(
                children: [
                  SizedBox(
                    child: Text(
                      'Email',
                      style: AppFontStyle.satoshi700S18,
                    ),
                  ),
                ],
              ),
              TextFieldWidget(
                controllerTE: _controllerEmail,
                hint: 'Input Email',
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  SizedBox(
                    child: Text(
                      'Password',
                      style: AppFontStyle.satoshi700S18,
                    ),
                  ),
                ],
              ),
              TextFieldWidget(
                  controllerTE: _controllerPassword,
                  hint: 'Input Password',
                  obscure: true
              ),
              Row(
                children: [
                  Checkbox(
                    value: save,
                    activeColor: AppColors.primaryColor,
                    onChanged: (bool? val) {
                      save = !save;
                      setState(() { // ------------- convert to Getx
                        // implement ------------------------------------------------
                      });
                    },
                  ),
                  const Text('Save Password'),
                ],
              ),
              const SizedBox(height: 8),
              elevatedBtn(
                  btnName: 'Log In',
                  onPressed: () {
                    // implement ------------------------------------------------
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
