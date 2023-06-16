class ModelSaveTradingAccount{
  String uid;
  String name;
  String mobile;
  String email;
  String dob;
  String age;
  String gender;
  String address;
  String nameMother;
  String pan;
  String adhaar;
  String photo;
  String checque;
  String sign;
  String bankStmt;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelSaveTradingAccount(
      {this.uid,
        this.name,
        this.mobile,
        this.email,
        this.dob,
        this.age,
        this.gender,
        this.address,
        this.nameMother,
        this.pan,
        this.adhaar,
        this.photo,
        this.checque,
        this.sign,
        this.bankStmt,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelSaveTradingAccount.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    nameMother = json['name_mother'];
    pan = json['pan'];
    adhaar = json['adhaar'];
    photo = json['photo'];
    checque = json['checque'];
    sign = json['sign'];
    bankStmt = json['bank_stmt'];
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
    data['email'] = email;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    data['address'] = address;
    data['name_mother'] = nameMother;
    data['pan'] = pan;
    data['adhaar'] = adhaar;
    data['photo'] = photo;
    data['checque'] = checque;
    data['sign'] = sign;
    data['bank_stmt'] = bankStmt;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}