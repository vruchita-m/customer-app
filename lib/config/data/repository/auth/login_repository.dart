import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';
import '../../../constant/api/apis.dart';
import '../../../constant/utils.dart';
import '../../model/authentication/login_model.dart';

class LoginRepository {
  LoginRepository();

  Future<LoginResponseModel> loginCustomer(
      {required String email,
      required String password,
      required String firebaseToken,
      required BuildContext context}) async {
    final url = Uri.parse(AppConstants.loginUrl);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'accept': "application/json",
      'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
    };
    final body = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'scope': '',
      'client_id': '',
      'client_secret': '',
      'firebase_token': firebaseToken,
    };

    debugPrint("Request URL: $url");
    debugPrint("Request Body: $body");
    debugPrint("Request Headers: $headers");

    try {
      final response = await http.post(url, headers: headers, body: body);
      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        var data = LoginResponseModel.fromJson(responseData);

        return data;
      } else {
        await ApiUtils.manageException(response, context);
        throw Exception('Login failed');
      }
    } catch (e) {
      debugPrint("Error: $e");

      await ApiUtils.manageException(e as http.Response, context);
      throw Exception("Login failed. Please try again.");
    }
  }
}
