class ModelPlanList {
  ModelPlanList({
     this.success,
    this.message,
     this.data,
  });
  bool success;
   String message;
   List<PlanList> data;

  ModelPlanList.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>PlanList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PlanList {
  PlanList({
    this.id,
     this.group,
     this.category,
    this.subCat,
     this.plan,
    this.description,
     this.planImage,
  });
   int id;
   String group;
   String category;
   String subCat;
  String plan;
  String description;
  String planImage;

  PlanList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    group = json['group'];
    category = json['category'];
    subCat = json['sub_cat'];
    plan = json['plan'];
    description = json['description'];
    planImage = json['plan_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['group'] = group;
    _data['category'] = category;
    _data['sub_cat'] = subCat;
    _data['plan'] = plan;
    _data['description'] = description;
    _data['plan_image'] = planImage;
    return _data;
  }
}