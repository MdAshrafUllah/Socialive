import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';

class SliderPointIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double size;
  final double spacing;
  final double verticalPadding;

  const SliderPointIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.size = 12,
    this.spacing = 2,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: spacing, vertical: verticalPadding),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor),
              color: currentIndex == index
                  ? AppColors.primaryColor
                  : AppColors.transparentColor,
            ),
            child: Container(
              width: size - 2,
              height: size - 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.foregroundColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
