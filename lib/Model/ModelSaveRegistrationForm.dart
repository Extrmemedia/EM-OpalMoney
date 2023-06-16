class ModelSaveRegistrationForm {
  String uid;
  String name;
  String mobile;
  String email;
  String dob;
  String age;
  String gender;
  String occupation;
  String address;
  String pan;
  String idproof;
  String photo;
  String usertype;
  String updatedAt;
  String createdAt;
  String orderId;

  int id;
  bool success;
  String message;

  ModelSaveRegistrationForm(
      {this.uid,
        this.name,
        this.mobile,
        this.email,
        this.dob,
        this.age,
        this.gender,
        this.occupation,
        this.address,
        this.pan,
        this.idproof,
        this.photo,
        this.usertype,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message,this.orderId});

  ModelSaveRegistrationForm.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    occupation = json['occupation'];
    address = json['address'];
    pan = json['pan'];
    idproof = json['idproof'];
    photo = json['photo'];
    usertype = json['usertype'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
    orderId=json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['orderid']=this.orderId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['address'] = this.address;
    data['pan'] = this.pan;
    data['idproof'] = this.idproof;
    data['photo'] = this.photo;
    data['usertype'] = this.usertype;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}