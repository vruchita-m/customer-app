import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:service_mitra/bloc/cubit/feddback_cubit/feedback_state.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_cubit.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/ticket/ticket_model.dart';
import 'package:service_mitra/config/data/repository/ticket/ticket_respository.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_tickets_container.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../../../bloc/cubit/feddback_cubit/feedback_cubit.dart';
import '../../../../config/data/repository/feedback/feedback_repository.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../utlis/sizes.dart';
import '../../../widegts/custom_elevated_button.dart';

class OpenTickets extends StatefulWidget {
  // UPDATED: The widget now accepts a list of tickets from its parent.
  final List<TicketsResults> tickets;
  const OpenTickets({super.key, required this.tickets});

  @override
  State<OpenTickets> createState() => _OpenTicketsState();
}

class _OpenTicketsState extends State<OpenTickets> {
  @override
  Widget build(BuildContext context) {
    // UPDATED: The BlocProvider has been removed from this file.
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      body: RefreshIndicator(
        onRefresh: () async {
          // UPDATED: The refresh action now calls the cubit from the parent screen.
          context.read<TicketsCubit>().fetchAndCategorizeAllTickets(context);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              spaceVertical(height * 0.02),
              // UPDATED: The BlocBuilder is replaced with a direct check of the list.
              if (widget.tickets.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: InterText(
                      text: "No Open Tickets Found",
                      fontsize: 16,
                      color: AppColors.colblack,
                    ),
                  ),
                )
              else
                ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.tickets.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // Data now comes from `widget.tickets`
                      final ticket = widget.tickets[index];
                      final customerAddress =
                      "${ticket.customer?.address ?? ''}, ${ticket.customer?.city ?? ''}, ${ticket.customer?.state ?? ''}"
                          .trim()
                          .replaceAll(RegExp(r'^, |,$'), '');

                      // YOUR ORIGINAL UI AND FUNCTIONALITY REMAINS UNCHANGED
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.estimate,
                            arguments: {
                              'ticketsResults': ticket,
                            },
                          );
                        },
                        child: CustomTicketsCard(
                          text: ticket.status ?? "N/A",
                          text2: changeTimeFormat(ticket.createdAt ?? "") ?? "N/A",
                          complaintNo: ticket.complaintNo ?? "N/A",
                          vehicleNo: ticket.vehicle?.vehicleNumber ?? "N/A",
                          assignedTo: ticket.mechanic?.name ?? "N/A",
                          wmNo: ticket.mechanic?.mobileNumber ?? "N/A",
                          customerName: ticket.customer?.name ?? "N/A",
                          vehicleModel: ticket.vehicle?.model ?? "N/A",
                          vehicleMake: ticket.vehicle?.make ?? "N/A",
                          breakdownLocation: ticket.location ?? "N/A",
                          customerAddress:
                          customerAddress.isEmpty ? "N/A" : customerAddress,
                          color: AppColors.colred,
                          colorborder: AppColors.colred,
                        ),
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
  // showFeedbackDialog(context, ticket.id ?? "");
  String changeTimeFormat(String orignalTime) {
    DateTime dateTime = DateTime.parse(orignalTime);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm a")
        .format(dateTime.toUtc().add(const Duration(hours: 5, minutes: 30)));
    return formattedDate;
  }
}

void showFeedbackDialog(BuildContext context, String ticketId) {
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => FeedbackCubit(FeedbackRepository()),
        child: FeedbackDialogContent(ticketId: ticketId),
      );
    },
  );
}

class FeedbackDialogContent extends StatefulWidget {
  final String ticketId;

  const FeedbackDialogContent({super.key, required this.ticketId});

  @override
  State<FeedbackDialogContent> createState() => _FeedbackDialogContentState();
}

class _FeedbackDialogContentState extends State<FeedbackDialogContent> {
  double _rating = 5.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.textformfieldcol,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(5),
      content: Stack(
        alignment: Alignment.topRight,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 5, top: 5),
          //   child: InkWell(
          //     onTap: () {
          //       log("message");
          //       Navigator.pop(context, true);
          //     },
          //     child: const Icon(Icons.close, size: 24, color: Colors.black),
          //   ),
          // ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InterText(
                        text: "Feedback & Review",
                        fontsize: 20,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 5),
                      child: InkWell(
                        onTap: () {
                          log("message");
                          Navigator.pop(context, true);
                        },
                        child: const Icon(Icons.close,
                            size: 24, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.whitecol,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InterText(
                        text: "Rate your service",
                        fontsize: 18,
                        fontweight: FontWeight.w600,
                      ),
                      const SizedBox(height: 10),
                      RatingBar(
                        initialRating: 5,
                        allowHalfRating: true,
                        minRating: 1,
                        maxRating: 5,
                        itemSize: 35,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: AppColors.colyellow),
                          half: const Icon(Icons.star_half,
                              color: AppColors.colyellow),
                          empty: const Icon(Icons.star_outline,
                              color: AppColors.colyellow),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      InterText(
                        text: "Review",
                        fontsize: 16,
                        fontweight: FontWeight.w500,
                        color: AppColors.lightblackcol.withOpacity(0.8),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _reviewController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: "Write your review...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightblackcol.withOpacity(0.8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<FeedbackCubit, FeedbackState>(
                        listener: (context, state) {
                          if (state is FeedbackSuccess) {
                            Navigator.pop(context); // Close dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Feedback submitted successfully")),
                            );
                            Navigator.pushNamed(
                              context,
                              RoutesName.breakdownticketstatus,
                            );
                          } else if (state is FeedbackError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: state is FeedbackLoading
                                ? "Submitting..."
                                : "Submit",
                            onpressed: state is FeedbackLoading
                                ? null
                                : () {
                                    context
                                        .read<FeedbackCubit>()
                                        .submitFeedback(
                                            _rating,
                                            _reviewController.text,
                                            widget.ticketId,
                                            context);
                                  },
                          );
                        },
                      ),
                    ],
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
