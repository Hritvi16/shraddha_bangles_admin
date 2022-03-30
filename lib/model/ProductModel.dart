class ProductList {
  List<Product> data;

  ProductList({
    this.data,
  });

  ProductList.fromJson(Map<String, dynamic> json) {
    data = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        data.add(Product.fromJson(v));
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

class ProductDet {
  Product data;

  ProductDet({
    this.data,
  });

  ProductDet.fromJson(Map<String, dynamic> json) {
    data = Product.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["data"] = data.toJson();
    return map;
  }
}

class Product {
  List<SubProduct> sub_product;
  ProductDetail product;
  List<Images> images;
  QuantityType quantity_type;
  SubProductType sub_product_type;

  Product({
    this.sub_product,
    this.product,
    this.images,
    this.quantity_type,
    this.sub_product_type,
  });

  Product.fromJson(Map<String, dynamic> json) {
    sub_product = [];
    if (json["sub_product"] != null) {
      json["sub_product"].forEach((v) {
        sub_product.add(SubProduct.fromJson(v));
      });
    }
    product = ProductDetail.fromJson(json["product"]);
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
    map["sub_product"] = [];
    if (sub_product != null) {
      map["sub_product"] = sub_product.map((v) => v.toJson()).toList();
    }
    map["product"] = product.toJson();
    map["images"] = [];
    if (images != null) {
      map["images"] = images.map((v) => v.toJson()).toList();
    }
    map["quantity_type"] = quantity_type.toJson();
    map["sub_product_type"] = sub_product_type.toJson();

    return map;
  }
}

class ProductDetail {
  int product_id;
  String product_name;
  dynamic product_price;
  String item_code;
  String product_code;
  String pack_size;
  String product_desc;
  String product_offer;
  int minimumOrderValue;
  String minimumOrder;
  int category;
  int sc;
  int qt;
  int spt;

  ProductDetail({
    this.product_id,
    this.product_name,
    this.product_price,
    this.item_code,
    this.product_code,
    this.pack_size,
    this.product_desc,
    this.product_offer,
    this.minimumOrderValue,
    this.minimumOrder,
    this.category,
    this.sc,
    this.qt,
    this.spt,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    product_name = json['product_name'];
    product_price = json['product_price'];
    item_code = json['item_code'];
    product_code = json['product_code'];
    pack_size = json['pack_size'];
    product_desc = json['product_desc'];
    product_offer = json['product_offer'];
    minimumOrderValue = json['minimumOrderValue'];
    minimumOrder = json['minimumOrder'];
    category = json['category'];
    sc = json['sc'];
    qt = json['qt'];
    spt = json['spt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['product_id'] = this.product_id;
    map['product_name'] = this.product_name;
    map['product_price'] = this.product_price;
    map['item_code'] = this.item_code;
    map['product_code'] = this.product_code;
    map['pack_size'] = this.pack_size;
    map['product_desc'] = this.product_desc;
    map['product_offer'] = this.product_offer;
    map['minimumOrderValue'] = this.minimumOrderValue;
    map['minimumOrder'] = this.minimumOrder;
    map['category'] = this.category;
    map['sc'] = this.sc;
    map['qt'] = this.qt;
    map['spt'] = this.spt;

    return map;
  }
}

class Images {
  int pi_id;
  String pi_path;
  int product;

  Images({
    this.pi_id,
    this.pi_path,
    this.product,
  });

  Images.fromJson(Map<String, dynamic> json) {
    pi_id = json['pi_id'];
    pi_path = json['pi_path'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['pi_id'] = this.pi_id;
    map['pi_path'] = this.pi_path;
    map['product'] = this.product;

    return map;
  }
}

class SubProduct {
  int sp_id;
  String sp_code;
  String stock_type;
  int product;

  SubProduct({
    this.sp_id,
    this.sp_code,
    this.stock_type,
    this.product,
  });

  SubProduct.fromJson(Map<String, dynamic> json) {
    sp_id = json['sp_id'];
    sp_code = json['sp_code'];
    stock_type = json['stock_type'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['sp_id'] = this.sp_id;
    map['sp_code'] = this.sp_code;
    map['stock_type'] = this.stock_type;
    map['product'] = this.product;

    return map;
  }
}

class QuantityType {
  int qt_id;
  String qt_type;

  QuantityType({
    this.qt_id,
    this.qt_type,
  });

  QuantityType.fromJson(Map<String, dynamic> json) {
    qt_id = json['qt_id'];
    qt_type = json['qt_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['qt_id'] = this.qt_id;
    map['qt_type'] = this.qt_type;

    return map;
  }
}

class SubProductType {
  int spt_id;
  String spt_type;

  SubProductType({
    this.spt_id,
    this.spt_type,
  });

  SubProductType.fromJson(Map<String, dynamic> json) {
    spt_id = json['spt_id'];
    spt_type = json['spt_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['spt_id'] = this.spt_id;
    map['spt_type'] = this.spt_type;

    return map;
  }
}

