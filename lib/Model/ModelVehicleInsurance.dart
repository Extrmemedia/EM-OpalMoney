class ModelVehicleInsurance {
  String uid;
  String name;
  String mobile;
  String doreg;
  String dopurchase;
  String rtoozone;
  String purchaseCity;
  String imposedSpecialcond;
  String chasisno;
  String engno;
  String city;
  String branch;
  String additionalcover;
  String nonconentionFuel;
  String extensionRequired;
  String higherDeductable;
  String assocMember;
  String antiTheft;
  String coverLegalLiab;
  String legalLiabOther;
  String paCover;
  String cngLpg;
  String pan;
  String adhar;
  String photo;
  String rcbook;
  String insurance;
  String updatedAt;
  String createdAt;
  int id;
  bool success;
  String message;

  ModelVehicleInsurance(
      {this.uid,
        this.name,
        this.mobile,
        this.doreg,
        this.dopurchase,
        this.rtoozone,
        this.purchaseCity,
        this.imposedSpecialcond,
        this.chasisno,
        this.engno,
        this.city,
        this.branch,
        this.additionalcover,
        this.nonconentionFuel,
        this.extensionRequired,
        this.higherDeductable,
        this.assocMember,
        this.antiTheft,
        this.coverLegalLiab,
        this.legalLiabOther,
        this.paCover,
        this.cngLpg,
        this.pan,
        this.adhar,
        this.photo,
        this.rcbook,
        this.insurance,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.success,
        this.message});

  ModelVehicleInsurance.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    mobile = json['mobile'];
    doreg = json['doreg'];
    dopurchase = json['dopurchase'];
    rtoozone = json['rtoozone'];
    purchaseCity = json['purchase_city'];
    imposedSpecialcond = json['imposed_specialcond'];
    chasisno = json['chasisno'];
    engno = json['engno'];
    city = json['city'];
    branch = json['branch'];
    additionalcover = json['additionalcover'];
    nonconentionFuel = json['nonconention_fuel'];
    extensionRequired = json['extension_required'];
    higherDeductable = json['higher_deductable'];
    assocMember = json['assoc_member'];
    antiTheft = json['anti_theft'];
    coverLegalLiab = json['cover_legal_liab'];
    legalLiabOther = json['legal_liab_other'];
    paCover = json['pa_cover'];
    cngLpg = json['cng_lpg'];
    pan = json['pan'];
    adhar = json['adhar'];
    photo =json['photo'];
    rcbook =json['rcbook'];
    insurance = json['insurance'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['doreg'] = this.doreg;
    data['dopurchase'] = this.dopurchase;
    data['rtoozone'] = this.rtoozone;
    data['purchase_city'] = this.purchaseCity;
    data['imposed_specialcond'] = this.imposedSpecialcond;
    data['chasisno'] = this.chasisno;
    data['engno'] = this.engno;
    data['city'] = this.city;
    data['branch'] = this.branch;
    data['additionalcover'] = this.additionalcover;
    data['nonconention_fuel'] = this.nonconentionFuel;
    data['extension_required'] = this.extensionRequired;
    data['higher_deductable'] = this.higherDeductable;
    data['assoc_member'] = this.assocMember;
    data['anti_theft'] = this.antiTheft;
    data['cover_legal_liab'] = this.coverLegalLiab;
    data['legal_liab_other'] = this.legalLiabOther;
    data['pa_cover'] = this.paCover;
    data['cng_lpg'] = this.cngLpg;
    data['pan'] = this.pan;
    data['adhar'] = this.adhar;
    data['photo'] = this.photo;
    data['rcbook'] = this.rcbook;
    data['insurance'] = this.insurance;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}