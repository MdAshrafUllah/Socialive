import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchTEController,
  });

  final TextEditingController searchTEController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTEController,
      decoration: InputDecoration(
        hintText: "Search",
        contentPadding: const EdgeInsets.symmetric(vertical:0),
        hintStyle: AppFontStyle.satoshi400S14,
        prefixIcon:SvgPicture.asset(
          AssetsPath.search,
          height: 20,
          width: 20,
          fit: BoxFit.scaleDown,
        ),

      ),
    );
  }
}