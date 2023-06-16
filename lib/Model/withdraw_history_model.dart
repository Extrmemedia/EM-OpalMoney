class History {
  int id;
  int userid;
  int amount;
  String date;
  String time;
  int status;
  String createdAt;
  String updatedAt;

  History(
      {this.id,
        this.userid,
        this.amount,
        this.date,
        this.time,
        this.status,
        this.createdAt,
        this.updatedAt});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
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
    data['amount'] = amount;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}