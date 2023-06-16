class ModelBuyingEnquiry {
  ModelBuyingEnquiry({
     this.status,
     this.message,
     this.details,
  });
    String status;
    String message;
    Details details;

  ModelBuyingEnquiry.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    details = Details.fromJson(json['details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['details'] = details.toJson();
    return _data;
  }
}

class Details {
  Details({
     this.uid,
     this.type,
     this.expRate,
     this.district,
     this.location,
     this.description,
     this.date,
     this.time,
     this.updatedAt,
     this.createdAt,
     this.id,
  });
    String uid;
    String type;
    String expRate;
    String district;
    String location;
    String description;
    String date;
    String time;
    String updatedAt;
    String createdAt;
    int id;

  Details.fromJson(Map<String, dynamic> json){
    uid = json['uid'];
    type = json['type'];
    expRate = json['exp_rate'];
    district = json['district'];
    location = json['location'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['type'] = type;
    _data['exp_rate'] = expRate;
    _data['district'] = district;
    _data['location'] = location;
    _data['description'] = description;
    _data['date'] = date;
    _data['time'] = time;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    return _data;
  }
}