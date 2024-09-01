import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const ExpandableText({
    required this.text,
    required this.style,
    this.maxLines = 2,
    super.key,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.clip,
        ),
        if (!isExpanded && widget.text.length > 100)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              "See more...",
              style: widget.style.copyWith(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (isExpanded)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              "Show less",
              style: widget.style.copyWith(
                color: AppColors.textLightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
