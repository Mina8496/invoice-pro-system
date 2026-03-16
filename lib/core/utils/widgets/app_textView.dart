import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;
  TextAlign? textAlign;
  dynamic fontWeight;

  AppText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.textAlign,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.h),
      child: Text(
        text!,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 15.sp,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    );
  }
}
