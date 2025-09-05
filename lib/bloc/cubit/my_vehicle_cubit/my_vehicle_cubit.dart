import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/my_vehicle_cubit/my_vehicle_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class MyVehiclesCubit extends Cubit<MyVehiclesState>{
  final MyVehicleRepositry myVehicleRepositry;
  MyVehiclesCubit(this.myVehicleRepositry) : super(MyVehiclesInitial());

  Future<void> fetchVehicles(BuildContext context) async {
    emit(MyVehiclesLoading());
    try {
      final vehicles = await myVehicleRepositry.getVehiclesList(context: context);
      emit(MyVehiclesLoaded(vehicles));
    } catch (e) {
      emit(MyVehiclesError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicles: ${e.toString()}")),
      );
    }
  }
}
