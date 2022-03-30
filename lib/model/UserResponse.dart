import 'package:shraddha_bangles_admin/model/ResponseModel.dart';

class UserResponse extends Response{
  User user_details;

  UserResponse({
    this.user_details,
  });

  UserResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    user_details = User.fromJson(json['user_details']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["user_details"] =  user_details.toJson();

    return map;
  }
}
class User {
  int user_id;
  String user_name;
  String user_phone;
  String shop_name;
  String user_address;
  String user_gst;

  User({
    this.user_id,
    this.user_name,
    this.user_phone,
    this.shop_name,
    this.user_address,
    this.user_gst,
  });

  User.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    user_name = json['user_name'];
    user_phone = json['user_phone'];
    shop_name = json['shop_name'];
    user_address = json['user_address'];
    user_gst = json['user_gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['user_id'] = this.user_id;
    map['user_name'] = this.user_name;
    map['user_phone'] = this.user_phone;
    map['shop_name'] = this.shop_name;
    map['user_address'] = this.user_address;
    map['user_gst'] = this.user_gst;

    return map;
  }
}
