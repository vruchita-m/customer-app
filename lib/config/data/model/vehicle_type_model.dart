class VehicleTypesModel {
    String? status;
    int? statusCode;
    String? statusMessage;
    String? message;
    List<Results>? results;

    VehicleTypesModel({this.status, this.statusCode, this.statusMessage, this.message, this.results});

    VehicleTypesModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        statusCode = json["status_code"];
        statusMessage = json["status_message"];
        message = json["message"];
        results = json["results"] == null ? null : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["status"] = status;
        _data["status_code"] = statusCode;
        _data["status_message"] = statusMessage;
        _data["message"] = message;
        if(results != null) {
            _data["results"] = results?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Results {
    String? id;
    String? name;
    String? createdAt;

    Results({this.id, this.name, this.createdAt});

    Results.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        createdAt = json["created_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["created_at"] = createdAt;
        return _data;
    }
}