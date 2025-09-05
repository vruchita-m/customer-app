import 'package:flutter/material.dart';

class CabinText extends StatelessWidget {
  final double? height;
  final String? text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontweight;
  final TextAlign? textalign;
  const CabinText(
      {super.key,
      this.height,
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
          height: height,
          color: color,
          fontSize: fontsize,
          fontWeight: fontweight,
          fontFamily: 'cabin'),
    );
  }
}
