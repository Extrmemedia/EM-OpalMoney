class TrAcDetails {
  int id;
  String details;
  String image;
  int status;
  String createdAt;
  String updatedAt;

  TrAcDetails(
      {this.id,
        this.details,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  TrAcDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['details'] = details;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}