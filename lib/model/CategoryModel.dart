class CategoryList {
  List<Category> data;

  CategoryList({
    this.data,
  });

  CategoryList.fromJson(Map<String, dynamic> json) {
    data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(Category.fromJson(v));
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
class Category {
  int category_id;
  String category_name;
  String category_image;

  Category({
    this.category_id,
    this.category_name,
    this.category_image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    category_id = json['category_id'];
    category_name = json['category_name'];
    category_image = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['category_id'] = this.category_id;
    map['category_name'] = this.category_name;
    map['category_image'] = this.category_image;

    return map;
  }
}
