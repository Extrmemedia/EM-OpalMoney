class ModelSelling {
  String uid;
  String type;
  String expectedRate;
  String rateType;
  String areaType;
  String areaMessure;
  String district;
  String location;
  String description;
  String image1;
  String image2;
  String image3;
  String image4;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelSelling(
      {this.uid,
        this.type,
        this.expectedRate,
        this.rateType,
        this.areaType,
        this.areaMessure,
        this.district,
        this.location,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelSelling.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    type = json['type'];
    expectedRate = json['expected_rate'];
    rateType = json['rate_type'];
    areaType = json['area_type'];
    areaMessure = json['area_messure'];
    district = json['district'];
    location = json['location'];
    description = json['description'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    image3 = json['image_3'];
    image4 = json['image_4'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['type'] = this.type;
    data['expected_rate'] = this.expectedRate;
    data['rate_type'] = this.rateType;
    data['area_type'] = this.areaType;
    data['area_messure'] = this.areaMessure;
    data['district'] = this.district;
    data['location'] = this.location;
    data['description'] = this.description;
    data['image_1'] = this.image1;
    data['image_2'] = this.image2;
    data['image_3'] = this.image3;
    data['image_4'] = this.image4;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}