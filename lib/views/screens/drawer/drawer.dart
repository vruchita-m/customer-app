import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/profile_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';
import 'package:service_mitra/views/widegts/token_checker.dart';

import '../../widegts/custom_listtile.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  String userName = "";

  void loadProfileData() {
    ProfileRepository().getProfile(context).then(
      (value) {
        debugPrint("value : $value");
        var res = jsonEncode(value);
        Map<String, dynamic> userData = json.decode(res);

        debugPrint("name : ${userData["name"]}");
        setState(() {
          userName = userData["name"] ?? "N/A";
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // backgroundColor: AppColors.primarycol,
        width: width * 0.88,
        child: Column(
          children: [
            Container(
              width: width,
              height: 200,
              color: AppColors.primarycol,
              child: Column(
                children: [
                  spaceVertical(width * 0.06),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _closeDrawer();
                            },
                            child: SvgPicture.asset(AppImages.closedrawericon))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: const BoxDecoration(
                        color: AppColors.whitecol, shape: BoxShape.circle),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 102,
                      width: 102,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.profileImage),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: AppColors.primarycol,
                          border: Border.all(
                              color: AppColors.primarycol, width: 3)),
                      // child: Image.asset(
                      //   AppImages.truck1image,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  InterText(
                    // text: 'Rahul Sharma',
                    text: userName,
                    fontsize: 20,
                    fontweight: FontWeight.w700,
                    color: AppColors.whitecol,
                  )
                ],
              ),
            ),
            spaceVertical(height * 0.02),
            SizedBox(
              height: height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                          // Navigator.pushNamed(context, RoutesName.ticketstatus);
                        },
                        leading: SvgPicture.asset(AppImages.breakdownticket),
                        title: const InterText(
                          text: 'Breakdown ticket status',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                          Navigator.pushNamed(context, RoutesName.myvehicles);
                        },
                        leading: SvgPicture.asset(AppImages.myvehicle),
                        title: const InterText(
                          text: 'My Vehicle',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                          Navigator.pushNamed(context, RoutesName.profile);
                        },
                        leading: SvgPicture.asset(AppImages.myprofile),
                        title: const InterText(
                          text: 'My profile',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                        },
                        leading: SvgPicture.asset(AppImages.usermgmt),
                        title: Row(
                          children: [
                            const InterText(
                              text: 'User management',
                              fontsize: 16,
                              fontweight: FontWeight.w500,
                              color: AppColors.drawertextcol,
                            ),
                            spaceHorizontal(width * 0.02),
                            Image.asset(
                              AppImages.passwordicon1,
                              fit: BoxFit.scaleDown,
                            )
                          ],
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                        },
                        leading: SvgPicture.asset(AppImages.getupdate),
                        title: Row(
                          children: [
                            const InterText(
                              text: 'Get update',
                              fontsize: 16,
                              fontweight: FontWeight.w500,
                              color: AppColors.drawertextcol,
                            ),
                            spaceHorizontal(width * 0.02),
                            Image.asset(AppImages.passwordicon1)
                          ],
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                        },
                        leading: SvgPicture.asset(AppImages.networklocator),
                        title: Row(
                          children: [
                            const InterText(
                              text: 'Network Locator',
                              fontsize: 16,
                              fontweight: FontWeight.w500,
                              color: AppColors.drawertextcol,
                            ),
                            spaceHorizontal(width * 0.02),
                            Image.asset(AppImages.passwordicon1)
                          ],
                        )),
                    CustomListTile(
                        onTap: () {
                          _closeDrawer();
                        },
                        leading: SvgPicture.asset(AppImages.workshopnearby),
                        title: Row(
                          children: [
                            const InterText(
                              text: 'Workshop near by',
                              fontsize: 16,
                              fontweight: FontWeight.w500,
                              color: AppColors.drawertextcol,
                            ),
                            spaceHorizontal(width * 0.02),
                            Image.asset(AppImages.passwordicon1)
                          ],
                        )),
                    CustomListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, RoutesName.webviewScrren,
                              arguments: {
                                "title": "Privacy Policy",
                                "url":
                                    "https://trukmitra.com/privacy-policy.php"
                                // "https://codespace.co.in/designer/html/truk-mitra/privacy-policy-mobile.php"
                              });
                        },
                        leading: SvgPicture.asset(AppImages.privacypolicy),
                        title: const InterText(
                          text: 'Privacy Policy',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                    CustomListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, RoutesName.webviewScrren,
                              arguments: {
                                "title": "Terms & Conditions",
                                "url":
                                    "https://trukmitra.com/term-and-condition.php"
                                // "https://codespace.co.in/designer/html/truk-mitra/term-and-condition-mobile.php"
                              });
                        },
                        leading: SvgPicture.asset(AppImages.termsandcond),
                        title: const InterText(
                          text: 'Terms & Conditions',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                    CustomListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, RoutesName.webviewScrren,
                              arguments: {
                                "title": "About Us",
                                "url": "https://trukmitra.com/about-us.php"
                                // "https://codespace.co.in/designer/html/truk-mitra/about-us-mobile.php"
                              });
                        },
                        leading: SvgPicture.asset(AppImages.support),
                        title: const InterText(
                          text: 'About Us',
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: AppColors.drawertextcol,
                        )),
                  ],
                ),
              ),
            ),
            spaceVertical(width * 0.07),
            SizedBox(
              height: 40,
              width: 164,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primarycol)),
                  onPressed: () async {
                    await Preference.clear();
                    // Navigate to login screen
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.login,
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.logouticon),
                      spaceHorizontal(width * 0.02),
                      const InterText(
                        text: "Logout",
                        fontsize: 14,
                        fontweight: FontWeight.w500,
                        color: AppColors.whitecol,
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
