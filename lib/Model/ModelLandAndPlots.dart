class ModelLandAndPlots{
  bool success;
  String message;
  List<Data> data;

  ModelLandAndPlots({this.success, this.message, this.data});

  ModelLandAndPlots.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String type;
  int expectedRate;
  String rateType;
  String areaType;
  int areaMessure;
  String district;
  String location;
  String description;
  String image1;
  String image2;
  String image3;
  String image4;

  Data(
      {this.id,
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
        this.image4});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['expected_rate'] = expectedRate;
    data['rate_type'] = rateType;
    data['area_type'] = areaType;
    data['area_messure'] = areaMessure;
    data['district'] = district;
    data['location'] = location;
    data['description'] = description;
    data['image_1'] = image1;
    data['image_2'] = image2;
    data['image_3'] = image3;
    data['image_4'] = image4;
    return data;
  }
}