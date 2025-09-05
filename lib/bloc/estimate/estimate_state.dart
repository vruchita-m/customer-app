import 'package:equatable/equatable.dart';
import 'package:service_mitra/config/data/model/estimate/dismantle_model.dart';
import 'package:service_mitra/config/data/model/estimate/investigation_modal.dart';

import '../../config/data/model/estimate/estimate_model.dart';

class EstimateState extends Equatable {
  final bool isLoading;
  final bool statusLoading;
  final bool statusUpdate;
  final bool statusFailed;
  final List<Part> selectedParts;
  final List<String> selectedPartsIdList;
  final List<DismantleResults> dismantleResults;
  final List<InvestigatioResults> inverstigationResult;
  final Deputation? deputation;
  final String? deputationhour;
  final String? estimateId;

  const EstimateState(
      {this.isLoading = false,
      this.statusLoading = false,
      this.statusUpdate = false,
      this.statusFailed = false,
      this.deputationhour = "0",
      this.deputation,
      required this.selectedParts,
      required this.selectedPartsIdList,
      required this.dismantleResults,
      required this.inverstigationResult,
      this.estimateId});

  EstimateState copyWith(
      {bool? isLoading,
      bool? statusLoading,
      bool? statusUpdate,
      bool? statusFailed,
      List<Part>? selectedParts,
      List<String>? selectedPartsIdList,
      List<DismantleResults>? dismantleResults,
      List<InvestigatioResults>? inverstigationResult,
      Deputation? deputation,
      String? deputationhour,
      String? estimateId}) {
    return EstimateState(
        isLoading: isLoading ?? this.isLoading,
        statusLoading: statusLoading ?? this.statusLoading,
        statusUpdate: statusUpdate ?? this.statusUpdate,
        statusFailed: statusFailed ?? this.statusFailed,
        selectedParts: selectedParts ?? this.selectedParts,
        selectedPartsIdList: selectedPartsIdList ?? this.selectedPartsIdList,
        dismantleResults: dismantleResults ?? this.dismantleResults,
        inverstigationResult: inverstigationResult ?? this.inverstigationResult,
        deputation: deputation ?? this.deputation,
        deputationhour: deputationhour ?? this.deputationhour,
        estimateId: estimateId ?? this.estimateId);
  }

  @override
  List<Object?> get props => [
        isLoading,
        statusLoading,
        statusUpdate,
        statusFailed,
        selectedParts,
        selectedPartsIdList,
        inverstigationResult,
        dismantleResults,
        deputation,
        deputationhour,
        estimateId
      ];
}
