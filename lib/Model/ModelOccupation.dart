class ModelOccupation {
  ModelOccupation({
     this.success,
     this.message,
    this.data,
  });
   bool success;
   String message;
  List<Occupation> data;

  ModelOccupation.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Occupation.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Occupation {
  Occupation({
     this.id,
     this.occupation,
   this.createdAt,
    this.updatedAt,
  });
   int id;
   String occupation;
   String createdAt;
   String updatedAt;

  Occupation.fromJson(Map<String, dynamic> json){
    id = json['id'];
    occupation = json['occupation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['occupation'] = occupation;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}