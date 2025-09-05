import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/views/screens/onboarding/login_screen.dart';

import '../colors/colors.dart';
import '../routes/routes_name.dart';
import '../share_preferences/preferences.dart';

class ApiUtils {
  static Future<void> manageException(
    http.Response response,
    BuildContext context,
  ) async {
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      String errorMessage = responseData["detail"] ??
          responseData["message"] ??
          responseData["status_message"] ??
          "An unexpected error occurred";

      if (response.statusCode == 401 || response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: AppColors.whitecol),
            ),
            backgroundColor: AppColors.colred,
          ),
        );
        // await Preference.clear();
        // // Navigate to login screen
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   RoutesName.login,
        //   (route) => false,
        // );
      } else if (response.statusCode == 403) {
        debugPrint("response : ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: AppColors.whitecol),
            ),
            backgroundColor: AppColors.colred,
          ),
        );
        // appToast(msg: errorMessage);
        // logout(context);
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: AppColors.whitecol),
            ),
            backgroundColor: AppColors.colred,
          ),
        );
        // appToast(msg: errorMessage);
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Something went wrong on our end. Please try again later.",
              style: TextStyle(color: AppColors.whitecol),
            ),
            backgroundColor: AppColors.colred,
          ),
        );
        // appToast(msg: Strings.internalServerError);
      } else if (response.statusCode == 204) {
        // Handle no content
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: AppColors.whitecol),
            ),
            backgroundColor: AppColors.colred,
          ),
        ); // General error handling
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to parse error response.",
            style: TextStyle(color: AppColors.whitecol),
          ),
          backgroundColor: AppColors.colred,
        ),
      );
      // appToast(msg: "");
      debugPrint("Error parsing API response: $e");
    }
  }

  // static void logout(BuildContext context) async {
  //   StoreWrapper.clearSession();
  //   appToast(msg: Strings.internalServerError);
  // }
}
