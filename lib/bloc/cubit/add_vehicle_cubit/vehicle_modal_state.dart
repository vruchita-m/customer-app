import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class VehicleModalState {}

class VehicleModalInitial extends VehicleModalState {}

class VehicleModalLoading extends VehicleModalState {}

class VehicleModalLoaded extends VehicleModalState {
  final List<VehicleMakeResults> vehicleModal;
  VehicleModalLoaded(this.vehicleModal);
}

class VehicleModalError extends VehicleModalState {
  final String message;
  VehicleModalError(this.message);
}
