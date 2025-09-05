import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class VehicleCategoryState {}

class VehicleCategoryInitial extends VehicleCategoryState {}

class VehicleCategoryLoading extends VehicleCategoryState {}

class VehicleCategoryLoaded extends VehicleCategoryState {
  final List<VehicleMakeResults> vehicleCategory;
  VehicleCategoryLoaded(this.vehicleCategory);
}

class VehicleCategoryError extends VehicleCategoryState {
  final String message;
  VehicleCategoryError(this.message);
}
