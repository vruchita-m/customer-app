import 'package:flutter/material.dart';

class PoppinsText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontweight;
  final TextAlign? textalign;
  const PoppinsText(
      {super.key,
      this.text,
      this.color,
      this.fontsize,
      this.fontweight,
      this.textalign});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textalign,
      text!,
      style: TextStyle(
          color: color,
          fontSize: fontsize,
          fontWeight: fontweight,
          fontFamily: 'poppins'),
    );
  }
}
