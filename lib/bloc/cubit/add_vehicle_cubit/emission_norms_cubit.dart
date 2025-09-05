import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/emission_norms_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class EmissionNormsCubit extends Cubit<EmissionNormsState> {
  final MyVehicleRepositry myVehicleRepositry;

  EmissionNormsCubit(this.myVehicleRepositry) : super(EmissionNormsInitial());
  
  Future<void> fetchEmissionNorms(BuildContext context) async {
    emit(EmissionNormsLoading());
    try {
      final EmissionNormsList = await myVehicleRepositry.getEmissionNormsList(context: context);
      emit(EmissionNormsLoaded(EmissionNormsList));
    } catch (e) {
      emit(EmissionNormsError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}