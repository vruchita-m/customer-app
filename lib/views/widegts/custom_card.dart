import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_mitra/config/colors/colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final void Function()? ontap;
  final String imagePath;

  const CustomCard({required this.title, required this.imagePath, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(12),
        // height: 132,
        // width: 110,
        decoration: BoxDecoration(
          // color: Colors.blue.shade50,box
          boxShadow: [
            BoxShadow(
                blurRadius: 9,
                offset: Offset(0, 1),
                color: AppColors.boxShadow.withOpacity(0.1))
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0, 7),
              colors: [AppColors.whitecol, AppColors.darkprimary]),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 45,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
