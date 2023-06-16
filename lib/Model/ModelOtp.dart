class ModelOtp {
  ModelOtp({
    this.status,
   this.message,
   this.user,
  this.token,
   this.tokenType,
  });
   dynamic status;
 String message;
   User user;
   String token;
  String tokenType;

  ModelOtp.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    user = User.fromJson(json['user']);
    token = json['token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['user'] = user.toJson();
    _data['token'] = token;
    _data['token_type'] = tokenType;
    return _data;
  }
}

class User {
  User({
     this.id,
     this.name,
    this.email,
    this.phno,
     this.otp,
    this.emailVerifiedAt,
    this.resetToken,
   this.tokenStatus,
    this.createdAt,
     this.updatedAt,
  });
   int id;
   String name;
   String email;
   String phno;
   String otp;
  String emailVerifiedAt;
  String resetToken;
  String tokenStatus;
   String createdAt;
   String updatedAt;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phno = json['phno'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    resetToken = json['reset_token'];
    tokenStatus = json['token_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phno'] = phno;
    _data['otp'] = otp;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['reset_token'] = resetToken;
    _data['token_status'] = tokenStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}