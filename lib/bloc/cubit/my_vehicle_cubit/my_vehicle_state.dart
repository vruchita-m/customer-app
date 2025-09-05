import 'package:service_mitra/config/data/model/vehicles/my_vehicles_model.dart';

abstract class MyVehiclesState {}

class MyVehiclesInitial extends MyVehiclesState {}

class MyVehiclesLoading extends MyVehiclesState {}

class MyVehiclesLoaded extends MyVehiclesState {
  final List<MyVehiclesResults> vehicles;
  MyVehiclesLoaded(this.vehicles);
}

class MyVehiclesError extends MyVehiclesState {
  final String message;
  MyVehiclesError(this.message);
}
