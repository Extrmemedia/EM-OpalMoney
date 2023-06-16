class ModelCommonList {
  ModelCommonList({
    this.success,
     this.message,
     this.data,
  });
     bool success;
     String message;
    List<Data> data;

  ModelCommonList.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.group,
    this.category,
     this.subCat,
     this.subcatImage,
  });
   int id;
   String group;
  String category;
   String subCat;
   String subcatImage;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    group = json['group'];
    category = json['category'];
    subCat = json['sub_cat'];
    subcatImage = json['subcat_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['group'] = group;
    _data['category'] = category;
    _data['sub_cat'] = subCat;
    _data['subcat_image'] = subcatImage;
    return _data;
  }
}