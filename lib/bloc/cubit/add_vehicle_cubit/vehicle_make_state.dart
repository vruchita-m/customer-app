import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class VehiclesMakeState {}

class VehiclesMakeInitial extends VehiclesMakeState {}

class VehiclesMakeLoading extends VehiclesMakeState {}

class VehiclesMakeLoaded extends VehiclesMakeState {
  final List<VehicleMakeResults> vehicleMakes;
  VehiclesMakeLoaded(this.vehicleMakes);
}

class VehiclesMakeError extends VehiclesMakeState {
  final String message;
  VehiclesMakeError(this.message);
}
