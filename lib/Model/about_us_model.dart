class AboutusModel {
  int id;
  String details;
  int staus;
  String createdAt;
  String updatedAt;

  AboutusModel({this.id, this.details, this.staus, this.createdAt, this.updatedAt});

  AboutusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    staus = json['staus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['details'] = details;
    data['staus'] = staus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}