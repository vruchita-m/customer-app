// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/vehicles/vehicle_make_model.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import '../../../constant/api/apis.dart';
import '../../../constant/utils.dart';
import '../../../share_preferences/preferences.dart';
import '../../model/vehicles/my_vehicles_model.dart';
import 'dart:io';

class MyVehicleRepositry {
  MyVehicleRepositry();

  Future<List<MyVehiclesResults>> getVehiclesList({
    required BuildContext context,
  }) async {
    final userId = Preference.getString(PrefKeys.userId);

    final url = Uri.parse("${AppConstants.listVehicles}$userId&page=1&size=10");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        MyVehiclesModel data = MyVehiclesModel.fromJson(responseData);
        List<MyVehiclesResults> vehicleList = data.results ?? [];

        return vehicleList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getVehiclesMakeList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.vehicleMake}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getEmissionNormsList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.emissionNorms}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getFuelTypeList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.fuelTypes}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getVehicleCategoryList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.vehicleCategories}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getVehicleModalList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.vehicleModal}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<List<VehicleMakeResults>> getTyresList({
    required BuildContext context,
  }) async {
    final url = Uri.parse("${AppConstants.tyresNumber}");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        VehicleMakeModel data = VehicleMakeModel.fromJson(responseData);
        List<VehicleMakeResults> vehicleMakeList = data.results ?? [];

        return vehicleMakeList;
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }

  Future<String> addVehicle(
      {required BuildContext context,
      required String vehicleNumber,
      required File chassisNumber,
      required File rcNumber,
      required String make,
      required String emissionNorm,
      required String fuelType,
      required String category,
      required String model,
      required int year,
      required int numberOfTyres,
      required String kmReading,
      required File vehiclePic}) async {
    final userId = Preference.getString(PrefKeys.userId);
    final url = Uri.parse(AppConstants.addVehicle);

    try {
      var request = http.MultipartRequest("POST", url);

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'accept': "application/json",
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
      });

      request.fields.addAll({
        'user_id': userId,
        'vehicle_number': vehicleNumber,
        'make': make,
        'emission_norm': emissionNorm,
        'fuel_type': fuelType,
        'category': category,
        'model': model,
        'year': year.toString(),
        'number_of_tyres': numberOfTyres.toString(),
        'km_reading': kmReading,
      });

      // Attach files
      request.files.add(await http.MultipartFile.fromPath(
          'chassis_number', chassisNumber.path));
      request.files
          .add(await http.MultipartFile.fromPath('rc_number', rcNumber.path));
      request.files.add(
          await http.MultipartFile.fromPath('vehicle_pic', vehiclePic.path));

      debugPrint("Request: ${request.fields}");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("Response Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        return responseData['status'];
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        await ApiUtils.manageException(
            http.Response(responseBody, response.statusCode), context);
        throw Exception('Vehicle add failed');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Vehicle add failed. Please try again.");
    }
  }

  Future<String> editVehicle({
    required BuildContext context,
    required String vehicleNumber,
    required String vehicle_id,
    required String make,
    required String emissionNorm,
    required String fuelType,
    required String category,
    required String model,
    required int year,
    required int numberOfTyres,
    required String kmReading,
  }) async {
    final userId = Preference.getString(PrefKeys.userId);
    final url = Uri.parse("${AppConstants.addVehicle}$vehicle_id/");

    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'accept': "application/json",
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
      };

      var request = http.MultipartRequest("PATCH", url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'user_id': userId,
        'vehicle_number': vehicleNumber,
        'make': make,
        'emission_norm': emissionNorm,
        'fuel_type': fuelType,
        'category': category,
        'model': model,
        'year': year.toString(),
        'number_of_tyres': numberOfTyres.toString(),
        'km_reading': kmReading,
      });
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("Response Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        return responseData['status'];
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        await ApiUtils.manageException(
            http.Response(responseBody, response.statusCode), context);
        throw Exception('Vehicle update failed');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Vehicle update failed. Please try again.");
    }
  }

  Future<bool> deleteVehicle(
      {required BuildContext context, required String vehicleId}) async {
    final userId = Preference.getString(PrefKeys.userId);

    final url = Uri.parse("${AppConstants.addVehicle}$vehicleId/");

    final headers = {
      'Content-Type': 'application/json',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.delete(url, headers: headers);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint("responseData : $responseData");
        return true;
      } else if (response.statusCode == 401) {
        await Preference.clear();
        await Fluttertoast.showToast(
          msg: "Your account has been deleted.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.colred,
          textColor: AppColors.whitecol,
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );
        throw Exception("Unauthorized");
      } else {
        debugPrint("check else goes");
        await ApiUtils.manageException(response, context);
        throw Exception('MPIN failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("MPIN failed. Please try again.");
    }
  }
}
