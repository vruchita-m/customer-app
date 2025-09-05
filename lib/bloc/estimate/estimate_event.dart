import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EstimateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchEstimatesEvent extends EstimateEvent {
  final BuildContext context;
  final String tickedId;

  FetchEstimatesEvent({ required this.context,required this.tickedId});

  @override
  List<Object?> get props => [context,tickedId];
}

class ResetState extends EstimateEvent{

}

class FetchDismantleData extends EstimateEvent {
  final BuildContext context;
  final String tickedId;

  FetchDismantleData({ required this.context,required this.tickedId});

  @override
  List<Object?> get props => [context,tickedId];
}
class FetchInvestigationData extends EstimateEvent {
  final BuildContext context;
  final String tickedId;

  FetchInvestigationData({ required this.context,required this.tickedId});

  @override
  List<Object?> get props => [context,tickedId];
}
class setTicketStatus extends EstimateEvent {
  final BuildContext context;
  final String ticketStatus;

  setTicketStatus({ required this.context,required this.ticketStatus });

  @override
  List<Object?> get props => [context,ticketStatus];
}


class UpdateStatus extends EstimateEvent {
  final BuildContext context;
  final String tickedId;
  final String ticketStatus;
  final String cancelationReason;

  UpdateStatus({ required this.context,required this.tickedId,required this.ticketStatus, required this.cancelationReason});

  @override
  List<Object?> get props => [context,tickedId];
}