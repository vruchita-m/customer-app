import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String hintText;
  final String? errortext;
  final int? maxLines;
  final int? maxLength;
  final Widget? SuffixIcon;
  final bool? obscureText;
  final BoxConstraints? constraintBox;
  final EdgeInsetsGeometry? contentPadding;
  final String? countertext;
  const CustomTextFormField(
      {super.key,
      this.onChanged,
      this.errortext,
      this.constraintBox,
      this.SuffixIcon,
      this.contentPadding,
      this.validator,
      required this.hintText,
      this.controller,
      required this.keyboardType,
      this.maxLength,
      this.obscureText,
      this.countertext,
      this.maxLines});
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return TextFormField(
      // textDirection: TextDirection.ltr,
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          errorText: errortext,
          counterText: countertext,
          suffixIcon: SuffixIcon,
          // constraints: constraintBox,
          // constraints:
          //     BoxConstraints(maxHeight: height * 0.06, maxWidth: width),
          fillColor: AppColors.textformfieldcol,
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
              borderSide: const BorderSide(color: AppColors.whitecol)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.whitecol)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.whitecol)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.whitecol)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.whitecol))),
    );
  }
}
