class Plans {
  String id;
  int operatorId;
  int circleId;
  var planType;
  String planTab;
  String planCode;
  double amount;
  double talktime;
  String validity;
  String planName;
  String planDescription;
  String dataBenefit;
  int isPopular;
  int isPromoted;
  int isHidden;
  String stringTalktime;
  bool special;
  int validityInDays;
  List<String> languageRegion;
  List<String> type;
  int planTypeForWeb;
  List<PlanDetailItemList> planDetailItemList;
  List<int> planTypeList;
  int updatedOn;
  String specialTag;
  String specialTagBgColor;

  Plans(
      {this.id,
        this.operatorId,
        this.circleId,
        this.planType,
        this.planTab,
        this.planCode,
        this.amount,
        this.talktime,
        this.validity,
        this.planName,
        this.planDescription,
        this.dataBenefit,
        this.isPopular,
        this.isPromoted,
        this.isHidden,
        this.stringTalktime,
        this.special,
        this.validityInDays,
        this.languageRegion,
        this.type,
        this.planTypeForWeb,
        this.planDetailItemList,
        this.planTypeList,
        this.updatedOn,
        this.specialTag,
        this.specialTagBgColor});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operatorId = json['operatorId'];
    circleId = json['circleId'];
    planType = json['planType'];
    planTab = json['planTab'];
    planCode = json['planCode'];
    amount = json['amount'];
    talktime = json['talktime'];
    validity = json['validity'];
    planName = json['planName'];
    planDescription = json['planDescription'];
    dataBenefit = json['dataBenefit'];
    isPopular = json['isPopular'];
    isPromoted = json['isPromoted'];
    isHidden = json['isHidden'];
    stringTalktime = json['stringTalktime'];
    special = json['special'];
    validityInDays = json['validityInDays'];
    languageRegion = json['languageRegion'].cast<String>();
    type = json['type'].cast<String>();
    planTypeForWeb = json['planTypeForWeb'];
    if (json['planDetailItemList'] != null) {
      planDetailItemList = <PlanDetailItemList>[];
      json['planDetailItemList'].forEach((v) {
        planDetailItemList.add(PlanDetailItemList.fromJson(v));
      });
    }
    planTypeList = json['planTypeList'].cast<int>();
    updatedOn = json['updatedOn'];
    specialTag = json['specialTag'];
    specialTagBgColor = json['specialTagBgColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['operatorId'] = operatorId;
    data['circleId'] = circleId;
    data['planType'] = planType;
    data['planTab'] = planTab;
    data['planCode'] = planCode;
    data['amount'] = amount;
    data['talktime'] = talktime;
    data['validity'] = validity;
    data['planName'] = planName;
    data['planDescription'] = planDescription;
    data['dataBenefit'] = dataBenefit;
    data['isPopular'] = isPopular;
    data['isPromoted'] = isPromoted;
    data['isHidden'] = isHidden;
    data['stringTalktime'] = stringTalktime;
    data['special'] = special;
    data['validityInDays'] = validityInDays;
    data['languageRegion'] = languageRegion;
    data['type'] = type;
    data['planTypeForWeb'] = planTypeForWeb;
    if (planDetailItemList != null) {
      data['planDetailItemList'] =
          planDetailItemList.map((v) => v.toJson()).toList();
    }
    data['planTypeList'] = planTypeList;
    data['updatedOn'] = updatedOn;
    data['specialTag'] = specialTag;
    data['specialTagBgColor'] = specialTagBgColor;
    return data;
  }
}

class PlanDetailItemList {
  String key;
  String displayName;
  String displayValue;

  PlanDetailItemList({this.key, this.displayName, this.displayValue});

  PlanDetailItemList.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    displayName = json['displayName'];
    displayValue = json['displayValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['displayName'] = displayName;
    data['displayValue'] = displayValue;
    return data;
  }
}

class DthModel {
  String status;
  String monthlyPlan;
  String accountBalance;
  String customerName;
  String nextDue;
  String lastRechargeDate;
  int lastRecharge;
  String planDetails;

  DthModel(
      {this.status,
        this.monthlyPlan,
        this.accountBalance,
        this.customerName,
        this.nextDue,
        this.lastRechargeDate,
        this.lastRecharge,
        this.planDetails});

  DthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    monthlyPlan = json['monthly_plan'];
    accountBalance = json['account_balance'];
    customerName = json['customer_name'];
    nextDue = json['next_due'];
    lastRechargeDate = json['last_recharge_date'];
    lastRecharge = json['last_recharge'];
    planDetails = json['plan_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['monthly_plan'] = this.monthlyPlan;
    data['account_balance'] = this.accountBalance;
    data['customer_name'] = this.customerName;
    data['next_due'] = this.nextDue;
    data['last_recharge_date'] = this.lastRechargeDate;
    data['last_recharge'] = this.lastRecharge;
    data['plan_details'] = this.planDetails;
    return data;
  }
}






class ElectricityDetails {
  String customerName;
  String billamount;
  String billdate;
  String duedate;

  ElectricityDetails(
      {this.customerName, this.billamount, this.billdate, this.duedate});

  ElectricityDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    billamount = json['Billamount'];
    billdate = json['Billdate'];
    duedate = json['Duedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.customerName;
    data['Billamount'] = this.billamount;
    data['Billdate'] = this.billdate;
    data['Duedate'] = this.duedate;
    return data;
  }
}


