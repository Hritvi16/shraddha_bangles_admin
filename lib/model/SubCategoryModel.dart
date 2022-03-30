class SubCategoryList {
  List<SubCategories> data;

  SubCategoryList({
    this.data,
  });

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["data"] = [];
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
class SubCategories {
  int sc_id;
  String sc_name;
  String sc_image;
  int category;

  SubCategories({
    this.sc_id,
    this.sc_name,
    this.sc_image,
    this.category,
  });

  SubCategories.fromJson(Map<String, dynamic> json) {
    sc_id = json['sc_id'];
    sc_name = json['sc_name'];
    sc_image = json['sc_image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['sc_id'] = this.sc_id;
    map['sc_name'] = this.sc_name;
    map['sc_image'] = this.sc_image;
    map['category'] = this.category;

    return map;
  }
}
