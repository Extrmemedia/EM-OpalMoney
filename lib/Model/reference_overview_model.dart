class Overview {
  int id;
  int userid;
  String type;
  int applTblid;
  String applStatus;
  int groupId;
  String name;
  int contact;
  int amount;
  String date;
  String time;
  int status;
  String createdAt;
  String updatedAt;

  Overview(
      {this.id,
        this.userid,
        this.type,
        this.applTblid,
        this.applStatus,
        this.groupId,
        this.name,
        this.contact,
        this.amount,
        this.date,
        this.time,
        this.status,
        this.createdAt,
        this.updatedAt});

  Overview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    type = json['type'];
    applTblid = json['appl_tblid'];
    applStatus = json['appl_status'];
    groupId = json['group_id'];
    name = json['name'];
    contact = json['contact'];
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
    data['type'] = type;
    data['appl_tblid'] = applTblid;
    data['appl_status'] = applStatus;
    data['group_id'] = groupId;
    data['name'] = name;
    data['contact'] = contact;
    data['amount'] = amount;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}