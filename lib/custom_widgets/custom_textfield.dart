import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isObscure;
  final Color borderColor;
  final Color hintColor;
  final bool isStyle;
  final TextInputType textInputType;
  final bool readOnly;
  final Widget? suffix;
  final String? prefixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final bool isFilled;
  final Color fillColor;
  final bool isCustomFilled;
  final bool? isImagePng;
  final Color? iconColor;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.isObscure = false,
    this.borderColor = kBlackShade7Color,
    this.fillColor = kWhiteShade2Color,
    this.isFilled = false,
    this.hintColor = kGreyShade7Color,
    this.isStyle = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
    this.isImagePng = false,
    this.suffix,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.borderRadius = 16,
    this.isCustomFilled = false,
    this.iconColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isObscure,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(
          color: widget.hintColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.isImagePng == true
              ? Image.asset(
            widget.prefixIcon!,
            height: 24,
            width: 24,
          )
              : SvgPicture.asset(
            widget.prefixIcon!,
            height: 24,
            width: 24,
            color: _isFocused
                ? kPrimaryColor
                : widget.iconColor ?? kGreyShade7Color,
          ),
        )
            : null,
        contentPadding:
        EdgeInsets.symmetric(vertical: 23.h, horizontal: 20.w),
        filled: widget.isFilled || widget.isCustomFilled,
        fillColor: widget.isCustomFilled
            ? widget.fillColor
            : widget.fillColor.withOpacity(0.07),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _isFocused ? kPrimaryColor : widget.borderColor,
            width: 2,
          ),
        ),
      ),
      style: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: kBlackColor,
      ),
    );
  }
}

