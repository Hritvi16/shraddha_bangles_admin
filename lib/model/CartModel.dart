import 'package:shraddha_bangles_admin/model/ResponseModel.dart';

import 'ProductModel.dart';

class CartList extends Response{
  List<CartProduct> data;

  CartList({
    this.data,
  });

  CartList.fromJson(Map<String, dynamic> json)  : super.fromJson(json) {
    data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(CartProduct.fromJson(v));
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

class CartProduct {
  Cart cart;
  ProductDetail product;
  SubProduct sub_product;
  List<Images> images;
  QuantityType quantity_type;
  SubProductType sub_product_type;

  CartProduct({
    this.cart,
    this.product,
    this.sub_product,
    this.images,
    this.quantity_type,
    this.sub_product_type,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    cart = Cart.fromJson(json["cart"]);
    product = ProductDetail.fromJson(json["product"]);
    sub_product = SubProduct.fromJson(json["sub_product"]);
    images = [];
    if (json["images"] != null) {
      json["images"].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    quantity_type = QuantityType.fromJson(json["quantity_type"]);
    sub_product_type = SubProductType.fromJson(json["sub_product_type"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map["cart"] = cart.toJson();
    map["product"] = product.toJson();
    map["sub_product"] = sub_product.toJson();
    map["images"] = [];
    if (images != null) {
      map["images"] = images.map((v) => v.toJson()).toList();
    }
    map["quantity_type"] = quantity_type.toJson();
    map["sub_product_type"] = sub_product_type.toJson();

    return map;
  }
}

class Cart {
  int cp_id;
  int cp_quantity;
  dynamic cp_price;
  dynamic cp_total_price;
  String cp_date;
  int product;
  int sp;
  int cart;

  Cart ({
    this.cp_id,
    this.cp_quantity,
    this.cp_price,
    this.cp_total_price,
    this.cp_date,
    this.product,
    this.sp,
    this.cart,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    cp_id = json['cp_id'];
    cp_quantity = json['cp_quantity'];
    cp_price = json['cp_price'];
    cp_total_price = json['cp_total_price'];
    cp_date = json['cp_date'];
    product = json['product'];
    sp = json['sp'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['cp_id'] = this.cp_id;
    map['cp_quantity'] = this.cp_quantity;
    map['cp_price'] = this.cp_price;
    map['cp_total_price'] = this.cp_total_price;
    map['cp_date'] = this.cp_date;
    map['product'] = this.product;
    map['sp'] = this.sp;
    map['cart'] = this.cart;

    return map;
  }
}
