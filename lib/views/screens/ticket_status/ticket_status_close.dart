import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_cubit.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/ticket/ticket_respository.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../../../utlis/sizes.dart';
import '../../../../utlis/space.dart';
import '../../widegts/custom_tickets_container.dart';

class TicketStatusClose extends StatefulWidget {
  final String vehicleId;
  const TicketStatusClose({super.key, required this.vehicleId});

  @override
  State<TicketStatusClose> createState() => _TicketStatusCloseState();
}

class _TicketStatusCloseState extends State<TicketStatusClose> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsCubit(TicketRespository())
        ..getClosedTicketsByTicketId(context, widget.vehicleId),
      child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        body: RefreshIndicator(
          onRefresh: () async {
            // TicketsCubit(TicketRespository())
            context
                .read<TicketsCubit>()
                .getClosedTicketsByTicketId(context, widget.vehicleId);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceVertical(height * 0.02),
                BlocBuilder<TicketsCubit, TicketsState>(
                  builder: (context, state) {
                    if (state is TicketsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TicketsLoaded) {
                      if (state.tickets.isEmpty) {
                        return const Center(
                          child: InterText(
                            text: "No Tickets Found",
                            fontsize: 16,
                            color: AppColors.colblack,
                          ),
                        );
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          physics: const ScrollPhysics(),
                          itemCount: state.tickets.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final ticket = state.tickets[index];
                            // ✅ Customer ke address ko format kiya gaya
                            final customerAddress =
                            "${ticket.customer?.address ?? ''}, ${ticket.customer?.city ?? ''}, ${ticket.customer?.state ?? ''}"
                                .trim()
                                .replaceAll(RegExp(r'^, |,$'), '');
                            return GestureDetector(
                              onTap: () {
                                if (ticket.status != "Ticket Closed"
                                    // Billing Created
                                    ) {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.feedbackandreview,
                                    arguments: {
                                      'ticketId': ticket.id,
                                    },
                                  );
                                }
                              },
                              child: CustomTicketsCard(
                                text: ticket.status ?? "N/A",
                                text2:
                                    changeTimeFormat(ticket.createdAt ?? "") ??
                                        "N/A", // "2023-12-21 - 13:18:59",
                                complaintNo: ticket.complaintNo ?? "N/A",
                                vehicleNo:
                                    ticket.vehicle?.vehicleNumber ?? "N/A",
                                assignedTo: ticket.mechanic?.name ?? "N/A",
                                wmNo: ticket.mechanic?.mobileNumber ?? "N/A",
                                tracking: 'http://bit.ly/ALCARE_APP',
                                // ✅ NAYI DETAILS PASS KI GAYI
                                customerName: ticket.customer?.name ?? "N/A",
                                vehicleModel: ticket.vehicle?.model ?? "N/A",
                                vehicleMake: ticket.vehicle?.make ?? "N/A",
                                breakdownLocation: ticket.location ?? "N/A",
                                customerAddress: customerAddress.isEmpty
                                    ? "N/A"
                                    : customerAddress,
                                color: AppColors.colGreen,
                                colorborder: AppColors.colGreen,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            RoutesName.estimate,
                                            arguments: {
                                              'ticketsResults': ticket,
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: AppColors.colGreen,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                            child: Text(
                                              "View details",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.whitecol),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 25,
                                      //   width: 139,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 10),
                                      //     child: ElevatedButton(
                                      //         style: ButtonStyle(
                                      //             backgroundColor:
                                      //                 WidgetStateProperty.all<
                                      //                         Color>(
                                      //                     AppColors.colGreen)),
                                      //         onPressed: () {
                                      //           Navigator.pushNamed(
                                      //             context,
                                      //             RoutesName.estimate,
                                      //             arguments: {
                                      //               'ticketsResults': ticket,
                                      //             },
                                      //           );
                                      //         },
                                      //         child: const Text(
                                      //           "View Details",
                                      //           style: TextStyle(
                                      //               color: AppColors.whitecol),
                                      //         )),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    // height: 84,
                                    width: width,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Color(0xffD9D9D9),
                                            width: 1.0,
                                          ),
                                        ),
                                        color: Color(0xffF9F9F9),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const InterText(
                                              // textalign: TextAlign.end,
                                              text: "Rating",
                                              fontsize: 14,
                                              maxLines: 1,
                                              fontweight: FontWeight.w500,
                                              color: AppColors.lightblackcol,
                                            ),
                                            RatingBar(
                                                ignoreGestures: true,
                                                initialRating:
                                                    ticket.rating ?? 0.0,
                                                minRating: 1,
                                                maxRating: 5,
                                                itemSize: 15,
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                      Icons.star,
                                                      color: AppColors
                                                          .starYellowcol,
                                                    ),
                                                    half: const Icon(
                                                      Icons.star_half,
                                                      color: AppColors
                                                          .starYellowcol,
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star,
                                                      color:
                                                          AppColors.stargreycol,
                                                    )),
                                                onRatingUpdate: (rating) {}),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          ticket.review ?? "",
                                          // maxLines: _isExpanded ? null : 1,
                                          style: const TextStyle(
                                            color: AppColors.lightblackcol,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'inter',
                                          ),
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else if (state is TicketsError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String changeTimeFormat(String orignalTime) {
    DateTime dateTime = DateTime.parse(orignalTime);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm a")
        .format(dateTime.toUtc().add(const Duration(hours: 5, minutes: 30)));
    return formattedDate;
  }
}
