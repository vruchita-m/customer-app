import 'package:flutter/material.dart';
import 'package:service_mitra/utlis/sizes.dart';

import '../../config/colors/colors.dart';

class CustomElevatedButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final Widget? child;
  final double? height;
  final VoidCallback? onpressed;
  const CustomElevatedButton(
      {Key? key, required this.text, this.height, this.child, this.onpressed})
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
      height: height ?? 55,
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primarycol)),
          onPressed: onpressed,
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                color: AppColors.whitecol),
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
