import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../screens/cart/components/custom_text.dart';
import 'call_back_function.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final double? height;
  final OnChanged onChanged;
  final ValidatorFormField? validator;
  final TextInputType? keyBoardType;
  final Color? fillColor;
  final bool isFilled;
  final FontWeight? weight;
  final TextStyle? hintStyle;
  final String? labelText; // Added labelText property
  final int? maxLines;
  final bool readOnly;
  final bool isCommentField;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;
  final String? trailingText;
  final bool isTrailingText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.suffixIcon,
    this.weight,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
    this.height = 56,
    this.inputFormatters,
    this.isVisibleText = false,
    this.readOnly = false,
    this.obscuringCharacter = '*',
    this.prefixIcon,
    this.fillColor,
    this.isFilled = false,
    this.trailingText,
    this.isTrailingText = false,
    this.isCommentField = false,
    this.maxLines,
    this.labelText, // Added labelText to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.black,
      cursorHeight: 20,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, left: 17),
        hintText: hintText,
        labelText: labelText, // Set the labelText here
        alignLabelWithHint: true,
        suffixIcon: isTrailingText
            ? Padding(
          padding: const EdgeInsets.only(top: 15, right: 20),
          child: CustomText(
            title: '$trailingText',
            weight: FontWeight.w600,
            size: 14,
          ),
        )
            : suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: isFilled,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        suffixStyle: suffixStyle,
      ),
      keyboardType: keyBoardType,
    );
  }
}
