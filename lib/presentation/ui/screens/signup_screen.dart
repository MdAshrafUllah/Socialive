// ui only
import 'package:flutter/material.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerPassword2.dispose();
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
              const SizedBox( height: 120),
              Text(
                'Join With Us!\nEnter your Email & Password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              const SizedBox(height: 36),
              const Row(
                children: [
                  SizedBox(
                    child: Text(
                      'Email',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TextFieldWidget(
                controllerTE: _controllerEmail,
                hint: 'Input Email',
              ),
              const SizedBox(height: 8),
              const Row(children: [
                SizedBox(
                  child: Text(
                    'Password',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              ),
              TextFieldWidget(
                  controllerTE: _controllerPassword,
                  hint: 'Input Password',
                  obscure: true
              ),
              const SizedBox(height: 8),
              const Row(children: [
                SizedBox(
                  child: Text(
                    'Confirm Password',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              ),
              TextFieldWidget(
                  controllerTE: _controllerPassword2,
                  hint: 'Input Password',
                  obscure: true
              ),
              const SizedBox(height: 24),
              elevatedBtn(
                  btnName: 'Sign Up',
                  onPressed: funcForElevatedBtn,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void funcForElevatedBtn(){
    if(_controllerPassword.text == _controllerPassword2.text){
      // implement ----------------------------------------------------------------
    }else{
      showAlertDialog(
        context: context,
        title: 'Passwords did not match',
        content: 'Please enter same passwords in 2 fields.',
      );
    }
  }
}
