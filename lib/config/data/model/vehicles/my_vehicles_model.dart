class MyVehiclesModel {
    List<MyVehiclesResults>? results;
    int? currentPage;
    int? pageSize;
    int? totalItems;
    int? totalPages;

    MyVehiclesModel({this.results, this.currentPage, this.pageSize, this.totalItems, this.totalPages});

    MyVehiclesModel.fromJson(Map<String, dynamic> json) {
        results = json["results"] == null ? null : (json["results"] as List).map((e) => MyVehiclesResults.fromJson(e)).toList();
        currentPage = json["current_page"];
        pageSize = json["page_size"];
        totalItems = json["total_items"];
        totalPages = json["total_pages"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(results != null) {
            _data["results"] = results?.map((e) => e.toJson()).toList();
        }
        _data["current_page"] = currentPage;
        _data["page_size"] = pageSize;
        _data["total_items"] = totalItems;
        _data["total_pages"] = totalPages;
        return _data;
    }
}

class MyVehiclesResults {
    String? id;
    String? userId;
    String? vehicleNumber;
    String? chassisNumber;
    String? rcNumber;
    String? make;
    String? emissionNorm;
    String? fuelType;
    String? category;
    String? model;
    int? year;
    int? numberOfTyres;
    String? kmReading;
    String? vehiclePic;

    MyVehiclesResults({this.id, this.userId, this.vehicleNumber, this.chassisNumber, this.rcNumber, this.make, this.emissionNorm, this.fuelType, this.category, this.model, this.year, this.numberOfTyres, this.kmReading, this.vehiclePic});

    MyVehiclesResults.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        userId = json["user_id"];
        vehicleNumber = json["vehicle_number"];
        chassisNumber = json["chassis_number"];
        rcNumber = json["rc_number"];
        make = json["make"];
        emissionNorm = json["emission_norm"];
        fuelType = json["fuel_type"];
        category = json["category"];
        model = json["model"];
        year = json["year"];
        numberOfTyres = json["number_of_tyres"];
        kmReading = json["km_reading"];
        vehiclePic = json["vehicle_pic"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["user_id"] = userId;
        _data["vehicle_number"] = vehicleNumber;
        _data["chassis_number"] = chassisNumber;
        _data["rc_number"] = rcNumber;
        _data["make"] = make;
        _data["emission_norm"] = emissionNorm;
        _data["fuel_type"] = fuelType;
        _data["category"] = category;
        _data["model"] = model;
        _data["year"] = year;
        _data["number_of_tyres"] = numberOfTyres;
        _data["km_reading"] = kmReading;
        _data["vehicle_pic"] = vehiclePic;
        return _data;
    }
}