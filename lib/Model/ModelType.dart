class ModelType {
  ModelType({
    this.success,
   this.message,
  this.data,
  });
  bool success;
   String message;
   List<Type> data;

  ModelType.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Type.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Type {
  Type({
    this.id,
    this.type,
     this.createdAt,
    this.updatedAt,
  });
  int id;
   String type;
   String createdAt;
   String updatedAt;

  Type.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}