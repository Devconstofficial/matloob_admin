import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final String title;
  final Color textColor;
  final Color color;
  final double width;
  final double height;
  final double textSize;
  final Function()? onTap;
  final bool showShadow;
  final Color? borderColor;
  final String? icon;
  final FontWeight fontWeight;
  final Color? iconColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor = kWhiteColor,
    this.color = kPrimaryColor,
    this.width = double.infinity,
    this.height = 53,
    this.borderRadius = 12,
    this.textSize = 17,
    this.showShadow = false,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? kPrimaryColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  height: 20.h,
                  width: 20.w,
                  color: iconColor,
                ),
                SizedBox(width: 6.w),
              ],
              CustomText(
                text: title,
                fontSize: textSize,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
