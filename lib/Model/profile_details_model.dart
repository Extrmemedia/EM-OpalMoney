

class ProfileDetails {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phno;
  dynamic otp;
  dynamic emailVerifiedAt;
  dynamic resetToken;
  dynamic tokenStatus;
  dynamic status;
  dynamic type;
  dynamic dob;
  dynamic age;
  dynamic gender;
  dynamic occupation;
  dynamic address;
  dynamic usertype;
  dynamic profileimage;
  dynamic pan;
  dynamic aadhaar;
  dynamic passportphoto;
  dynamic mycode;
  dynamic createdAt;
  dynamic updatedAt;

  ProfileDetails(
      {this.id,
        this.name,
        this.email,
        this.phno,
        this.otp,
        this.emailVerifiedAt,
        this.resetToken,
        this.tokenStatus,
        this.status,
        this.type,
        this.dob,
        this.age,
        this.gender,
        this.occupation,
        this.address,
        this.usertype,
        this.profileimage,
        this.pan,
        this.aadhaar,
        this.passportphoto,
        this.mycode,
        this.createdAt,
        this.updatedAt});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phno = json['phno'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    resetToken = json['reset_token'];
    tokenStatus = json['token_status'];
    status = json['status'];
    type = json['type'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    occupation = json['occupation'];
    address = json['address'];
    usertype = json['usertype'];
    profileimage = json['profileimage'];
    pan = json['pan'];
    aadhaar = json['aadhaar'];
    passportphoto = json['passportphoto'];
    mycode = json['mycode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phno'] = phno;
    data['otp'] = otp;
    data['email_verified_at'] = emailVerifiedAt;
    data['reset_token'] = resetToken;
    data['token_status'] = tokenStatus;
    data['status'] = status;
    data['type'] = type;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    data['occupation'] = occupation;
    data['address'] = address;
    data['usertype'] = usertype;
    data['profileimage'] = profileimage;
    data['pan'] = pan;
    data['aadhaar'] = aadhaar;
    data['passportphoto'] = passportphoto;
    data['mycode'] = mycode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
