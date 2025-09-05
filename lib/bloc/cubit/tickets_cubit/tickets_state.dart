import 'package:service_mitra/config/data/model/ticket/ticket_model.dart';

abstract class TicketsState {}

class TicketsInitial extends TicketsState {}

class TicketsLoading extends TicketsState {}

class TicketsLoaded extends TicketsState {
  final List<TicketsResults> tickets;
  TicketsLoaded(this.tickets);
}
class TicketsCategorized extends TicketsState {
  final List<TicketsResults> openTickets;
  final List<TicketsResults> closedTickets;
  final String? ticketIdForFeedback;

  TicketsCategorized({required this.openTickets,
    required this.closedTickets,
    this.ticketIdForFeedback,});
}
class TicketsError extends TicketsState {
  final String message;
  TicketsError(this.message);
}
