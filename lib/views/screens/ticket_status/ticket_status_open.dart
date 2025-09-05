import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_cubit.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/ticket/ticket_respository.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_tickets_container.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../utlis/sizes.dart';

class TicketStatusOpen extends StatefulWidget {
  final String vehicleId;
  const TicketStatusOpen({super.key, required this.vehicleId});

  @override
  State<TicketStatusOpen> createState() => _TicketStatusOpenState();
}

class _TicketStatusOpenState extends State<TicketStatusOpen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsCubit(TicketRespository())
        ..getOpenTicketsByVehicleId(context, widget.vehicleId),
      child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<TicketsCubit>()
                .getOpenTicketsByVehicleId(context, widget.vehicleId);
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
                                text2: changeTimeFormat(
                                    ticket.createdAt ?? ""), // "2023-12-21 - 13:18:59",
                                vehicleNo:
                                ticket.vehicle?.vehicleNumber ?? "N/A",
                                assignedTo: ticket.mechanic?.name ?? "N/A",
                                wmNo: ticket.mechanic?.mobileNumber ?? "N/A",

                                // ✅ NAYI DETAILS PASS KI GAYI
                                customerName: ticket.customer?.name ?? "N/A",
                                vehicleModel: ticket.vehicle?.model ?? "N/A",
                                vehicleMake: ticket.vehicle?.make ?? "N/A",
                                breakdownLocation: ticket.location ?? "N/A",
                                customerAddress: customerAddress.isEmpty
                                    ? "N/A"
                                    : customerAddress,

                                color: AppColors.colred,
                                colorborder: AppColors.colred,
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
    if (orignalTime.isEmpty) return "N/A";
    DateTime dateTime = DateTime.parse(orignalTime);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm a")
        .format(dateTime.toUtc().add(const Duration(hours: 5, minutes: 30)));
    return formattedDate;
  }
}