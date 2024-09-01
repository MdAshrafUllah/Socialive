import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.controllerTE,
      required this.hint,
      required this.prefixIcon,
      required this.validator,
      this.textInputAction,
      this.obscure = false,
      this.suffixIcon,
      this.keyboardType,
      this.onTap,
      this.enabled = true,
      this.onFieldSubmitted});
  final TextEditingController controllerTE;
  final String hint;
  final bool obscure;
  final String prefixIcon;
  final String? suffixIcon;
  final String validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final bool enabled;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(
                  suffixIcon!,
                  height: 35,
                  width: 35,
                  fit: BoxFit.scaleDown,
                ),
              )
            : null,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      validator: (String? text) {
        if (text?.isEmpty ?? true) {
          return validator;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
