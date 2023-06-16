class ModelSaveApplication {
  int group;
  String uid;
  String catId;
  String subcatId;
  String planId;
  String name;
  String mobile;
  String email;
  String dob;
  String age;
  String gender;
  String address;
  String occupation;
  String description;
  String nomineeName;
  String nomineeDob;
  String nomineeAge;
  String relationship;
  String pan;
  String idImage;
  String photo;
  String sign;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelSaveApplication(
      {this.group,
        this.uid,
        this.catId,
        this.subcatId,
        this.planId,
        this.name,
        this.mobile,
        this.email,
        this.dob,
        this.age,
        this.gender,
        this.address,
        this.occupation,
        this.description,
        this.nomineeName,
        this.nomineeDob,
        this.nomineeAge,
        this.relationship,
        this.pan,
        this.idImage,
        this.photo,
        this.sign,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelSaveApplication.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    uid = json['uid'];
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    planId = json['plan_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    occupation = json['occupation'];
    description = json['description'];
    nomineeName = json['nominee_name'];
    nomineeDob = json['nominee_dob'];
    nomineeAge = json['nominee_age'];
    relationship = json['relationship'];
    pan = json['pan'];
    idImage = json['id_image'];
    photo = json['photo'];
    sign = json['sign'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['uid'] = uid;
    data['cat_id'] = catId;
    data['subcat_id'] = subcatId;
    data['plan_id'] = planId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    data['address'] = address;
    data['occupation'] = occupation;
    data['description'] = description;
    data['nominee_name'] = nomineeName;
    data['nominee_dob'] = nomineeDob;
    data['nominee_age'] = nomineeAge;
    data['relationship'] = relationship;
    data['pan'] = pan;
    data['id_image'] = idImage;
    data['photo'] = photo;
    data['sign'] = sign;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}