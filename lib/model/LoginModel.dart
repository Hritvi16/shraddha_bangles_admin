import 'package:shraddha_bangles_admin/model/ResponseModel.dart';

class LoginResponse extends Response{
  int user_id;

  LoginResponse({
    this.user_id,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    user_id = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['userId'] = this.user_id;

    return map;
  }
}
