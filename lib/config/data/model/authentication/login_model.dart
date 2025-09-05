// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? status;
    int? statusCode;
    String? statusMessage;
    String? message;
    Results? results;

    LoginResponseModel({
        this.status,
        this.statusCode,
        this.statusMessage,
        this.message,
        this.results,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        message: json["message"],
        results: json["results"] == null ? null : Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "status_message": statusMessage,
        "message": message,
        "results": results?.toJson(),
    };
}

class Results {
    String? id;
    String? name;
    String? email;
    String? mobileNumber;
    dynamic gstNumber;
    String? state;
    String? pinCode;
    String? city;
    String? tahsil;
    String? address;
    String? accessToken;
    dynamic profilePic;
    DateTime? createdAt;

    Results({
        this.id,
        this.name,
        this.email,
        this.mobileNumber,
        this.gstNumber,
        this.state,
        this.pinCode,
        this.city,
        this.tahsil,
        this.address,
        this.accessToken,
        this.profilePic,
        this.createdAt,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        gstNumber: json["gst_number"],
        state: json["state"],
        pinCode: json["pin_code"],
        city: json["city"],
        tahsil: json["tahsil"],
        address: json["address"],
        accessToken: json["access_token"],
        profilePic: json["profile_pic"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile_number": mobileNumber,
        "gst_number": gstNumber,
        "state": state,
        "pin_code": pinCode,
        "city": city,
        "tahsil": tahsil,
        "address": address,
        "access_token": accessToken,
        "profile_pic": profilePic,
        "created_at": createdAt?.toIso8601String(),
    };
}
