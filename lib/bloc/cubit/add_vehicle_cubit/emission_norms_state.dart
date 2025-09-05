import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';

abstract class EmissionNormsState {}

class EmissionNormsInitial extends EmissionNormsState {}

class EmissionNormsLoading extends EmissionNormsState {}

class EmissionNormsLoaded extends EmissionNormsState {
  final List<VehicleMakeResults> emissionNorms;
  EmissionNormsLoaded(this.emissionNorms);
}

class EmissionNormsError extends EmissionNormsState {
  final String message;
  EmissionNormsError(this.message);
}
