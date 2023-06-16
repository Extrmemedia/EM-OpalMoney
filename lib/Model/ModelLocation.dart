class ModelLocation {
  ModelLocation({
     this.success,
    this.message,
     this.data,
  });
  bool success;
   String message;
   List<LocationList> data;

  ModelLocation.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>LocationList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class LocationList {
  LocationList({
     this.id,
    this.location,
     this.createdAt,
     this.updatedAt,
  });
   int id;
   String location;
  String createdAt;
   String updatedAt;

  LocationList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['location'] = location;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}