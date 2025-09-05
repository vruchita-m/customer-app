import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_modal_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class VehicleModalCubit extends Cubit<VehicleModalState> {
  final MyVehicleRepositry myVehicleRepositry;

  VehicleModalCubit(this.myVehicleRepositry) : super(VehicleModalInitial());
  
  Future<void> fetchVehicleModal(BuildContext context) async {
    emit(VehicleModalLoading());
    try {
      final VehicleModalList = await myVehicleRepositry.getVehicleModalList(context: context);
      emit(VehicleModalLoaded(VehicleModalList));
    } catch (e) {
      emit(VehicleModalError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}