import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/bloc/estimate/estimate_event.dart';
import 'package:service_mitra/bloc/estimate/estimate_state.dart';
import 'package:service_mitra/config/data/model/estimate/dismantle_model.dart';
import 'package:service_mitra/config/data/model/estimate/estimate_model.dart';
import 'package:service_mitra/config/data/model/estimate/investigation_modal.dart';

import '../../config/data/repository/estimate/estimation_repository.dart';

class EstimateBloc extends Bloc<EstimateEvent, EstimateState> {
  final EstimationRepository _estimationRepository;

  EstimateBloc(this._estimationRepository)
      : super(const EstimateState(
          selectedParts: [],
          selectedPartsIdList: [],
          dismantleResults: [],
          inverstigationResult : [],
        )) {

    // on<ResetState>((event, emit) {
    //   emit(state.copyWith(
    //       isLoading: false,
    //       selectedParts: [],
    //       selectedPartsIdList: [],
    //       dismantleResults: [],
    //       inverstigationResult: [],
    //       statusLoading: false
    //     ));
    // },);  
    //
    //
    on<ResetState>((event, emit) {
      emit(const EstimateState( 
        selectedParts: [], 
        selectedPartsIdList: [], 
        dismantleResults: [], 
        inverstigationResult: [], 
        statusLoading: false,
      ));
    });
       
    on<FetchEstimatesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final estimationData = await _estimationRepository.getEstimates(
            context: event.context, ticketId: event.tickedId);

        debugPrint("Check estimation data: $estimationData   : TicketId : ${event.tickedId}");

        List<Part> updatedSelectedParts = [];

        try {
          debugPrint("Check estimation try");
          updatedSelectedParts = estimationData.results
                  ?.expand((result) {
                    try {
                      debugPrint("Check estimation try 2");

                      final partsList = result.categories
                              ?.expand((categoryElement) {
                            return categoryElement.parts
                                    ?.map((part) => Part(
                                          id: part.id ?? '',
                                          name: part.name ?? '',
                                          rottime:
                                              part.rottime?.toDouble() ?? 0.0,
                                          price: part.price?.toDouble() ?? 0.0,
                                          totalprice:
                                              part.totalprice?.toDouble() ??
                                                  0.0,
                                        ))
                                    .toList() ??
                                [];
                          }).toList() ??
                          [];

                      if (result.deputation != null && (result.deputation?.ratePerKm ?? 0) != 0) {
                        partsList.add(
                          Part(
                            id: result.deputation!.id ?? '',
                            name: "Deputation (${result.deputation?.vehicleType ?? ""}) ${result.deputationhour ?? "0"} KM : ",
                            // name: "Deputation Fee",
                            price:
                                result.deputation!.ratePerKm?.toDouble() ?? 0.0,
                            totalprice: (result.deputation!.ratePerKm
                                        ?.toDouble() ??
                                    0.0) *
                                (int.tryParse(result.deputationhour ?? "0") ??
                                    0),
                          ),
                        );
                      }

                      return partsList;
                    } catch (e, stacktrace) {
                      debugPrint("Error processing result: ${e.toString()}");
                      debugPrint("Stacktrace: $stacktrace");
                      return <Part>[];
                    }
                  })
                  .cast<Part>()
                  .toList() ??
              [];

          debugPrint("Updated Selected Parts: ${updatedSelectedParts.length}");
          for (var part in updatedSelectedParts) {
            debugPrint(
                "Part ID: ${part.id}, Name: ${part.name}, Price: ${part.price}, Total Price: ${part.totalprice}");
          }
        } catch (e, stacktrace) {
          debugPrint("Error in updatedSelectedParts: ${e.toString()}");
          debugPrint("Stacktrace: $stacktrace");
        }

        final List<String> updatedSelectedPartsIdList =
            updatedSelectedParts.map((part) => part.id!).toList();

        final String? estimationId = estimationData.results?.isNotEmpty == true
            ? estimationData.results!.first.id
            : null;

        emit(state.copyWith(
          isLoading: false,
          selectedParts: updatedSelectedParts,
          estimateId: estimationId,
          selectedPartsIdList: updatedSelectedPartsIdList,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      }
    });

    on<FetchDismantleData>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final estimationData = await _estimationRepository.getDismantleData(
            context: event.context, ticketId: event.tickedId);

        List<DismantleResults> dismantleResult = [];

        try {
          dismantleResult = estimationData ?? [];
        } catch (e, stacktrace) {
          debugPrint("Error in updatedSelectedParts: ${e.toString()}");
          debugPrint("Stacktrace: $stacktrace");
        }

        emit(state.copyWith(
          isLoading: false,
          dismantleResults: dismantleResult,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      }
    });

    on<FetchInvestigationData>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final investigationData = await _estimationRepository.getVehicleInvestigation(
            context: event.context, ticketId: event.tickedId);

        List<InvestigatioResults> inverstigationResult = [];

        try {
          inverstigationResult = investigationData.results ?? [];
        } catch (e, stacktrace) {
          debugPrint("Error in updatedSelectedParts: ${e.toString()}");
          debugPrint("Stacktrace: $stacktrace");
        }

        emit(state.copyWith(
          isLoading: false,
          inverstigationResult: inverstigationResult,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      }
    });

    on<setTicketStatus>((event, emit) {
      emit(state.copyWith(statusUpdate: false));
    },);

    on<UpdateStatus>((event, emit) async {
      emit(state.copyWith(statusLoading: true));

      try {
        final updateStatus = await _estimationRepository.updateStatus(
            context: event.context,
            ticketId: event.tickedId,
            status: event.ticketStatus,
            cancelationReason : event.cancelationReason);

        debugPrint("Check estimation data: $updateStatus");

        try {
          debugPrint("Check estimation try");

          emit(state.copyWith(statusLoading: false, statusUpdate: updateStatus));
        } catch (e, stacktrace) {
          emit(state.copyWith(statusLoading: false, statusFailed: true));
          debugPrint("Error in updatedSelectedParts: ${e.toString()}");
          debugPrint("Stacktrace: $stacktrace");
        }
      } catch (e) {
        emit(state.copyWith(statusLoading: false, statusFailed: true));
      }

      emit(state.copyWith(statusLoading: false, statusUpdate: true));
    });
  }
}
