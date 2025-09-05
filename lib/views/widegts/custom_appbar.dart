import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';

import 'inter_text.dart';

// import 'package:vedvidhi/Colors/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> action;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final double? height;
  const CustomAppBar(
      {Key? key,
      this.bottom,
      this.action = const [],
      required this.title,
      this.height,
      this.automaticallyImplyLeading = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.textformfieldcol,
      actions: action,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColors.whitecol,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightblackcol.withOpacity(0.8)),
      title: InterText(
        text: title,
        fontsize: 22,
        fontweight: FontWeight.w600,
        color: AppColors.primarycol,
      ),
      // automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
