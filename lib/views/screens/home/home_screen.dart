import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/token_checker.dart';

import '../../../bloc/homebloc/home_bloc.dart';
import '../../../bloc/homebloc/home_event.dart';

import '../../../bloc/homebloc/home_state.dart';
import '../../../bloc/notification_bloc/notification_count_cubit.dart';
import '../../widegts/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();

  //   log("Token in initstate: ${Preference.getString(PrefKeys.token)}");

  //   TokenChecker().checkMyToken();

  //   TokenChecker().startCron(context);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..add(LoadHomeBanners()),
        child: Scaffold(
          backgroundColor: AppColors.textformfieldcol,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            // Show a loading indicator
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is HomeLoaded) {
                            // Display the banners using CarouselSlider
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CarouselSlider.builder(
                                  itemCount: state.homeBannerList.length,
                                  options: CarouselOptions(
                                    height: 220,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval:
                                    const Duration(seconds: 4),
                                    onPageChanged: (index, reason) {
                                      // Optionally handle page changes
                                      context
                                          .read<HomeBloc>()
                                          .add(PageChangedEvent(index));
                                    },
                                  ),
                                  itemBuilder: (context, index, realIndex) {
                                    return SizedBox(
                                      width: width,
                                      // borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        state.homeBannerList[index]['image']!,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    state.homeBannerList.length,
                                        (index) => Container(
                                      width: 9,
                                      height: 9,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 15),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == state.currentIndex
                                            ? AppColors.orangeheadingcol
                                            : AppColors.whitecol,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (state is HomeError) {
                            // Show an error message
                            return Center(child: Text(state.message));
                          }

                          return const SizedBox(); // Empty widget as fallback
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.primarycol,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      height: 105,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.logoicon,
                              height: 50,
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.profile);
                                },
                                child: SvgPicture.asset(AppImages.anchoricon)),
                            spaceHorizontal(width * 0.08),
                            // GestureDetector(
                            //     onTap: () {
                            //       Navigator.pushNamed(
                            //           context, RoutesName.notification);
                            //     },
                            //     child: SvgPicture.asset(
                            //         AppImages.notifictionicon)),
                            // Notification Icon ke upar Badge lagane ke liye
                            BlocBuilder<NotificationCountCubit, int>(
                              builder: (context, count) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, RoutesName.notification);
                                    // Optional: Jab user click kare to count reset kar dein
                                    // context.read<NotificationCountCubit>().reset();
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      // Aapka original notification icon
                                      SvgPicture.asset(AppImages.notifictionicon),

                                      // Badge, jo sirf tab dikhega jab count > 0 ho
                                      if (count > 0)
                                        Positioned(
                                          top: -4,
                                          right: -6,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 18,
                                              minHeight: 18,
                                            ),
                                            child: Text(
                                              '$count',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: SizedBox(
                  height: 46,
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightblackcol.withOpacity(0.8)),
                      prefixIcon: SvgPicture.asset(
                        AppImages.searchicon,
                        fit: BoxFit.scaleDown,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.lightblackcol,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: AppColors.lightblackcol)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: AppColors.lightblackcol)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: AppColors.lightblackcol)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: AppColors.lightblackcol)),
                      fillColor: AppColors.whitecol,
                    ),
                  ),
                ),
              ),

              // Grid Menu
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                  children: [
                    CustomCard(
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.myvehicles);
                        },
                        title: 'My Vehicles',
                        imagePath: AppImages.myvehicles),
                    CustomCard(
                        ontap: () {
                          Navigator.pushNamed(
                              context, RoutesName.breakdownticketstatus);
                        },
                        title: 'Breakdown Support',
                        imagePath: AppImages.breakdown),
                    const CustomCard(
                        title: 'Workshop Locator',
                        imagePath: AppImages.workshop),
                    const CustomCard(
                        title: 'Parts Locator', imagePath: AppImages.partsicon),
                    const CustomCard(
                        title: 'AMC & Contract', imagePath: AppImages.amc),
                    const CustomCard(
                        title: 'Labour Charges',
                        imagePath: AppImages.labourcharges),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
