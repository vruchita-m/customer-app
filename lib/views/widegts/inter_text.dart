import 'package:flutter/material.dart';

class InterText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontweight;
  final TextAlign? textalign;
  final TextOverflow? textOverflow;
  final double? height;
  final int? maxLines;
  const InterText(
      {super.key,
      this.text,
      this.height,
      this.color,
      this.fontsize,
      this.textOverflow,
      this.fontweight,
      this.maxLines,
      this.textalign});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textalign,
      text!,
      maxLines: maxLines,
      style: TextStyle(
          height: height,
          color: color,
          
          overflow: textOverflow,
          fontSize: fontsize,
          fontWeight: fontweight,
          fontFamily: 'inter'),
    );
  }
}
