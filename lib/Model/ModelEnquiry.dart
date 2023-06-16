class ModelEnquiry {
  int group;
  String catId;
  String subcatId;
  String planId;
  String name;
  String mobile;
  String email;
  String dob;
  String age;
  String address;
  String occupation;
  String description;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelEnquiry(
      {this.group,
        this.catId,
        this.subcatId,
        this.planId,
        this.name,
        this.mobile,
        this.email,
        this.dob,
        this.age,
        this.address,
        this.occupation,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelEnquiry.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    planId = json['plan_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    address = json['address'];
    occupation = json['occupation'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['cat_id'] = catId;
    data['subcat_id'] = subcatId;
    data['plan_id'] = planId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['dob'] = dob;
    data['age'] = age;
    data['address'] = address;
    data['occupation'] = occupation;
    data['description'] = description;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

