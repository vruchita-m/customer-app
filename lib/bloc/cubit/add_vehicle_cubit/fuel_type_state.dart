import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class FuelTypeState {}

class FuelTypeInitial extends FuelTypeState {}

class FuelTypeLoading extends FuelTypeState {}

class FuelTypeLoaded extends FuelTypeState {
  final List<VehicleMakeResults> FuelType;
  FuelTypeLoaded(this.FuelType);
}

class FuelTypeError extends FuelTypeState {
  final String message;
  FuelTypeError(this.message);
}
