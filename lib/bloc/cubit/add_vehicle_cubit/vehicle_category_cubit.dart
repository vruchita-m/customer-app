import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_category_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class VehicleCategoryCubit extends Cubit<VehicleCategoryState> {
  final MyVehicleRepositry myVehicleRepositry;

  VehicleCategoryCubit(this.myVehicleRepositry) : super(VehicleCategoryInitial());
  
  Future<void> fetchVehicleCategory(BuildContext context) async {
    emit(VehicleCategoryLoading());
    try {
      final VehicleCategoryList = await myVehicleRepositry.getVehicleCategoryList(context: context);
      emit(VehicleCategoryLoaded(VehicleCategoryList));
    } catch (e) {
      emit(VehicleCategoryError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}