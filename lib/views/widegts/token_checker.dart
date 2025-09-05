import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';
import 'package:service_mitra/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenChecker {
  final _cron = Cron();

  void checkMyToken() {
    log("Checking token in : ${Preference.getString(PrefKeys.token)}");
  }

  void startCron(BuildContext context) {
    _cron.schedule(Schedule.parse('*/20 * * * * *'), () async {
      print("🔄 Checking token... ");

      print("TOKEN Checking +++++++++${Preference.getString(PrefKeys.token)}");

      final isValid = await _checkToken();

      if (!isValid) {
        print("❌ Invalid token or account deleted");
        _cron.close();

        // final prefs = await SharedPreferences.getInstance();

        await navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RoutesName.login,
          (route) => false,
        );
        // await Preference.clear();

        // await Preference.preferences.remove(PrefKeys.token);

        TokenChecker().stop();

        // Get.offAllNamed(RoutesName.login); // Update to your actual login route
      }
    });
  }

  Future<bool> _checkToken() async {
    try {
      final token = Preference.getString(PrefKeys.token);
      print("TOKEN+++++++++${Preference.getString(PrefKeys.token)}");
      print("Email  +++++++++${Preference.getString(PrefKeys.email)}");

      if (token.isEmpty) return false;

      final url = Uri.parse(
          "http://3.7.171.161:4040/customer/check-token?token=$token");

      final response = await http.get(url);

      print("🔍 Token check status: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("❗ Token check error: $e");
      return false;
    }
  }

  void stop() {
    _cron.close();
  }
}
