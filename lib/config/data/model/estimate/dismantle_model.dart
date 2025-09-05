
class DismantleModel {
    String? status;
    int? statusCode;
    String? statusMessage;
    String? message;
    List<DismantleResults>? results;

    DismantleModel({this.status, this.statusCode, this.statusMessage, this.message, this.results});

    DismantleModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        statusCode = json["status_code"];
        statusMessage = json["status_message"];
        message = json["message"];
        results = json["results"] == null ? null : (json["results"] as List).map((e) => DismantleResults.fromJson(e)).toList();
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

class DismantleResults {
    DismantleCategories? category;
    List<DismantleParts>? dismantleParts;

    DismantleResults({this.category, this.dismantleParts});

    DismantleResults.fromJson(Map<String, dynamic> json) {
        category = json["category"] == null ? null : DismantleCategories.fromJson(json["category"]);
        dismantleParts = json["dismantle_parts"] == null ? null : (json["dismantle_parts"] as List).map((e) => DismantleParts.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(category != null) {
            _data["category"] = category?.toJson();
        }
        if(dismantleParts != null) {
            _data["dismantle_parts"] = dismantleParts?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class DismantleParts {
    String? id;
    String? partId;
    String? reasonforfailure;
    List<String>? selectedImages;
    String? ticketId;
    DismantlePart? part;

    DismantleParts({this.id, this.partId, this.reasonforfailure, this.selectedImages, this.ticketId, this.part});

    DismantleParts.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        partId = json["part_id"];
        reasonforfailure = json["reasonforfailure"];
        selectedImages = json["selected_images"] == null ? null : List<String>.from(json["selected_images"]);
        ticketId = json["ticket_id"];
        part = json["part"] == null ? null : DismantlePart.fromJson(json["part"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["part_id"] = partId;
        _data["reasonforfailure"] = reasonforfailure;
        if(selectedImages != null) {
            _data["selected_images"] = selectedImages;
        }
        _data["ticket_id"] = ticketId;
        if(part != null) {
            _data["part"] = part?.toJson();
        }
        return _data;
    }
}

class DismantlePart {
    String? id;
    String? name;
    dynamic image;
    DismantleCategories? category;

    DismantlePart({this.id, this.name, this.image, this.category});

    DismantlePart.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        image = json["image"];
        category = json["category"] == null ? null : DismantleCategories.fromJson(json["category"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["image"] = image;
        if(category != null) {
            _data["category"] = category?.toJson();
        }
        return _data;
    }
}



class DismantleCategories {
    String? id;
    String? name;
    dynamic image;

    DismantleCategories({this.id, this.name, this.image});

    DismantleCategories.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["image"] = image;
        return _data;
    }
}