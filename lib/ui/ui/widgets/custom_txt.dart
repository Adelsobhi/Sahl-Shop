import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class CustomTxt extends StatelessWidget {
  final Color? fontColor;
  final String text;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final TextOverflow overflow;
  final int? maxLines;


  const CustomTxt({
    this.fontWeight,
    required this.text,
    this.fontColor,
    this.textStyle,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      maxLines: 1,
      text,
      style: textStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(
        color: fontColor ?? AppColors.primaryColor,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}