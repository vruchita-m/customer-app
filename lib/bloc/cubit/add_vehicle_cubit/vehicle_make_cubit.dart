import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_make_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class VehicleMakeCubit extends Cubit<VehiclesMakeState> {
  final MyVehicleRepositry myVehicleRepositry;

  VehicleMakeCubit(this.myVehicleRepositry) : super(VehiclesMakeInitial());
  
  Future<void> fetchVehicleMake(BuildContext context) async {
    emit(VehiclesMakeLoading());
    try {
      final vehicleMakeList = await myVehicleRepositry.getVehiclesMakeList(context: context);
      emit(VehiclesMakeLoaded(vehicleMakeList));
    } catch (e) {
      emit(VehiclesMakeError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}