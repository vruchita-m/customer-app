import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';
import 'package:service_mitra/views/widegts/righteous_text.dart';

import '../../../utlis/sizes.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 300,
            width: width,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 85,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 290,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage(AppImages.comingSoonImage),
                                    fit: BoxFit.cover)),
                            width: width,
                            // borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  RightText(
                                    height: 0,
                                    text: "work in",
                                    color: AppColors.primarycol,
                                    fontsize: 50,
                                    fontweight: FontWeight.w400,
                                  ),
                                  RightText(
                                    height: 0,
                                    text: "progress",
                                    color: AppColors.orangeheadingcol,
                                    fontsize: 50,
                                    fontweight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.whitecol,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  height: 100,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.lightblackcol,
                            )),
                        spaceHorizontal(width * 0.23),
                        InterText(
                          text: "Coming Soon",
                          fontsize: 22,
                          fontweight: FontWeight.w600,
                          color: AppColors.primarycol,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
