import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class TyresState {}

class TyresInitial extends TyresState {}

class TyresLoading extends TyresState {}

class TyresLoaded extends TyresState {
  final List<VehicleMakeResults> tyres;
  TyresLoaded(this.tyres);
}

class TyresError extends TyresState {
  final String message;
  TyresError(this.message);
}
