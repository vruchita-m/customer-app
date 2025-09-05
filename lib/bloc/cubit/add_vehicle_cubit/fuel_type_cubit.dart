import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/fuel_type_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class FuelTypeCubit extends Cubit<FuelTypeState> {
  final MyVehicleRepositry myVehicleRepositry;

  FuelTypeCubit(this.myVehicleRepositry) : super(FuelTypeInitial());
  
  Future<void> fetchFuelType(BuildContext context) async {
    emit(FuelTypeLoading());
    try {
      final FuelTypeList = await myVehicleRepositry.getFuelTypeList(context: context);
      emit(FuelTypeLoaded(FuelTypeList));
    } catch (e) {
      emit(FuelTypeError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}