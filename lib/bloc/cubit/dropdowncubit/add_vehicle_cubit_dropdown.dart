import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleCubitDropdown extends Cubit<String?> {
  VehicleCubitDropdown() : super(null);

  void selectMake(String make) => emit(make);
  void selectEmission(String emission) => emit(emission);
  void selectFuel(String fuel) => emit(fuel);
  void selectCategory(String category) => emit(category);
  void selectModal(String modal) => emit(modal);
  void selectYear(String year) => emit(year);
  void selectTyres(String tyres) => emit(tyres);
  void selectKM(String km) => emit(km);
}
