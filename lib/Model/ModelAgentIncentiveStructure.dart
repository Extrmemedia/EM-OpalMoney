class ModelAgententiveStructure {
  int id;
  String details;
  int staus;
  Null createdAt;
  String updatedAt;

  ModelAgententiveStructure({this.id, this.details, this.staus, this.createdAt, this.updatedAt});

  ModelAgententiveStructure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    staus = json['staus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['staus'] = this.staus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}