import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_state.dart';
import 'package:service_mitra/config/data/repository/ticket/ticket_respository.dart';
import 'package:service_mitra/views/screens/drawer/breakdown_ticket_status/open_tickets.dart';

import '../../../config/data/model/ticket/ticket_model.dart';
import '../../../config/share_preferences/preferences.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final TicketRespository ticketRespository;
  TicketsCubit(this.ticketRespository) : super(TicketsInitial());

  // ADDED: New function to fetch and filter all tickets for the main screen
  Future<void> fetchAndCategorizeAllTickets(BuildContext context) async {
    emit(TicketsLoading());
    try {
      final allTickets = await ticketRespository.getTicketList(context: context);

      final List<TicketsResults> openList = [];
      final List<TicketsResults> closedList = [];

      for (var ticket in allTickets) {
        if (ticket.status == 'Payment Done' || ticket.status == 'Ticket Closed') {
          closedList.add(ticket);
        } else {
          openList.add(ticket);
        }
      }
      String? feedbackTicketId;
      if (closedList.isNotEmpty) {
        closedList.sort((a, b) => DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));

        final mostRecentClosedTicket = closedList.first;
        final localTicketId = Preference.getString("feedback_ticket_id");

        if ((mostRecentClosedTicket.review ?? "").isEmpty &&
            localTicketId != (mostRecentClosedTicket.id ?? "")) {
          feedbackTicketId = mostRecentClosedTicket.id;
        }
      }
      emit(TicketsCategorized(
        openTickets: openList,
        closedTickets: closedList,
        ticketIdForFeedback: feedbackTicketId, // Pass the ID here
      ));
    } catch (e) {
      emit(TicketsError(e.toString()));
    }
  }

  // ADDED: New function to fetch and filter tickets for a specific vehicle
  Future<void> fetchAndCategorizeTicketsByVehicle(BuildContext context, String vehicleId) async {
    emit(TicketsLoading());
    try {
      // This method should fetch all tickets for the given vehicleId
      final allTickets = await ticketRespository.getTicketList(context: context, vehicleId: vehicleId);

      final List<TicketsResults> openList = [];
      final List<TicketsResults> closedList = [];

      for (var ticket in allTickets) {
        if (ticket.status == 'Payment Done' || ticket.status == 'Ticket Closed') {
          closedList.add(ticket);
        } else {
          openList.add(ticket);
        }
      }
      emit(TicketsCategorized(openTickets: openList, closedTickets: closedList));
    } catch (e) {
      emit(TicketsError(e.toString()));
    }
  }

  Future<void> getOpenTickets(BuildContext context) async {
    emit(TicketsLoading());
    try {
      final vehicles = await ticketRespository.getTicketList(context: context);

      // // 👇 Logic to show feedback dialog if needed
      // if (vehicles.isNotEmpty) {
      //   final firstTicket = vehicles.first;
      //   final localTicketId = Preference.getString("feedback_ticket_id");

      //   if ((firstTicket.review ?? "").isEmpty &&
      //       localTicketId != (firstTicket.id ?? "")) {
      //     // Wait for a small duration before showing dialog
      //     Preference.setString("feedback_ticket_id", firstTicket.id ?? "");

      //     Future.delayed(const Duration(milliseconds: 300), () {
      //       showFeedbackDialog(context, firstTicket.id ?? "");
      //     });
      //   }
      // }
      emit(TicketsLoaded(vehicles));
    } catch (e) {
      emit(TicketsError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicles: ${e.toString()}")),
      );
    }
  }

  Future<void> getClosedTickets(BuildContext context) async {
    emit(TicketsLoading());
    try {
      final vehicles =
          await ticketRespository.getClosedTicketList(context: context);

      // // 👇 Logic to show feedback dialog if needed
      if (vehicles.isNotEmpty) {
        final firstTicket = vehicles.first;
        final localTicketId = Preference.getString("feedback_ticket_id");

        if ((firstTicket.review ?? "").isEmpty &&
            localTicketId != (firstTicket.id ?? "")) {
          // Wait for a small duration before showing dialog
          Preference.setString("feedback_ticket_id", firstTicket.id ?? "");

          Future.delayed(const Duration(milliseconds: 300), () {
            showFeedbackDialog(context, firstTicket.id ?? "");
          });
        }
      }
      emit(TicketsLoaded(vehicles));
    } catch (e) {
      emit(TicketsError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicles: ${e.toString()}")),
      );
    }
  }

  Future<void> getOpenTicketsByVehicleId(
      BuildContext context, String vehicleId) async {
    emit(TicketsLoading());
    try {
      final vehicles = await ticketRespository.getTicketList(
          context: context, vehicleId: vehicleId);
      emit(TicketsLoaded(vehicles));
    } catch (e) {
      emit(TicketsError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicles: ${e.toString()}")),
      );
    }
  }

  Future<void> getClosedTicketsByTicketId(
      BuildContext context, String vehicleId) async {
    emit(TicketsLoading());
    try {
      final vehicles = await ticketRespository.getClosedTicketList(
          context: context, vehicleId: vehicleId);
      emit(TicketsLoaded(vehicles));
    } catch (e) {
      emit(TicketsError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicles: ${e.toString()}")),
      );
    }
  }
}
