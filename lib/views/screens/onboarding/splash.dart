import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/poppins_text.dart';

import '../../../config/routes/routes_name.dart';
import '../../../config/share_preferences/preferences.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Timer(const Duration(seconds: 4), () {
//         final token = Preference.getString(PrefKeys.token);
//         print(token);
//         if (token.isNotEmpty) {
//           Navigator.pushReplacementNamed(context, RoutesName.loginmpin);
//         } else {
//           Navigator.pushReplacementNamed(context, RoutesName.login);
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           width: width,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(AppImages.splashImageP), fit: BoxFit.cover)),
//           child: Column(
//             children: [
//               spaceVertical(width * 0.12),
//               const PoppinsText(
//                 text: 'Introducing',
//                 color: AppColors.whitecol,
//                 fontsize: 32,
//                 fontweight: FontWeight.w400,
//               ),
//               const PoppinsText(
//                 textalign: TextAlign.center,
//                 text: '''With you to your
// Destination''',
//                 fontsize: 32,
//                 fontweight: FontWeight.w700,
//                 color: AppColors.orangeheadingcol,
//               ),
//               spaceVertical(width * 0.12),
//               Image.asset(AppImages.servicemitraLogoSplash)
//             ],
//           ),
//         ));
//   }
// }

// Start - New Splash Screen Code
class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _circleController;
  late Animation<double> _circleDropAnimation;
  late Animation<double> _circleExpandAnimation;
  late AnimationController _logoController;
  bool showLogo = false;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _circleDropAnimation = Tween<double>(begin: -200, end: height * 0.4).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    );

    _circleExpandAnimation = Tween<double>(begin: 100, end: width * 3).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    _circleController.forward().whenComplete(() {
      setState(() {
        showLogo = true;
      });
      _logoController.forward();
      Timer(const Duration(seconds: 2), () {
        final token = Preference.getString(PrefKeys.token);
        print(token);
        if (token.isNotEmpty) {
          Navigator.pushReplacementNamed(context, RoutesName.loginmpin);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.login);
        }
      });
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _circleController,
        builder: (context, child) {
          final top = _circleDropAnimation.value;
          final size = _circleController.status == AnimationStatus.completed
              ? _circleExpandAnimation.value
              : 100.0;

          return Stack(
            children: [
              //Background image
              Positioned.fill(
                child: Opacity(
                  opacity:0.5, // Set Opacity
                  child: Container(
                    // color: const Color(0xFFffffff) // Set Color
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.splashbg), // change img
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Animated Circle (Drop + Expand)
              Positioned(
                top: top,
                left: width / 2 - size / 2,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: AppColors.primarycol, // You can change this color
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0, 7),
                        colors: [AppColors.primarycol, AppColors.blue]),
                  ),
                  child: size < width * 0.5
                      ? Padding(
                    padding: const EdgeInsets.all(8.0), // You can reduce padding too
                    child: Transform.scale(
                      scale: 1, // <-- Increase to enlarge logo
                      child: Image.asset(
                        AppImages.servicemitraLogoSplash,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                      : null,
                ),
              ),

              // Full screen background image after circle expands
              if (_circleController.isCompleted)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: showLogo ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.splashImageP),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

              // Text + Logo Animation
              if (showLogo)
                Center(
                  child: FadeTransition(
                    opacity: _logoController,
                    child: ScaleTransition(
                      scale: _logoController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const PoppinsText(
                            text: 'Introducing',
                            color: AppColors.whitecol,
                            fontsize: 39,
                            fontweight: FontWeight.w400,
                          ),

                          const PoppinsText(
                            textalign: TextAlign.center,
                            text: '''With you to your\nDestination''',
                            fontsize: 39,
                            fontweight: FontWeight.w700,
                            color: AppColors.orangeheadingcol,
                          ),

                          spaceVertical(30),
                          Image.asset(AppImages.servicemitraLogoSplash,
                            height: 180,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          )  ;
        },
      ),
    );
  }
}

// End - New Splash Screen Code
