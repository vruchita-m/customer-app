// import 'package:flutter/material.dart';

// import '../../config/colors/colors.dart';

// class CustomTextFormField2 extends StatelessWidget {
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final String hintText;
//   final int? maxLines;
//   final int? maxLength;
//   final Widget? SuffixIcon;
//   final bool readonly;
//   final BoxConstraints? constraintBox;
//   final EdgeInsetsGeometry? contentPadding;
//   final String? countertext;
//   const CustomTextFormField2(
//       {super.key,
//       required this.readonly,
//       this.constraintBox,
//       this.SuffixIcon,
//       this.contentPadding,
//       this.validator,
//       required this.hintText,
//       this.controller,
//       required this.keyboardType,
//       this.maxLength,
//       this.countertext,
//       this.maxLines});
//   @override
//   Widget build(BuildContext context) {
//     // double height = MediaQuery.of(context).size.height;
//     // double width = MediaQuery.of(context).size.width;
//     return TextFormField(
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       readOnly: readonly,
//       controller: controller,
//       validator: validator,
//       keyboardType: keyboardType,
//       maxLength: maxLength,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//           counterText: countertext,
//           suffixIcon: SuffixIcon,
//           // constraints: constraintBox,
//           // constraints:
//           //     BoxConstraints(maxHeight: height * 0.06, maxWidth: width),
//           fillColor: AppColors.whitecol,
//           filled: true,
//           contentPadding: const EdgeInsets.only(left: 25, top: 16, bottom: 16),
//           hintText: hintText,
//           hintStyle: const TextStyle(
//               color: AppColors.lightblackcol,
//               fontFamily: 'inter',
//               fontSize: 14,
//               fontWeight: FontWeight.w300),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide:
//                   BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide:
//                   BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide:
//                   BorderSide(color: AppColors.lightblackcol.withOpacity(0.25))),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: const BorderSide(color: AppColors.colred)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: const BorderSide(color: AppColors.colred))),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:service_mitra/utlis/uppercase_textformator.dart';

import '../../config/colors/colors.dart';

class CustomTextFormField2 extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String hintText;
  final String? startext;
  final int? maxLines;
  final int? maxLength;
  final Widget? SuffixIcon;
  final bool readonly;
  final BoxConstraints? constraintBox;
  final EdgeInsetsGeometry? contentPadding;
  final String? countertext;
  final bool capChars;

  const CustomTextFormField2({
    super.key,
    required this.readonly,
    this.constraintBox,
    this.SuffixIcon,
    this.contentPadding,
    this.validator,
    required this.hintText,
    this.startext,
    this.controller,
    required this.keyboardType,
    this.maxLength,
    this.countertext,
    this.maxLines,
    this.capChars = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14, fontFamily: 'inter'),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: readonly,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: capChars ? [UpperCaseTextFormatter()] : [], 
      decoration: InputDecoration(
        counterText: countertext,
        suffixIcon: SuffixIcon,
        fillColor: AppColors.whitecol,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 25, top: 16, bottom: 16),
        label: RichText(
          text: TextSpan(
            text: hintText,
            style: const TextStyle(
              color: AppColors.lightblackcol,
              fontFamily: 'inter',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: startext,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colred,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: AppColors.lightblackcol.withOpacity(0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: AppColors.lightblackcol.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: AppColors.lightblackcol.withOpacity(0.25)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.colred),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.colred),
        ),
      ),
    );
  }
}
