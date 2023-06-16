class ModelMatrimony {
  String uid;
  String name;
  String mobile;
  String emailid;
  String dob;
  String tob;
  String star;
  String religion;
  String gender;
  String height;
  String education;
  String job;
  String nameFather;
  String occupation;
  String nameMother;
  String addr;
  String whatsapp;
  String workAddress;
  String photo;
  String grihanila;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelMatrimony(
      {this.uid,
        this.name,
        this.mobile,
        this.emailid,
        this.dob,
        this.tob,
        this.star,
        this.religion,
        this.gender,
        this.height,
        this.education,
        this.job,
        this.nameFather,
        this.occupation,
        this.nameMother,
        this.addr,
        this.whatsapp,
        this.workAddress,
        this.photo,
        this.grihanila,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelMatrimony.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    mobile = json['mobile'];
    emailid = json['emailid'];
    dob = json['dob'];
    tob = json['tob'];
    star = json['star'];
    religion = json['religion'];
    gender = json['gender'];
    height = json['height'];
    education = json['education'];
    job = json['job'];
    nameFather = json['name_father'];
    occupation = json['occupation'];
    nameMother = json['name_mother'];
    addr = json['addr'];
    whatsapp = json['whatsapp'];
    workAddress = json['work_address'];
    photo = json['photo'];
    grihanila = json['grihanila'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['mobile'] = mobile;
    data['emailid'] = emailid;
    data['dob'] = dob;
    data['tob'] = tob;
    data['star'] = star;
    data['religion'] = religion;
    data['gender'] = gender;
    data['height'] = height;
    data['education'] = education;
    data['job'] = job;
    data['name_father'] = nameFather;
    data['occupation'] = occupation;
    data['name_mother'] = nameMother;
    data['addr'] = addr;
    data['whatsapp'] = whatsapp;
    data['work_address'] = workAddress;
    data['photo'] = photo;
    data['grihanila'] = grihanila;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}