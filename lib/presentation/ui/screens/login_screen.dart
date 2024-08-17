// ui + firebase login code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/ui/screens/home_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';
import 'package:socialive/app/utility/app_font_style.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 180),
              Text(
                'Welcome back!\nEnter your Email & Password',
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
                prefixIcon: AssetsPath.envelope,
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
                  prefixIcon: AssetsPath.lock,
                  controllerTE: _controllerPassword,
                  hint: 'Input Password',
                  obscure: true),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: save,
                    activeColor: AppColors.primaryColor,
                    onChanged: (bool? val) {
                      save = !save;
                      setState(() {
                        // ------------- convert to Getx
                        // implement ------------------------------------------------
                      });
                    },
                  ),
                  const Text('Save Password'),
                ],
              ),
              const SizedBox(height: 15),
              elevatedBtn(
                btnName: 'Log In',
                onPressed: signUserIn, //-------------------------------------
              )
            ],
          ),
        ),
      ),
    );
  }
  void signUserIn()async{
    // show loading circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      if(mounted){Navigator.pop(context);} // pop loading circle
      Get.to(() => const HomeScreen());
    }
    on FirebaseAuthException catch (e) {
      if(mounted){Navigator.pop(context);} // pop loading circle
      if (e.code == 'Invalid-email' || e.code == 'invalid-credential'){
        print('firebase error code: ${e.code}');
        if(mounted){
          showAlertDialog(context: context, title:'wrong combo', content: 'Wrong e-mail/password combination.');
        }
      }else{
        print('firebase error: ${e.code}');
        if(mounted){
          showAlertDialog(context: context, title:'firebase error', content: 'error code: ${e.code}');
        }
      }
    }
    catch(e){
      print("error: ${e.toString()}");
      if(mounted){
        Navigator.pop(context); // pop loading circle
        showAlertDialog(context: context, title:'error', content: 'Error occurred while logging in.');
      }
    }
  }
}
