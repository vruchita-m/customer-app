import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/constant/api/apis.dart';
import 'package:service_mitra/config/constant/utils.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

class ProfileRepository {
  ProfileRepository();

  Future<Map<String, dynamic>> getProfile(BuildContext context) async {
    final userId = Preference.getString(PrefKeys.userId);

    final url = Uri.parse("${AppConstants.getProfile}$userId");

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

        return responseData["results"];
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
        throw Exception('Profile Fetch failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      debugPrint("check catch ${e.toString()}");
      if (e is http.Response) {
        await ApiUtils.manageException(e, context);
      }
      throw Exception("Profile Fetch failed. Please try again.");
    }
  }

  Future<void> updateProfile(
      BuildContext context, Map<String, String> updatedData) async {
    final userId = Preference.getString(PrefKeys.userId);
    final url = Uri.parse("${AppConstants.getProfile}$userId");

    String? profilePicPath;

    profilePicPath = updatedData['profile_pic'];

    debugPrint("url : $url");
    debugPrint("body : $updatedData");

    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'accept': "application/json",
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
      };

      var request = http.MultipartRequest("PATCH", url);
      request.headers.addAll(headers);
      updatedData.remove("profile_pic");
      request.fields.addAll(updatedData);

      if (profilePicPath != null && profilePicPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          profilePicPath,
        ));
      }

      debugPrint("request : $request");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("Response Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");
      debugPrint("Response : $response");

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
        throw Exception('Profile update failed');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Profile update failed. Please try again.");
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    final userId = Preference.getString(PrefKeys.userId);
    final url = Uri.parse("${AppConstants.deleteProfile}$userId");

    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'accept': "application/json",
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
      };

      var request = http.MultipartRequest("DELETE", url);
      request.headers.addAll(headers);
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("Response Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");

      if (response.statusCode == 200) {
        // final responseData = jsonDecode(responseBody);

        await Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.login,
          (route) => false,
        );

        await Preference.clear();
        // return responseData['status'];
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
        throw Exception('Profile update failed');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Profile update failed. Please try again.");
    }
  }
}
