import 'package:flutter/material.dart';

import '../../shared/color.dart';
import '../../shared/font.dart';

class CustomTextField extends StatelessWidget {
  final double borderRadius;
  final bool obscureText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  CustomTextField({
    this.hintText,
    this.borderRadius = 36,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.center,
      style: regularCalibriFont.copyWith(
        height: 1.5,
        fontSize: 16,
        color: blackPure,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: whitePure,
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: regularCalibriFont.copyWith(
          fontSize: 16,
          color: grayPure,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
