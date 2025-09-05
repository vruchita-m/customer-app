import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/constant/api/apis.dart';
import 'package:service_mitra/config/data/model/notification_modal.dart';
import 'package:service_mitra/config/data/model/ticket/ticket_model.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

class NotificationRepositry {
  Future<List<NotificationResults>> fetchNotifications(
      BuildContext context) async {
    try {
      final userId = Preference.getString(PrefKeys.userId);
      final response = await http.get(
        Uri.parse("${AppConstants.notifications}$userId"),
        headers: {
          'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        },
      );

      debugPrint("Url: ${AppConstants.notifications}$userId");
      debugPrint("Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["results"] != null && data["results"] is List) {
          return (data["results"] as List)
              .map((item) => NotificationResults.fromJson(item))
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
          debugPrint("Error: 'results' is null or not a list");
          return [];
        }
      } else {
        throw Exception(
            "Failed to load notifications. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception in fetchNotifications: $e");
      return [];
    }
  }

  Future<TicketsResults> getTicketDetail(
      String ticketId, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.ticketDetail}$ticketId"),
        headers: {
          'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        },
      );

      debugPrint("Url: ${AppConstants.ticketDetail}$ticketId");
      debugPrint("Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return TicketsResults.fromJson(data["results"]);
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
        throw Exception(
            "Failed to load ticket detail. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception in fetchNotifications: $e");
      throw Exception("Failed to load ticket detail");
    }
  }
}
