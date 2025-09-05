import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/constant/api/apis.dart';
import 'package:service_mitra/config/constant/utils.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

class FeedbackRepository {
  FeedbackRepository();

  Future<bool> sendFeedback({
    required BuildContext context,
    required num rate,
    required String review,
    required String ticketId,
  }) async {
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

      request.fields['rating'] = rate.toString();
      request.fields['review'] = review;

      debugPrint("url : ${request.url}");
      debugPrint("fields : ${request.fields}");

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
