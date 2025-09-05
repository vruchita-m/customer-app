import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

class CustomTextFormField3 extends StatelessWidget {
  final String? text;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  final int? maxLength;
  final Widget? SuffixIcon;
  final bool readonly;
  final BoxConstraints? constraintBox;
  final EdgeInsetsGeometry? contentPadding;
  final String? countertext;
  final Color? fillColor;
  const CustomTextFormField3({
    super.key,
    this.text,
    required this.readonly,
    this.constraintBox,
    this.SuffixIcon,
    this.contentPadding,
    this.validator,
    required this.hintText,
    this.controller,
    required this.keyboardType,
    this.maxLength,
    this.countertext,
    this.maxLines,
    this.fillColor,
  });
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return TextFormField(
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'inter',
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: readonly,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
          counterText: countertext,
          suffixIcon: SuffixIcon,
          // constraints: constraintBox,
          // constraints:
          //     BoxConstraints(maxHeight: height * 0.06, maxWidth: width),
          fillColor: fillColor ?? AppColors.whitecol,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 25, top: 16, bottom: 16),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: AppColors.lightblackcol,
              fontFamily: 'inter',
              fontSize: 14,
              fontWeight: FontWeight.w300),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.colred)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.colred))),
    );
  }
}
