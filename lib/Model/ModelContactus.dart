class ModelContactus {
  String name;
  String mobile;
  String email;
  String userid;
  String content;
  String success;
  String message;

  ModelContactus(
      {this.name,
        this.mobile,
        this.email,
        this.userid,
        this.content,
        this.success,
        this.message});

  ModelContactus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    userid = json['userid'];
    content = json['content'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['userid'] = this.userid;
    data['content'] = this.content;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}