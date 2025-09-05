class TicketsModel {
  List<TicketsResults>? results;
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;

  TicketsModel(
      {this.results,
      this.currentPage,
      this.pageSize,
      this.totalItems,
      this.totalPages});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    results = json["results"] == null
        ? null
        : (json["results"] as List)
            .map((e) => TicketsResults.fromJson(e))
            .toList();
    currentPage = json["current_page"];
    pageSize = json["page_size"];
    totalItems = json["total_items"];
    totalPages = json["total_pages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    data["current_page"] = currentPage;
    data["page_size"] = pageSize;
    data["total_items"] = totalItems;
    data["total_pages"] = totalPages;
    return data;
  }
}

class TicketsResults {
  String? id;
  Vehicle? vehicle;
  Customer? customer;
  Mechanic? mechanic;
  String? issue;
  String? location;
  String? vehicleProblem;
  String? driverName;
  String? driverNo;
  String? complaintNo;
  String? createdAt;
  String? callerName;
  String? status;
  dynamic pic1;
  dynamic pic2;
  dynamic pic3;
  dynamic pic4;
  dynamic pic5;
  dynamic pic6;
  dynamic rejectionreasonmechanic;
  dynamic rejectionreasoncustomer;
  String? lat;
  String? long;
  double? rating;
  String? review;
  String? imagewithcustomer;

  TicketsResults(
      {this.id,
      this.vehicle,
      this.customer,
      this.mechanic,
      this.issue,
      this.location,
      this.vehicleProblem,
      this.driverName,
      this.driverNo,
      this.complaintNo,
      this.createdAt,
      this.callerName,
      this.status,
      this.pic1,
      this.pic2,
      this.pic3,
      this.pic4,
      this.pic5,
      this.pic6,
      this.rejectionreasonmechanic,
      this.rejectionreasoncustomer,
      this.lat,
      this.long,
      this.rating,
      this.review,
      this.imagewithcustomer});

  TicketsResults.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    vehicle =
        json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]);
    customer =
        json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    mechanic =
        json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]);
    issue = json["issue"];
    location = json["location"];
    vehicleProblem = json["vehicle_problem"];
    driverName = json["driver_name"];
    driverNo = json["driver_no"];
    complaintNo = json["complaint_no"];
    createdAt = json["created_at"];
    callerName = json["caller_name"];
    status = json["status"];
    pic1 = json["pic1"];
    pic2 = json["pic2"];
    pic3 = json["pic3"];
    pic4 = json["pic4"];
    pic5 = json["pic5"];
    pic6 = json["pic6"];
    rejectionreasonmechanic = json["rejectionreasonmechanic"];
    rejectionreasoncustomer = json["rejectionreasoncustomer"];
    lat = json["lat"];
    long = json["long"];
    rating = json['rating'] != null
        ? double.tryParse(json['rating'].toString())
        : null;
    review = json["review"];
    imagewithcustomer = json["imagewithcustomer"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (vehicle != null) {
      data["vehicle"] = vehicle?.toJson();
    }
    if (customer != null) {
      data["customer"] = customer?.toJson();
    }
    if (mechanic != null) {
      data["mechanic"] = mechanic?.toJson();
    }
    data["issue"] = issue;
    data["location"] = location;
    data["vehicle_problem"] = vehicleProblem;
    data["driver_name"] = driverName;
    data["driver_no"] = driverNo;
    data["complaint_no"] = complaintNo;
    data["created_at"] = createdAt;
    data["caller_name"] = callerName;
    data["status"] = status;
    data["pic1"] = pic1;
    data["pic2"] = pic2;
    data["pic3"] = pic3;
    data["pic4"] = pic4;
    data["pic5"] = pic5;
    data["pic6"] = pic6;
    data["rejectionreasonmechanic"] = rejectionreasonmechanic;
    data["rejectionreasoncustomer"] = rejectionreasoncustomer;
    data["lat"] = lat;
    data["long"] = long;
    data['rating'] != null ? double.tryParse(['rating'].toString()) : null;
    data["review"];
    data["imagewithcustomer"] = imagewithcustomer;
    return data;
  }
}

class Mechanic {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? altMobileNumber;
  String? adharNumber;
  String? panNumber;
  String? dob;
  String? garageName;
  String? address;
  String? pinCode;
  String? city;
  String? tahsil;
  String? landmark;
  String? createdAt;

  Mechanic(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.altMobileNumber,
      this.adharNumber,
      this.panNumber,
      this.dob,
      this.garageName,
      this.address,
      this.pinCode,
      this.city,
      this.tahsil,
      this.landmark,
      this.createdAt});

  Mechanic.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    mobileNumber = json["mobile_number"];
    altMobileNumber = json["alt_mobile_number"];
    adharNumber = json["adhar_number"];
    panNumber = json["pan_number"];
    dob = json["dob"];
    garageName = json["garage_name"];
    address = json["address"];
    pinCode = json["pin_code"];
    city = json["city"];
    tahsil = json["tahsil"];
    landmark = json["landmark"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["mobile_number"] = mobileNumber;
    data["alt_mobile_number"] = altMobileNumber;
    data["adhar_number"] = adharNumber;
    data["pan_number"] = panNumber;
    data["dob"] = dob;
    data["garage_name"] = garageName;
    data["address"] = address;
    data["pin_code"] = pinCode;
    data["city"] = city;
    data["tahsil"] = tahsil;
    data["landmark"] = landmark;
    data["created_at"] = createdAt;
    return data;
  }
}

class Customer {
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
  String? createdAt;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.gstNumber,
      this.state,
      this.pinCode,
      this.city,
      this.tahsil,
      this.address,
      this.createdAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    mobileNumber = json["mobile_number"];
    gstNumber = json["gst_number"];
    state = json["state"];
    pinCode = json["pin_code"];
    city = json["city"];
    tahsil = json["tahsil"];
    address = json["address"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["mobile_number"] = mobileNumber;
    data["gst_number"] = gstNumber;
    data["state"] = state;
    data["pin_code"] = pinCode;
    data["city"] = city;
    data["tahsil"] = tahsil;
    data["address"] = address;
    data["created_at"] = createdAt;
    return data;
  }
}

class Vehicle {
  String? id;
  String? userId;
  String? vehicleNumber;
  String? vehiclePic;
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

  Vehicle(
      {this.id,
      this.userId,
      this.vehiclePic,
      this.vehicleNumber,
      this.chassisNumber,
      this.rcNumber,
      this.make,
      this.emissionNorm,
      this.fuelType,
      this.category,
      this.model,
      this.year,
      this.numberOfTyres,
      this.kmReading});

  Vehicle.fromJson(Map<String, dynamic> json) {
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
    vehiclePic = json["vehicle_pic"];
    year = json["year"];
    numberOfTyres = json["number_of_tyres"];
    kmReading = json["km_reading"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["vehicle_number"] = vehicleNumber;
    data["chassis_number"] = chassisNumber;
    data["rc_number"] = rcNumber;
    data["vehicle_pic"] = vehiclePic;
    data["make"] = make;
    data["emission_norm"] = emissionNorm;
    data["fuel_type"] = fuelType;
    data["category"] = category;
    data["model"] = model;
    data["year"] = year;
    data["number_of_tyres"] = numberOfTyres;
    data["km_reading"] = kmReading;
    return data;
  }
}
