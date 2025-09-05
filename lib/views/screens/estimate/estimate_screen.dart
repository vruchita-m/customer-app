import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/estimate/dismantle_model.dart';
import 'package:service_mitra/config/data/model/estimate/estimate_model.dart';
import 'package:service_mitra/config/data/model/estimate/investigation_modal.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button2.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';
import 'package:shimmer/shimmer.dart';
import '../../../bloc/estimate/estimate_bloc.dart';
import '../../../bloc/estimate/estimate_event.dart';
import '../../../bloc/estimate/estimate_state.dart';
import '../../../config/components/loading_widget.dart';
import '../../../config/data/model/ticket/ticket_model.dart';
import '../../../config/routes/routes_name.dart';
import '../full_image_view_screen.dart';

class EstimateScreen extends StatefulWidget {
  final TicketsResults ticketsResults;
  const EstimateScreen({super.key, required this.ticketsResults});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  List<Part> selectedParts = [];
  List<DismantleResults> dismantleData = [];
  List<InvestigatioResults> inverstigationResult = [];

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';

    try {
      DateTime dateTime = DateTime.parse(dateString);
      String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
      return formattedDate;
    } catch (e) {
      return 'N/A';
    }
  }

  // @override
  // void dispose() {
  //   debugPrint("Resetting EstimateBloc state...");

  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    debugPrint("id received : ${widget.ticketsResults.id!}");
    debugPrint("Vehicle Problem Data: ${widget.ticketsResults.vehicleProblem}");

    context.read<EstimateBloc>().add(FetchEstimatesEvent(
          context: context,
          tickedId: widget.ticketsResults.id ?? "",
        ));
    context.read<EstimateBloc>().add(FetchDismantleData(
          context: context,
          tickedId: widget.ticketsResults.id ?? "",
        ));
    context.read<EstimateBloc>().add(FetchInvestigationData(
          context: context,
          tickedId: widget.ticketsResults.id ?? "",
        ));
  }

  double calculateTotalPrice() {
    return selectedParts.fold(
        0.0, (sum, part) => sum + (part.totalprice ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ticketId : ${widget.ticketsResults.id!}");
    return PopScope(
      // onPopInvokedWithResult: (didPop, result) {
      //   context.read<EstimateBloc>().add(ResetState());
      // },

      onPopInvoked: (didPop) {
        context.read<EstimateBloc>().add(ResetState());
      },
      child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        appBar: const CustomAppBar(title: "Ticket Details"),
        body: BlocListener<EstimateBloc, EstimateState>(
          listener: (context, state) {
            if (state.statusUpdate) {
              // Timer(
              //   const Duration(milliseconds: 300),
              //   () {
              //     context
              //         .read<EstimateBloc>()
              //         .add(setTicketStatus(context: context, ticketStatus: ""));
              //     Navigator.pop(context);
              //     Navigator.pushReplacementNamed(context, RoutesName.breakdownticketstatus);
              //   },
              // );
              context
                  .read<EstimateBloc>()
                  .add(setTicketStatus(context: context, ticketStatus: ""));
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, RoutesName.breakdownticketstatus);
            } else if (state.statusLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: LoadingWidget()),
              );
            } else if (state.statusFailed) {
              debugPrint("Check estimation failed");
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Try again later ..."),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state.dismantleResults.isNotEmpty) {
              dismantleData = state.dismantleResults;
            }
            if (state.selectedParts.isNotEmpty) {
              selectedParts = state.selectedParts;
            }
            if (state.inverstigationResult.isNotEmpty) {
              inverstigationResult = state.inverstigationResult;
            }
          },
          child: BlocBuilder<EstimateBloc, EstimateState>(
              builder: (context, state) {
                final customerAddress =
                "${widget.ticketsResults.customer?.address ?? ''}, ${widget.ticketsResults.customer?.city ?? ''}, ${widget.ticketsResults.customer?.state ?? ''}"
                    .trim()
                    .replaceAll(RegExp(r'^, |,$'), '');
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: AppColors.whitecol,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          // Start - Ticket No
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                width: 170, // fixed width for label column
                                child: InterText(
                                    text: 'Ticket No :',
                                    fontsize: 14,
                                    fontweight: FontWeight.w400,
                                    color:
                                    AppColors.lightblackcol.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  // width:
                                  // MediaQuery.of(context).size.width * 0.55,
                                  child: InterText(
                                    text: widget.ticketsResults.complaintNo ??
                                        "N/A",
                                    fontsize: 13,
                                    textalign: TextAlign.start,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontweight: FontWeight.w600,
                                    color: AppColors.lightblackcol,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // End - Ticket No

                          // Start - Date
                          Padding(
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 15, horizontal: 20),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Date :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                // InterText(
                                //   text: formatDate(widget
                                //       .ticketsResults.createdAt
                                //       ?.toString()),
                                InterText(
                                  text: formatDate(
                                      widget.ticketsResults.createdAt),
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Date

                          // Start - Customer Name
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Customer Name :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text:
                                  widget.ticketsResults.customer?.name ??
                                      "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Customer Name

                          // Start - Vehicle No
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Vehicle No  :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                      AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                // InterText(
                                //   text: widget
                                //       .ticketsResults.vehicle!.vehicleNumber,
                                InterText(
                                  text: widget.ticketsResults.vehicle
                                      ?.vehicleNumber ??
                                      "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Vehicle No

                          // Start - Vehicle Make
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Vehicle Make :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text: widget.ticketsResults.vehicle?.make ??
                                      "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Vehicle Make

                          // Start - Vehicle Model
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Vehicle Model :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text: widget.ticketsResults.vehicle?.model ??
                                      "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Vehicle Model

                          // Start - Caller Name
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Caller Name :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text: widget.ticketsResults.callerName ?? "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Caller Name

                          // Start - Caller Number
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Caller Number :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text: widget.ticketsResults.driverNo ?? "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Caller Number

                          // Start - Customer Voice
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: 170, // fixed width for label column
                              child: InterText(
                                  text: 'Customer Voice :',
                                  fontsize: 14,
                                  fontweight: FontWeight.w400,
                                  color:
                                  AppColors.lightblackcol.withOpacity(0.8),
                                ),
                              ),
                                InterText(
                                  text: widget.ticketsResults.vehicleProblem ?? "N/A",
                                  fontsize: 13,
                                  fontweight: FontWeight.w600,
                                  color: AppColors.lightblackcol,
                                )
                              ],
                            ),
                          ),
                          // End - Customer Voice

                          // Start - Breakdown Location
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            child: Align( // ✅ force left alignment
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // ✅ align children left
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // First line - label
                                  InterText(
                                    text: 'Breakdown Location :',
                                    fontsize: 14,
                                    textalign: TextAlign.start,
                                    fontweight: FontWeight.w400,
                                    color: AppColors.lightblackcol.withOpacity(0.8),
                                  ),

                                  const SizedBox(height: 5),

                                  // Second line - value
                                  InterText(
                                    text: widget.ticketsResults.location ?? "N/A",
                                    fontsize: 13,
                                    textalign: TextAlign.start,
                                    fontweight: FontWeight.w600,
                                    color: AppColors.lightblackcol,
                                  ),

                                  const SizedBox(height: 5),

                                  // Third line - extra info
                                  InterText(
                                    text: (customerAddress.isEmpty ? "N/A" : customerAddress).toUpperCase(),
                                    fontsize: 13,
                                    textalign: TextAlign.start,
                                    fontweight: FontWeight.w600,
                                    color: AppColors.lightblackcol
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // End - Breakdown Location

                  // Start - Ticket Status Button Section
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pushNamedAndRemoveUntil(context, RoutesName.timeline, (route) => false,);
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: AppColors.primarycol,
                  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //       ),
                  //       child: const Text(
                  //         'Ticket Status',
                  //         style: TextStyle(color: Colors.white, fontSize: 14),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Timeline Page
                          Navigator.pushNamed(
                            context,
                            RoutesName.timeline, //  Replace with your actual route
                            arguments: {
                              "ticketId": widget.ticketsResults.complaintNo, //  Pass the ticket ID
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarycol, // Dark background
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Center( // Centers content horizontally & vertically
                          child: FittedBox(
                          fit: BoxFit.scaleDown,  // makes text shrink if needed
                              child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Last Stage Circle
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green, // Completed stage
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                // Text(
                                //   widget.ticketsResults.lastStage ?? "Inspection",
                                //   style: const TextStyle(color: Colors.white, fontSize: 13),
                                // ),
                                Flexible(
                                  child: const Text(
                                    "Ticket Generate",
                                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold,),
                                    softWrap: true, // Allows line break
                                    overflow: TextOverflow.visible, // Prevents clipping
                                    textAlign: TextAlign.center,

                                  ),
                                ),

                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                                const SizedBox(width: 8),

                                // Running Stage Circle
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.orange, // Running stage
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                // Text(
                                //   widget.ticketsResults.runningStage ?? "Repairing",
                                //   style: const TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                const Text(
                                  "Attend Process",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),



                  // End - Ticket Status Button Section
                          // Start - Track
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //     left: 20,
                          //     right: 20,
                          //     bottom: 15,
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           InterText(
                          //             text: 'Track :',
                          //             fontsize: 14,
                          //             fontweight: FontWeight.w400,
                          //             color:
                          //             AppColors.lightblackcol.withOpacity(0.8),
                          //           ),
                          //           const SizedBox(width: 5),
                          //           SizedBox(
                          //             height: 15,
                          //             width: 15,
                          //             child: SvgPicture.asset(
                          //               AppImages.direction,
                          //               fit: BoxFit.scaleDown,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       InterText(
                          //         textalign: TextAlign.end,
                          //         text: widget.track,
                          //         fontsize: 13,
                          //         maxLines: 1,
                          //         fontweight: FontWeight.w400,
                          //         color: AppColors.lightblackcol,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // End - Track

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              height: 0,
                              color: AppColors.lightblackcol.withOpacity(0.3),
                            ),
                          ),
                          state.isLoading
                              ? _buildShimmerEffect()
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: selectedParts.length,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final part = selectedParts[index];

                                    debugPrint(
                                        "Depitation Check : ${part.name}");

                                    debugPrint(
                                        "Depitation Check : ${part.price}");

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            child: InterText(
                                              text: part.name ?? "",
                                              fontsize: 14,
                                              fontweight: FontWeight.w400,
                                              color: AppColors.lightblackcol
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          InterText(
                                            text:
                                                '₹${part.totalprice ?? part.price ?? 0.0}',
                                            fontsize: 14,
                                            fontweight: FontWeight.w500,
                                            color: part.name == "Deputation Fee"
                                                ? AppColors.colred
                                                : AppColors.lightblackcol,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                          if (selectedParts.isNotEmpty)
                            state.isLoading
                                ? _buildShimmerTotal()
                                : Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                            color: AppColors.containerbgcol
                                                .withOpacity(0.3)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InterText(
                                                    text: "Total(excl. GST)",
                                                    fontsize: 14,
                                                    fontweight: FontWeight.w600,
                                                    color: AppColors
                                                        .lightblackcol
                                                        .withOpacity(0.8),
                                                  ),
                                                  InterText(
                                                    text:
                                                        '₹${calculateTotalPrice().toStringAsFixed(2)}',
                                                    fontsize: 14,
                                                    fontweight: FontWeight.w600,
                                                    color:
                                                        AppColors.lightblackcol,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InterText(
                                                  text: "GST",
                                                  fontsize: 14,
                                                  fontweight: FontWeight.w600,
                                                  color: AppColors.lightblackcol
                                                      .withOpacity(0.8),
                                                ),
                                                InterText(
                                                  text:
                                                      "₹${(calculateTotalPrice() * 0.18).toStringAsFixed(2)}",
                                                  fontsize: 14,
                                                  fontweight: FontWeight.w600,
                                                  color:
                                                      AppColors.lightblackcol,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 0,
                                        color: AppColors.lightblackcol
                                            .withOpacity(0.3),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            InterText(
                                              text: "Total(incl. GST)",
                                              fontsize: 16,
                                              fontweight: FontWeight.w600,
                                              color: AppColors.lightblackcol
                                                  .withOpacity(0.8),
                                            ),
                                            InterText(
                                              text:
                                              "₹${(calculateTotalPrice() * 1.18).toStringAsFixed(2)}",
                                              fontsize: 16,
                                              fontweight: FontWeight.w600,
                                              color: AppColors.lightblackcol,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                            ),
                          Divider(
                            height: 0,
                            color: AppColors.lightblackcol.withOpacity(0.3),
                          ),
                          if (widget.ticketsResults.status ==
                              "Estimate Accepted")
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InterText(
                                    text: widget.ticketsResults.status,
                                    fontsize: 14,
                                    textalign: TextAlign.center,
                                    fontweight: FontWeight.w600,
                                    color: AppColors.colGreen,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: AppColors.colGreen.withOpacity(0.3),
                                  )
                                ],
                              ),
                            )
                          else if (widget.ticketsResults.status ==
                              "Estimate Rejected")
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InterText(
                                    text: widget.ticketsResults.status,
                                    fontsize: 14,
                                    textalign: TextAlign.center,
                                    fontweight: FontWeight.w600,
                                    color: AppColors.colred,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: AppColors.colred.withOpacity(0.3),
                                  )
                                ],
                              ),
                            )
                          else if (widget.ticketsResults.status ==
                                "Estimate Created" ||
                                widget.ticketsResults.status ==
                                    "Estimate Updated")
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 35, bottom: 40),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomElevatedButton2(
                                      text: 'Reject',
                                      onpressed: () {
                                        showRejectDialog(
                                            context,
                                            widget.ticketsResults.id!,
                                            "Estimate Rejected");
                                      },
                                      color: AppColors.colred,
                                    ),
                                    CustomElevatedButton2(
                                      text: 'Accept',
                                      onpressed: () {
                                        context.read<EstimateBloc>().add(
                                            UpdateStatus(
                                                context: context,
                                                tickedId:
                                                widget.ticketsResults.id!,
                                                ticketStatus:
                                                'Estimate Accepted',
                                                cancelationReason: ""));
                                      },
                                      color: AppColors.colGreen,
                                    )
                                  ],
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InterText(
                                      text: widget.ticketsResults.status,
                                      fontsize: 14,
                                      textalign: TextAlign.center,
                                      fontweight: FontWeight.w600,
                                      color: AppColors.colblack,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.pending,
                                      color: AppColors.colblack.withOpacity(0.3),
                                    )
                                  ],
                                ),
                              )
                        ],
                      ),
                    ),
                    if (inverstigationResult.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        margin: const EdgeInsets.only(bottom: 40),
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.whitecol,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: InterText(
                                text: "Vehicle Investigation",
                                fontsize: 20,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FullImageViewScreen(
                                          imageUrl: inverstigationResult[0]
                                              .chassisNoImage ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colblack
                                              .withOpacity(0.1)),
                                      color: AppColors.containerbgcol
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "${inverstigationResult[0].chassisNoImage ?? ""}?resize=low",
                                      placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FullImageViewScreen(
                                          imageUrl: inverstigationResult[0]
                                              .vehicleFrontImage ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colblack
                                              .withOpacity(0.1)),
                                      color: AppColors.containerbgcol
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "${inverstigationResult[0].vehicleFrontImage ?? ""}?resize=low",
                                      placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FullImageViewScreen(
                                          imageUrl: inverstigationResult[0]
                                              .kilometerImage ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colblack
                                              .withOpacity(0.1)),
                                      color: AppColors.containerbgcol
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "${inverstigationResult[0].kilometerImage ?? ""}?resize=low",
                                      placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    if (dismantleData.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        margin: const EdgeInsets.only(bottom: 40),
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.whitecol,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: InterText(
                                text: "Aggregate Dismantle",
                                fontsize: 20,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dismantleData.length,
                                itemBuilder: (context, index) {
                                  DismantleResults data = dismantleData[index];
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: List.generate(
                                      (data.dismantleParts ?? []).length,
                                          (i) {
                                        final dismantlePart =
                                        data.dismantleParts?[i];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    child: Container(
                                                      color:
                                                      AppColors.primarycol,
                                                      width: 45,
                                                      height: 45,
                                                      child: (data.category
                                                          ?.image ??
                                                          "")
                                                          .isNotEmpty
                                                          ? Image.network(data
                                                          .category!
                                                          .image)
                                                          : Image.asset(AppImages
                                                          .servicemitraLogoSplash),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        145,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        InterText(
                                                          text: data.category
                                                              ?.name ??
                                                              "N/A",
                                                          fontsize: 14,
                                                          fontweight:
                                                          FontWeight.w600,
                                                          color:
                                                          AppColors.colblack,
                                                        ),
                                                        InterText(
                                                          text: dismantlePart
                                                              ?.part
                                                              ?.name ??
                                                              "N/A",
                                                          fontsize: 14,
                                                          textOverflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          fontweight:
                                                          FontWeight.w500,
                                                          color:
                                                          AppColors.colblack,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              if ((dismantlePart
                                                  ?.selectedImages ??
                                                  [])
                                                  .isNotEmpty) ...[
                                                const InterText(
                                                  text: "Parts Pics",
                                                  fontsize: 12,
                                                  fontweight: FontWeight.w600,
                                                  color: AppColors.colblack,
                                                ),
                                                const SizedBox(height: 10),
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  itemCount: dismantlePart!
                                                      .selectedImages!.length,
                                                  gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 1.0,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                  ),
                                                  itemBuilder: (context, ii) {
                                                    final imageUrl =
                                                    dismantlePart
                                                        .selectedImages![ii];
                                                    return GestureDetector(
                                                      onTap: () => showDialog(
                                                        context: context,
                                                        builder: (_) => Dialog(
                                                          backgroundColor:
                                                          Colors.black,
                                                          insetPadding:
                                                          const EdgeInsets
                                                              .all(10),
                                                          child: Stack(
                                                            children: [
                                                              InteractiveViewer(
                                                                child: Center(
                                                                    child: Image
                                                                        .network(
                                                                        imageUrl)),
                                                              ),
                                                              Positioned(
                                                                top: 20,
                                                                right: 20,
                                                                child:
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                      30),
                                                                  onPressed:
                                                                      () =>
                                                                      Navigator.pop(context),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        child: Image.network(
                                                          imageUrl,
                                                          fit: BoxFit.cover,
                                                          height: 55,
                                                          width: 55,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                              const InterText(
                                                text: "Root cause of failure",
                                                fontsize: 12,
                                                fontweight: FontWeight.w600,
                                                color: AppColors.colblack,
                                              ),
                                              const SizedBox(height: 5),
                                              InterText(
                                                text: dismantlePart
                                                    ?.reasonforfailure ??
                                                    "N/A",
                                                fontsize: 12,
                                                fontweight: FontWeight.w300,
                                                color: AppColors.colblack,
                                              ),
                                              const SizedBox(height: 5),
                                              const Divider(
                                                color: AppColors.colblack,
                                                height: 0.5,
                                                thickness: 0.5,
                                              ),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
              }),
        ),
      ),
    );
  }

  void showRejectDialog(BuildContext context, String ticketId, String status) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Reject Estimate',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please enter a reason for rejecting the estimate.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: 'Enter reason',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        height: 40,
                        onpressed: () => Navigator.pop(context),
                        text: "Cancel",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: CustomElevatedButton(
                          text: "Reject",
                          height: 40,
                          onpressed: () {
                            if (reasonController.text.trim().isNotEmpty) {
                              Navigator.pop(context);
                              context.read<EstimateBloc>().add(UpdateStatus(
                                context: context,
                                tickedId: ticketId,
                                ticketStatus: status,
                                cancelationReason: reasonController.text.trim(),
                              ));
                            }
                          },
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.only(bottom: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildShimmerTotal() {
  return ListView.builder(
    itemCount: 3,
    shrinkWrap: true,
    padding: const EdgeInsets.only(bottom: 10),
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}