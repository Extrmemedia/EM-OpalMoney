class Data {
  int id;
  int userid;
  String customer;
  int mobile;
  int amount;
  String date;
  String time;
  int status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.userid,
        this.customer,
        this.mobile,
        this.amount,
        this.date,
        this.time,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    customer = json['customer'];
    mobile = json['mobile'];
    amount = json['amount'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['customer'] = customer;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}