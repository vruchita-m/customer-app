import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/constant/api/apis.dart';
import 'package:service_mitra/config/constant/utils.dart';
import 'package:service_mitra/config/data/model/ticket/ticket_model.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

class TicketRespository {
  TicketRespository();

  Future<List<TicketsResults>> getTicketList(
      {required BuildContext context,
      int page = 1,
      int size = 10,
      String vehicleId = ""}) async {
    final userId = Preference.getString(PrefKeys.userId);

    String urlString =
        "${AppConstants.openTickets}$userId&page=$page&size=$size";
    if (vehicleId.isNotEmpty) {
      urlString = "$urlString&vehicle_id=$vehicleId";
    }
    final url = Uri.parse(urlString);

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
        TicketsModel data = TicketsModel.fromJson(responseData);
        List<TicketsResults> vehicleList = data.results ?? [];

        return vehicleList
            .where((element) => (element.imagewithcustomer ?? "").isEmpty)
            .toList();
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
        throw Exception('Tickets fetched failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("Tickets fetched failed. Please try again.");
    }
  }

  Future<List<TicketsResults>> getClosedTicketList(
      {required BuildContext context,
      int page = 1,
      int size = 10,
      String vehicleId = ""}) async {
    final userId = Preference.getString(PrefKeys.userId);

    String urlString =
        "${AppConstants.closedTickets}$userId&page=$page&size=$size";
    if (vehicleId.isNotEmpty) {
      urlString = "$urlString&vehicle_id=$vehicleId";
    }
    final url = Uri.parse(urlString);

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
        TicketsModel data = TicketsModel.fromJson(responseData);
        List<TicketsResults> vehicleList = data.results ?? [];

        return vehicleList
            .where((element) => (element.imagewithcustomer ?? "").isNotEmpty)
            .toList();
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
        throw Exception('Tickets fetched failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("Tickets fetched failed. Please try again.");
    }
  }
}
