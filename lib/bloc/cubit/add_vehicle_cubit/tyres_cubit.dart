import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/tyres_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';

class TyresCubit extends Cubit<TyresState> {
  final MyVehicleRepositry myVehicleRepositry;

  TyresCubit(this.myVehicleRepositry) : super(TyresInitial());
  
  Future<void> fetchTyres(BuildContext context) async {
    emit(TyresLoading());
    try {
      final TyresList = await myVehicleRepositry.getTyresList(context: context);
      emit(TyresLoaded(TyresList));
    } catch (e) {
      emit(TyresError(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch vehicle make : ${e.toString()}")),
      );
    }
  }
}