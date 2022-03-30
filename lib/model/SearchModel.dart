import 'package:shraddha_bangles_admin/model/ResponseModel.dart';
import 'package:shraddha_bangles_admin/model/SubCategoryModel.dart';

import 'CategoryModel.dart';
import 'ProductModel.dart';

class SearchList {
  List<Category> category;
  List<SubCategories> sub_category;
  List<ProductDetail> product;
  List<SearchModel> search;

  SearchList({
    this.category,
    this.sub_category,
    this.product,
    this.search,
  });

  SearchList.fromJson(Map<String, dynamic> json) {
    category = [];
    search = [];
    if (json["category"] != null) {
      json["category"].forEach((v) {
        category.add(Category.fromJson(v));
        search.add(SearchModel(id: v['category_id'], cat_id: v['category_id'], name: v['category_name'], image: v['category_image'], type: 'Category'));
      });
    }
    sub_category = [];
    if (json["sub_category"] != null) {
      json["sub_category"].forEach((v) {
        sub_category.add(SubCategories.fromJson(v));
        search.add(SearchModel(id: v['sc_id'], cat_id: v['category'], name: v['sc_name'], image: v['sc_image'], type: 'SubCategory'));
      });
    }
    product = [];
    if (json["product"] != null) {
      json["product"].forEach((v) {
        product.add(ProductDetail.fromJson(v));
        search.add(SearchModel(id: v['product_id'], cat_id: v['product_id'], name: v['product_name'], image: "", type: 'Product'));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map["category"] = [];
    if (category != null) {
      map["category"] = category.map((v) => v.toJson()).toList();
    }

    map["sub_category"] = [];
    if (sub_category != null) {
      map["sub_category"] = sub_category.map((v) => v.toJson()).toList();
    }

    map["product"] = [];
    if (product != null) {
      map["product"] = product.map((v) => v.toJson()).toList();
    }
    map["search"] = [];
    if (search != null) {
      map["search"] = search.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class SearchModel
{
  int id;
  int cat_id;
  String name;
  String image;
  String type;


  SearchModel({
    this.id,
    this.cat_id,
    this.name,
    this.image,
    this.type
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cat_id = json["cat_id"];
    name = json["name"];
    image = json["image"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map["id"] = id;
    map["cat_id"] = cat_id;
    map["name"] = name;
    map["image"] = image;
    map["type"] = type;

    return map;
  }


}
