import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final void Function()? onTap;
  const CustomListTile(
      {super.key, required this.leading, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20, right: 12),
            leading: leading,
            title: title,
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Divider(
          thickness: 0.2,
          color: AppColors.boxShadow.withOpacity(0.7),
        )
      ],
    );
  }
}
