import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/estimate/dismantle_model.dart';
import 'package:service_mitra/config/data/model/estimate/investigation_modal.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

import '../../../constant/api/apis.dart';
import '../../../constant/utils.dart';
import '../../model/estimate/estimate_model.dart';

class EstimationRepository {
  EstimationRepository();

  Future<EstimationModel> getEstimates({
    required BuildContext context,
    required String ticketId,
  }) async {
    final url =
        Uri.parse("${AppConstants.estimateList}$ticketId&page=1&size=10");

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
        final estimationModel = EstimationModel.fromJson(responseData);
        debugPrint("Parsed EstimationModel: ${estimationModel.toJson()}");

        return estimationModel;
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

  Future<VehicleInvestigationModal> getVehicleInvestigation({
    required BuildContext context,
    required String ticketId,
  }) async {
    final url = Uri.parse(
        "${AppConstants.vehicleinvestigation}$ticketId&page=1&size=10");

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
        final investigationModal =
            VehicleInvestigationModal.fromJson(responseData);
        debugPrint(
            "Parsed VehicleInvestigationModal: ${investigationModal.toJson()}");

        return investigationModal;
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

  Future<List<DismantleResults>> getDismantleData({
    required BuildContext context,
    required String ticketId,
  }) async {
    final url = Uri.parse("${AppConstants.dismantleData}$ticketId");

    debugPrint("DISMANTLE URL  : $url");

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
        final data = DismantleModel.fromJson(responseData);
        debugPrint("Parsed DismantleModel: ${data.toJson()}");

        return data.results ?? [];
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

  Future<bool> updateStatus(
      {required BuildContext context,
      required String ticketId,
      required String status,
      required String cancelationReason}) async {
    final url = Uri.parse("${AppConstants.UpdateTicketStatus}$ticketId");

    debugPrint("API URL: $url");

    try {
      var request = http.MultipartRequest('PATCH', url);

      request.headers.addAll({
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
      });

      debugPrint("Request Headers: ${request.headers}");

      request.fields['status'] = status;
      if (cancelationReason.isNotEmpty) {
        request.fields['rejectionreasoncustomer'] = cancelationReason;
      }
      debugPrint("Sending Status: $status");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("Status updated successfully.");
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
        debugPrint("Status update failed.");
        await ApiUtils.manageException(response, context);
        return false;
      }
    } catch (e) {
      debugPrint("Error: $e");

      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }

      return false;
    }
  }
}
