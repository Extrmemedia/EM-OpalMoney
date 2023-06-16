class ModelLogin {
  int userid;
  String contact;
  String otp;
  String agent;
  String status;
  String message;

  ModelLogin(
      {this.userid,
        this.contact,
        this.otp,
        this.agent,
        this.status,
        this.message});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    contact = json['contact'];
    otp = json['otp'];
    agent = json['agent'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['contact'] = this.contact;
    data['otp'] = this.otp;
    data['agent'] = this.agent;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}