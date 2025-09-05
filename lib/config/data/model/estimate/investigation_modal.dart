
class VehicleInvestigationModal {
  List<InvestigatioResults>? results;
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;

  VehicleInvestigationModal({this.results, this.currentPage, this.pageSize, this.totalItems, this.totalPages});

  VehicleInvestigationModal.fromJson(Map<String, dynamic> json) {
    results = json["results"] == null ? null : (json["results"] as List).map((e) => InvestigatioResults.fromJson(e)).toList();
    currentPage = (json["current_page"] as num).toInt();
    pageSize = (json["page_size"] as num).toInt();
    totalItems = (json["total_items"] as num).toInt();
    totalPages = (json["total_pages"] as num).toInt();
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

class InvestigatioResults {
  String? id;
  String? vehicleFrontImage;
  String? kilometerImage;
  String? chassisNoImage;
  
  InvestigatioResults({this.id, this.vehicleFrontImage, this.kilometerImage, this.chassisNoImage});

  InvestigatioResults.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    vehicleFrontImage = json["vehicle_front_image"];
    kilometerImage = json["kilometer_image"];
    chassisNoImage = json["chassis_no_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["vehicle_front_image"] = vehicleFrontImage;
    _data["kilometer_image"] = kilometerImage;
    _data["chassis_no_image"] = chassisNoImage;
    return _data;
  }
}

