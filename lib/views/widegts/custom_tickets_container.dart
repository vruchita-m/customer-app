import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/utlis/sizes.dart';

import 'inter_text.dart';

class CustomTicketsCard extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final String text2;
  final String? complaintNo;
  final String vehicleNo;
  final String assignedTo;
  final String wmNo;
  final String? tracking;
  final Color color;
  final Color colorborder;
  final List<Widget>? children;

  // ✅ NAYE PARAMETERS ADD KIYE GAYE

  final String customerName;
  final String vehicleModel;
  final String vehicleMake;
  final String customerAddress;
  final String breakdownLocation;

  const CustomTicketsCard({
    Key? key,
    required this.text,
    required this.text2,
    this.complaintNo,
    required this.vehicleNo,
    required this.assignedTo,
    required this.wmNo,
    this.tracking,
    required this.color,
    required this.colorborder,
    this.children,
    // ✅ NAYE PARAMETERS CONSTRUCTOR ME ADD KIYE GAYE
    required this.customerName,
    required this.vehicleModel,
    required this.vehicleMake,
    required this.customerAddress,
    required this.breakdownLocation,
  }) : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: colorborder),
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whitecol),
      child: Column(
        children: [
          Container(
            height: 41,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InterText(
                      text: text,
                      fontsize: 18,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontweight: FontWeight.w600,
                      color: AppColors.whitecol,
                    ),
                  ),
                  InterText(
                    textalign: TextAlign.end,
                    text: text2,
                    textOverflow: TextOverflow.ellipsis,
                    fontsize: 12,
                    maxLines: 1,
                    fontweight: FontWeight.w500,
                    color: AppColors.whitecol,
                  ),
                ],
              ),
            ),
          ),

          // Padding(
          //   padding:
          //       const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       // InterText(
          //       //   text: 'Complaint No : ',
          //       //   fontsize: 14,
          //       //   fontweight: FontWeight.w400,
          //       //   color: AppColors.lightblackcol.withOpacity(0.80),
          //       // ),
          //       // InterText(
          //       //   text: complaintNo,
          //       //   fontsize: 14,
          //       //   fontweight: FontWeight.w600,
          //       //   color: AppColors.lightblackcol,
          //       // ),
          //     ],
          //   ),
          // ),

          // Start - Ticket No
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            SizedBox(
              width: 170, // fixed width for label column
               child: InterText(
                  text: 'Ticket No : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
            ),
                Expanded(
                  child: InterText(
                    text: complaintNo ?? "N/A",
                    fontsize: 13,
                    fontweight: FontWeight.w600,
                    color: AppColors.lightblackcol,
                    textalign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          // End - Ticket No

          // Start - Customer Name
          Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Row(
              children: [
              SizedBox(
              width: 170, // fixed width for label column
              child: InterText(
                  text: 'Customer Name : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
              ),
                Expanded(
                  child: InterText(
                    text: customerName,
                    fontsize: 13,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontweight: FontWeight.w600,
                    color: AppColors.lightblackcol,
                    textalign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          // End - Customer Name

          // Start - Vehicle No
          Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Row(
              children: [
              SizedBox(
              width: 170, // fixed width for label column
              child: InterText(
                  text: 'Vehicle No  : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
              ),
                InterText(
                  text: vehicleNo,
                  fontsize: 13,
                  fontweight: FontWeight.w600,
                  color: AppColors.lightblackcol,
                ),
              ],
            ),
          ),
          // End - Vehicle No

          // Start - Vehicle Make
          // Padding(
          //   padding:
          //   const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InterText(
          //         text: 'Vehicle Make : ',
          //         fontsize: 14,
          //         fontweight: FontWeight.w400,
          //         color: AppColors.lightblackcol.withOpacity(0.80),
          //       ),
          //       InterText(
          //         text: vehicleMake,
          //         fontsize: 13,
          //         fontweight: FontWeight.w600,
          //         color: AppColors.lightblackcol,
          //       ),
          //     ],
          //   ),
          // ),
          // End - Vehicle Make

          // Start - Vehicle Model
          // Padding(
          //   padding:
          //   const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InterText(
          //         text: 'Vehicle Model : ',
          //         fontsize: 14,
          //         fontweight: FontWeight.w400,
          //         color: AppColors.lightblackcol.withOpacity(0.80),
          //       ),
          //       InterText(
          //         text: vehicleModel,
          //         fontsize: 13,
          //         fontweight: FontWeight.w600,
          //         color: AppColors.lightblackcol,
          //       ),
          //     ],
          //   ),
          // ),
          // End - Vehicle Model

          // Start - Customer Address
          // Padding(
          //   padding:
          //   const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InterText(
          //         text: 'Customer Address : ',
          //         fontsize: 14,
          //         fontweight: FontWeight.w400,
          //         color: AppColors.lightblackcol.withOpacity(0.80),
          //       ),
          //       Expanded(
          //         child: InterText(
          //           text: customerAddress,
          //           fontsize: 13,
          //           fontweight: FontWeight.w600,
          //           color: AppColors.lightblackcol,
          //           textalign: TextAlign.right,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // End - Customer Address

          // Start - Assigned To
          Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Row(
              children: [
              SizedBox(
              width: 170, // fixed width for label column
              child: InterText(
                  text: 'Assigned To : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
              ),
                InterText(
                  text: assignedTo,
                  fontsize: 13,
                  fontweight: FontWeight.w600,
                  color: AppColors.lightblackcol,
                ),
              ],
            ),
          ),
          // End - Assigned To

          // Start - Mechanic number
          Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Row(
              children: [
              SizedBox(
              width: 170, // fixed width for label column
              child: InterText(
                  text: 'Workshop Number : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
              ),
                InterText(
                  text: wmNo,
                  fontsize: 13,
                  fontweight: FontWeight.w600,
                  color: AppColors.lightblackcol,
                ),
              ],
            ),
          ),
          // End - Mechanic number

          // Start - Breakdown Location
          Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(
              width: 170, // fixed width for label column
              child: InterText(
                  text: 'Breakdown Location : ',
                  fontsize: 14,
                  fontweight: FontWeight.w400,
                  color: AppColors.lightblackcol.withOpacity(0.80),
                ),
              ),
                Expanded(
                  child: InterText(
                    text: breakdownLocation,
                    fontsize: 13,
                    fontweight: FontWeight.w600,
                    color: AppColors.lightblackcol,
                    textalign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          // End - Breakdown Location

          Column(
            children: children ?? [],
          )
        ],
      ),
    );
  }


  // Padding(
          //   padding:
          //       const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 12),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       // InterText(
          //       //   text: 'Tracking  : ',
          //       //   fontsize: 14,
          //       //   fontweight: FontWeight.w400,
          //       //   color: AppColors.lightblackcol.withOpacity(0.80),
          //       // ),
          //       // InterText(
          //       //   text: tracking,
          //       //   fontsize: 14,
          //       //   fontweight: FontWeight.w600,
          //       //   color: AppColors.primarycol,
          //       // ),
          //     ],
          //   ),
          // ),
  @override
  Size get preferredSize => throw UnimplementedError();
}