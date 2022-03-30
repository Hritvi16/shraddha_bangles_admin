import 'package:shraddha_bangles_admin/model/CartModel.dart';
import 'package:shraddha_bangles_admin/model/ResponseModel.dart';

import 'ProductModel.dart';
import 'UserResponse.dart';

class OrderList extends Response{
  List<OrderData> data;

  OrderList({
    this.data,
  });

  OrderList.fromJson(Map<String, dynamic> json)  : super.fromJson(json) {
    data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(OrderData.fromJson(v));
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

class OrderData {
  User user;
  Order order;
  List<OrderedProduct> product;

  OrderData({
    this.user,
    this.order,
    this.product,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json["user"]);
    order = Order.fromJson(json["order"]);
    product = [];
    if (json["product"] != null) {
      json["product"].forEach((v) {
        product.add(OrderedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map["user"] = user.toJson();
    map["order"] = order.toJson();
    map["product"] = [];
    if (product != null) {
      map["product"] = product.map((v) => v.toJson()).toList();
    }

    return map;
  }
}


class Order {
  int po_id;
  String po_date;
  String po_status;
  int user;
  int cart;

  Order ({
    this.po_id,
    this.po_date,
    this.po_status,
    this.user,
    this.cart,
  });

  Order.fromJson(Map<String, dynamic> json) {
    po_id = json['po_id'];
    po_date = json['po_date'];
    po_status = json['po_status'];
    user = json['user'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['po_id'] = this.po_id;
    map['po_date'] = this.po_date;
    map['po_status'] = this.po_status;
    map['user'] = this.user;
    map['cart'] = this.cart;

    return map;
  }
}

class OrderedProduct {
  Cart cart;
  ProductDetail product;
  SubProduct sub_product;
  List<Images> images;
  QuantityType quantity_type;
  SubProductType sub_product_type;

  OrderedProduct({
    this.cart,
    this.product,
    this.sub_product,
    this.images,
    this.quantity_type,
    this.sub_product_type,
  });

  OrderedProduct.fromJson(Map<String, dynamic> json) {
    cart = json["cart"]!=null ? Cart.fromJson(json["cart"]) : Cart();
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