class ModelJobCategory {
  ModelJobCategory({
     this.success,
     this.message,
     this.data,
  });
   bool success;
   String message;
   List<JobCategory> data;

  ModelJobCategory.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>JobCategory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class JobCategory {
  JobCategory({
     this.id,
     this.jobtypes,
     this.status,
     this.createdAt,
     this.updatedAt,
  });
    int id;
    String jobtypes;
    int status;
    String createdAt;
    String updatedAt;

  JobCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    jobtypes = json['jobtypes'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['jobtypes'] = jobtypes;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}