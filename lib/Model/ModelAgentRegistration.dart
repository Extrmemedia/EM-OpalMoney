class ModelSaveAgentRegForm {
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
  String photo;
  String idproof;
  String usertype;
  String agentcode;
  String updatedAt;
  String createdAt;
  String orderId;
  int id;
  bool success;
  String message;

  ModelSaveAgentRegForm(
      {this.uid,this.orderId,
        this.name,
        this.mobile,
        this.email,
        this.dob,
        this.age,
        this.gender,
        this.occupation,
        this.address,
        this.pan,
        this.photo,
        this.idproof,
        this.usertype,
        this.agentcode,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelSaveAgentRegForm.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    orderId=json['orderid'];

    age = json['age'];
    gender = json['gender'];
    occupation = json['occupation'];
    address = json['address'];
    pan = json['pan'];
    photo = json['photo'];
    idproof = json['idproof'];
    usertype = json['usertype'];
    agentcode = json['agentcode'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    data['occupation'] = occupation;
    data['address'] = address;
    data['pan'] = pan;
    data['photo'] = photo;
    data['idproof'] = idproof;
    data['usertype'] = usertype;
    data['agentcode'] = agentcode;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['orderid']=orderId;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}