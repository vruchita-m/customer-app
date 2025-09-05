class NotificationModal {
  String? status;
  int? statusCode;
  String? statusMessage;
  String? message;
  List<NotificationResults>? results;

  NotificationModal({this.status, this.statusCode, this.statusMessage, this.message, this.results});

  NotificationModal.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusCode = (json["status_code"] as num).toInt();
    statusMessage = json["status_message"];
    message = json["message"];

    if (json["results"] != null && json["results"] is List) {
      results = (json["results"] as List)
          .map((item) => NotificationResults.fromJson(item))
          .toList();
    } else {
      results = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["status_code"] = statusCode;
    _data["status_message"] = statusMessage;
    _data["message"] = message;
    if (results != null) {
      _data["results"] = results!.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class NotificationResults {
  String? id;
  String? userId;
  String? notificationtitle;
  String? notificationbody;
  String? ticketId;
  bool? seen;
  String? createdAt;

  NotificationResults({this.id, this.userId, this.notificationtitle, this.notificationbody, this.seen, this.createdAt, this.ticketId});

  NotificationResults.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    notificationtitle = json["notificationtitle"];
    notificationbody = json["notificationbody"];
    ticketId = json["ticket_id"];
    seen = json["seen"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["notificationtitle"] = notificationtitle;
    _data["notificationbody"] = notificationbody;
    _data["seen"] = seen;
    _data["ticket_id"] = ticketId;
    _data["created_at"] = createdAt;
    return _data;
  }
}
