import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final VoidCallback onPressed;
  const InternetExceptionWidget(
      {super.key,
      required this.onPressed,
      this.padding = const EdgeInsets.symmetric(horizontal: 15)});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Icon(
          Icons.cloud_off,
          color: Colors.red,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
            textAlign: TextAlign.center,
            "We're unable to show results.\n Please check your data \nconnection."),
        SizedBox(
          height: h * .15,
        ),
        Padding(
          padding: padding,
          child: SizedBox(
              width: w,
              child:
                  ElevatedButton(onPressed: onPressed, child: Text("Retry"))),
        )
      ],
    );
  }
}
