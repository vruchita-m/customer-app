// To parse this JSON data, do
//
//     final estimationModel = estimationModelFromJson(jsonString);

import 'dart:convert';

EstimationModel estimationModelFromJson(String str) => EstimationModel.fromJson(json.decode(str));

String estimationModelToJson(EstimationModel data) => json.encode(data.toJson());

class EstimationModel {
    int? page;
    int? size;
    int? totalCount;
    List<Result>? results;

    EstimationModel({
        this.page,
        this.size,
        this.totalCount,
        this.results,
    });

    factory EstimationModel.fromJson(Map<String, dynamic> json) => EstimationModel(
        page: json["page"],
        size: json["size"],
        totalCount: json["total_count"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "total_count": totalCount,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    String? id;
    DateTime? createdAt;
    String? ticketId;
    String? deputationhour;
    String? price;
    String? gst;
    String? totalprice;
    Deputation? deputation;
    List<CategoryElement>? categories;

    Result({
        this.id,
        this.createdAt,
        this.ticketId,
        this.deputationhour,
        this.price,
        this.gst,
        this.totalprice,
        this.deputation,
        this.categories,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        ticketId: json["ticket_id"],
        deputationhour: json["deputationhour"],
        price: json["price"],
        gst: json["gst"],
        totalprice: json["totalprice"],
        deputation: json["deputation"] == null ? null : Deputation.fromJson(json["deputation"]),
        categories: json["categories"] == null ? [] : List<CategoryElement>.from(json["categories"]!.map((x) => CategoryElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "ticket_id": ticketId,
        "deputationhour": deputationhour,
        "price": price,
        "gst": gst,
        "totalprice": totalprice,
        "deputation": deputation?.toJson(),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class CategoryElement {
    CategoryCategory? category;
    List<Part>? parts;

    CategoryElement({
        this.category,
        this.parts,
    });

    factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
        category: json["category"] == null ? null : CategoryCategory.fromJson(json["category"]),
        parts: json["parts"] == null ? [] : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "parts": parts == null ? [] : List<dynamic>.from(parts!.map((x) => x.toJson())),
    };
}

class CategoryCategory {
    String? id;
    String? name;
    dynamic categoryPic;
    DateTime? createdAt;

    CategoryCategory({
        this.id,
        this.name,
        this.categoryPic,
        this.createdAt,
    });

    factory CategoryCategory.fromJson(Map<String, dynamic> json) => CategoryCategory(
        id: json["id"],
        name: json["name"],
        categoryPic: json["category_pic"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_pic": categoryPic,
        "created_at": createdAt?.toIso8601String(),
    };
}

class Part {
    String? id;
    String? name;
    double? price;
    double? rottime;
    double? totalprice;
    CategoryCategory? category;

    Part({
        this.id,
        this.name,
        this.price,
        this.rottime,
        this.totalprice,
        this.category,
    });

    factory Part.fromJson(Map<String, dynamic> json) => Part(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        rottime: json["rottime"],
        totalprice: json["totalprice"],
        category: json["category"] == null ? null : CategoryCategory.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "rottime": rottime,
        "totalprice": totalprice,
        "category": category?.toJson(),
    };
}

class Deputation {
    String? id;
    String? vehicleType;
    double? ratePerKm;
    DateTime? createdAt;

    Deputation({
        this.id,
        this.vehicleType,
        this.ratePerKm,
        this.createdAt,
    });

    factory Deputation.fromJson(Map<String, dynamic> json) => Deputation(
        id: json["id"],
        vehicleType: json["vehicle_type"],
        ratePerKm: json["rate_per_km"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_type": vehicleType,
        "rate_per_km": ratePerKm,
        "created_at": createdAt?.toIso8601String(),
    };
}
