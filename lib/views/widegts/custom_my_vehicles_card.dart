import 'package:flutter/material.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_button.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button2.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../config/colors/colors.dart';

class CustomMyVehiclesContainer extends StatelessWidget
    implements PreferredSizeWidget {
  final String make;
  final String vehiclename;
  final String vehicleno;
  final String rc;
  final String image;
  final String fuelType;
  final Function onClickTicket, onViewTicket;
  const CustomMyVehiclesContainer(
      {Key? key,
      required this.image,
      required this.make,
      required this.vehiclename,
      required this.vehicleno,
      required this.rc,
      required this.fuelType,
      required this.onClickTicket,
      required this.onViewTicket})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22), color: AppColors.whitecol),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    color: AppColors.containerbgcol.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: image.isEmpty
                      ? Image.asset(AppImages.truckImageP)
                      : Image.network(image),
                ),
                spaceHorizontal(width * 0.025),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.5),
                      child: Row(
                        children: [
                          InterText(
                            text: 'Vehicle No.: ',
                            fontsize: 13,
                            fontweight: FontWeight.w400,
                            color: AppColors.lightblackcol.withOpacity(0.9),
                          ),
                          InterText(
                            text: vehicleno,
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                            color: AppColors.lightblackcol,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.5),
                      child: Row(
                        children: [
                          InterText(
                            text: 'Vehicle Modal: ',
                            fontsize: 13,
                            fontweight: FontWeight.w400,
                            color: AppColors.lightblackcol.withOpacity(0.9),
                          ),
                          InterText(
                            text: vehiclename,
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                            color: AppColors.lightblackcol,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.5),
                      child: Row(
                        children: [
                          InterText(
                            text: 'Make: ',
                            fontsize: 13,
                            fontweight: FontWeight.w400,
                            color: AppColors.lightblackcol.withOpacity(0.9),
                          ),
                          InterText(
                            text: make,
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                            color: AppColors.lightblackcol,
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width - 200,
                    //   child: InterText(
                    //         text: 'RC: $rc',
                    //         fontsize: 13,
                    //         fontweight: FontWeight.w400,
                    //         color: AppColors.lightblackcol.withOpacity(0.9),
                    //       ),
                    // ),
                    Row(
                      children: [
                        InterText(
                          text: 'Fuel Type : ',
                          fontsize: 13,
                          fontweight: FontWeight.w400,
                          color: AppColors.lightblackcol.withOpacity(0.9),
                        ),
                        InterText(
                          text: fuelType,
                          fontsize: 13,
                          fontweight: FontWeight.w500,
                          color: AppColors.lightblackcol,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            spaceVertical(10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onViewTicket();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: AppColors.primarycol, width: 1)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: const Center(
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            color: AppColors.primarycol,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                spaceHorizontal(20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onClickTicket();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: AppColors.primarycol, width: 1)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: const Center(
                        child: Text(
                          "View Tickets",
                          style: TextStyle(
                            color: AppColors.primarycol,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
