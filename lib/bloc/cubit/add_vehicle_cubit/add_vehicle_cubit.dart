import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/image_picker_bloc/image_picker_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';
import 'package:service_mitra/config/routes/routes_name.dart';

class AddVehicleCubit extends Cubit<VehicleAddState> {
  final MyVehicleRepositry myVehicleRepositry;

  AddVehicleCubit(this.myVehicleRepositry) : super(VehicleAddState());

  // Controllers
  final TextEditingController vehicleNo = TextEditingController();
  final TextEditingController chessisNo = TextEditingController();
  final TextEditingController rcNo = TextEditingController();
  final TextEditingController vehicleImage = TextEditingController();
  final TextEditingController kmReading = TextEditingController();

  // Other Fields
  String make = "", emissionNorm = "", fuelType = "", category = "", modal = "", year = "", noOfTyres = ""; 
  final formKey = GlobalKey<FormState>();
  String vehicleFilePath = "", rcFilePath = "", chassisFilePath = "";

  // reset
  void resetState(){
    vehicleNo.clear();
    chessisNo.clear();
    rcNo.clear();
    vehicleImage.clear();
    kmReading.clear();
    make = "";
    emissionNorm = "";
    fuelType = "";
    category = "";
    modal = "";
    year = "";
    noOfTyres = "";
    vehicleFilePath = "";
    rcFilePath = "";
    chassisFilePath = "";

    emit(state.copyWith());
  }

  // Validation Methods
  String? vehicleNoValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter vehicle no";
    if (value.length < 10) return "Please enter a valid vehicle no";
    if(value.contains(" ")) return "No Space allowed in between vehicle number";
    final regex = RegExp(r'^[A-Za-z]{2}\d{2}[A-Za-z]{1,3}\d{1,4}$');
    if(!regex.hasMatch(value)) return "Please enter valid vehicle number";
    return null;
  }

  String? vehicleKMValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter vehicle KM";
    return null;
  }

  String? chessisNoValidator(String? value) {
    if (value == null || value.isEmpty) return "Please upload chassis no image";
    return null;
  }

  String? rcNoValidator(String? value) {
    if (value == null || value.isEmpty) return "Please upload RC image";
    return null;
  }

  String? vehicleImageValidator(String? value) {
    if (value == null || value.isEmpty) return "Please upload Vehicle image";
    return null;
  }

  String? makeValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select make";
    make = value;
    return null;
  }

  String? emissionValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select Emission Norm";
    emissionNorm = value;
    return null;
  }

  String? fuelTypeValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select fuel type";
    fuelType = value;
    return null;
  }

  String? categoryValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select category";
    category = value;
    return null;
  }

  String? modalValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select modal";
    modal = value;
    return null;
  }

  String? yearValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select year";
    year = value;
    return null;
  }

  String? tyresValidator(String? value) {
    if (value == null || value.isEmpty) return "Please select no. of tyres";
    noOfTyres = value;
    return null;
  }

  // Add Vehicle Method
  void addVehicle(BuildContext context) async {
    debugPrint("Validation Check");
    if (!formKey.currentState!.validate()) {
      debugPrint("Validation Failed");
      return; // Stop if validation fails
    }

    emit(state.copyWith(isLoading: true));

    try {
      File? chassisFile = chassisFilePath.isNotEmpty ? File(chassisFilePath) : null;
      File? vehiclePicFile = vehicleFilePath.isNotEmpty ? File(vehicleFilePath) : null;
      File? rcFile = rcFilePath.isNotEmpty ? File(rcFilePath) : null;

      if (chassisFile == null || vehiclePicFile == null || rcFile == null) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload all required images")),
        );
        emit(state.copyWith(isLoading: false));
        return;
      }

      final response = await myVehicleRepositry.addVehicle(
        vehicleNumber: vehicleNo.text,
        chassisNumber: chassisFile,
        vehiclePic: vehiclePicFile,
        rcNumber: rcFile,
        make: make,
        emissionNorm: emissionNorm,
        fuelType: fuelType,
        category: category,
        model: modal,
        year: int.parse(year),
        numberOfTyres: int.parse(noOfTyres),
        kmReading: kmReading.text,
        context: context,
      );

      if (response == "success") {
        debugPrint("Vehicle added successfully");

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Vehicle added successfully"),
            backgroundColor: AppColors.colGreen,
          ),
        );

        emit(state.copyWith(isSuccess: true, isLoading: false));
        resetState();
        Timer(const Duration(milliseconds: 300), () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, RoutesName.myvehicles);
        },);
      } else {
        debugPrint("Vehicle addition failed");
        emit(state.copyWith(isSuccess: false, isLoading: false));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      emit(state.copyWith(isSuccess: false, isLoading: false));
    }
  }

  // Add Vehicle Method
  void editVehicle(BuildContext context, String vehicleId) async {
    debugPrint("Validation Check");
    if (!formKey.currentState!.validate()) {
      debugPrint("Validation Failed");
      return; // Stop if validation fails
    }

    emit(state.copyWith(isLoading: true));

    try {
      
      final response = await myVehicleRepositry.editVehicle(
        vehicleNumber: vehicleNo.text,
        make: make,
        vehicle_id: vehicleId,
        emissionNorm: emissionNorm,
        fuelType: fuelType,
        category: category,
        model: modal,
        year: int.parse(year),
        numberOfTyres: int.parse(noOfTyres),
        kmReading: kmReading.text,
        context: context,
      );

      if (response == "success") {
        debugPrint("Vehicle Edited successfully");

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Vehicle updated successfully"),
            backgroundColor: AppColors.colGreen,
          ),
        );

        emit(state.copyWith(isSuccess: true, isLoading: false));
        resetState();
        Timer(const Duration(milliseconds: 300), () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, RoutesName.myvehicles);
        },);
      } else {
        debugPrint("Vehicle addition failed");
        emit(state.copyWith(isSuccess: false, isLoading: false));
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      emit(state.copyWith(isSuccess: false, isLoading: false));
    }
  }
}

// State Class
class VehicleAddState {
  final String? apiError;
  final bool isSuccess;
  final bool isLoading;

  VehicleAddState({
    this.apiError,
    this.isSuccess = false,
    this.isLoading = false,
  });

  VehicleAddState copyWith({
    String? apiError,
    bool? isSuccess,
    bool? isLoading,
  }) {
    return VehicleAddState(
      apiError: apiError ?? this.apiError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
