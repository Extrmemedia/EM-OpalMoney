class MyBusiness {
  int id;
  int uid;
  String category;
  String businessStatus;
  String regDate;
  String amount;
  String rejectionreasonhere;
  int status;
  String createdAt;
  String updatedAt;

  MyBusiness(
      {this.id,
        this.uid,
        this.category,
        this.businessStatus,
        this.regDate,
        this.amount,
        this.rejectionreasonhere,
        this.status,
        this.createdAt,
        this.updatedAt});

  MyBusiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    category = json['category'];
    businessStatus = json['business_status'];
    regDate = json['reg_date'];
    amount = json['amount'];
    rejectionreasonhere = json['rejectionreasonhere'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['category'] = category;
    data['business_status'] = businessStatus;
    data['reg_date'] = regDate;
    data['amount'] = amount;
    data['rejectionreasonhere'] = rejectionreasonhere;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}