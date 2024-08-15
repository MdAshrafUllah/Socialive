import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controllerTE,
    required this.hint,
    required this.prefixIcon,
    this.obscure = false,
    this.suffixIcon,
  });
  final TextEditingController controllerTE;
  final String hint;
  final bool obscure;
  final String prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerTE,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          prefixIcon,
          height: 20,
          width: 20,
          fit: BoxFit.scaleDown,
        ),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.inputFieldBorderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
