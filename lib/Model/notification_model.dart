
class Notifications {
  int id;
  String heading;
  String description;
  String date;
  String time;
  int status;
  String createdAt;
  String updatedAt;

  Notifications(
      {this.id,
        this.heading,
        this.description,
        this.date,
        this.time,
        this.status,
        this.createdAt,
        this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['heading'] = heading;
    data['description'] = description;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}