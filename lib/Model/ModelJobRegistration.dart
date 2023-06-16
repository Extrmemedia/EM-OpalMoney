class ModelJobRegistration {
  String uid;
  String regType;
  String name;
  String mobile;
  String emailid;
  String dob;
  String height;
  String gender;
  String qualification;
  String experience;
  String nameFather;
  String occupation;
  String nameMother;
  String jobType;
  String jobCat;
  String jobLocation;
  String expSalary;
  String photo;
  String resume;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelJobRegistration(
      {this.uid,
        this.regType,
        this.name,
        this.mobile,
        this.emailid,
        this.dob,
        this.height,
        this.gender,
        this.qualification,
        this.experience,
        this.nameFather,
        this.occupation,
        this.nameMother,
        this.jobType,
        this.jobCat,
        this.jobLocation,
        this.expSalary,
        this.photo,
        this.resume,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelJobRegistration.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    regType = json['reg_type'];
    name = json['name'];
    mobile = json['mobile'];
    emailid = json['emailid'];
    dob = json['dob'];
    height = json['height'];
    gender = json['gender'];
    qualification = json['qualification'];
    experience = json['experience'];
    nameFather = json['name_father'];
    occupation = json['occupation'];
    nameMother = json['name_mother'];
    jobType = json['job_type'];
    jobCat = json['job_cat'];
    jobLocation = json['job_location'];
    expSalary = json['exp_salary'];
    photo = json['photo'];
    resume = json['resume'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['reg_type'] = regType;
    data['name'] = name;
    data['mobile'] = mobile;
    data['emailid'] = emailid;
    data['dob'] = dob;
    data['height'] = height;
    data['gender'] = gender;
    data['qualification'] = qualification;
    data['experience'] = experience;
    data['name_father'] = nameFather;
    data['occupation'] = occupation;
    data['name_mother'] = nameMother;
    data['job_type'] = jobType;
    data['job_cat'] = jobCat;
    data['job_location'] = jobLocation;
    data['exp_salary'] = expSalary;
    data['photo'] = photo;
    data['resume'] = resume;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}