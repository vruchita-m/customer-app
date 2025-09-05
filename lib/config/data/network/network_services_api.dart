import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:service_mitra/config/share_preferences/preferences.dart';

import '../exceptions/app_exceptions.dart';
import 'base_api_services.dart';

class NetwrokServicesApi implements BaseApiServices {
  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      jsonResponse = returnResponse(jsonResponse);
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 50));
      if (response.statusCode == 401) {
        Preference.clear();
      }
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future deleteApi(String url) async {
    dynamic jsonResponse;
    try {
      jsonResponse = returnResponse(jsonResponse);
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future postApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      jsonResponse = returnResponse(jsonResponse);
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 50));
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future putApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      jsonResponse = returnResponse(jsonResponse);
      final response = await http
          .put(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 50));
      if (response.statusCode == 200) {}
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response) {
    case 200:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    case 400:
      dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    case 401:
      throw UnauthorizedException();
    case 500:
      throw FetchDataException(
          'Error communicating with server${response.statusCode}');
    default:
      throw UnauthorizedException();
  }
}
