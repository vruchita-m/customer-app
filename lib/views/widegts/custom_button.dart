import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

class CustomButton extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomButton({Key? key, required this.text})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.primarycol),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'inter',
              fontWeight: FontWeight.w600,
              color: AppColors.whitecol),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
