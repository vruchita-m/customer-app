import 'package:flutter/material.dart';
import 'package:service_mitra/utlis/sizes.dart';

import '../../config/colors/colors.dart';

class CustomElevatedButton2 extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final Widget? child;
  final VoidCallback? onpressed;
  final Color? color;
  const CustomElevatedButton2(
      {Key? key, required this.text, this.child, this.onpressed, this.color})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 55,
    //   width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(100),
    //       color: AppColors.primarycol),
    //   child: Center(
    //     child: Text(
    // textAlign: TextAlign.center,
    // text,
    // style: TextStyle(
    //     fontSize: 20,
    //     fontFamily: 'inter',
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.whitecol),
    //     ),
    //   ),
    // );
    return SizedBox(
      // height: 55,
      // width: width*,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
          onPressed: onpressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500,
                  color: AppColors.whitecol),
            ),
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
