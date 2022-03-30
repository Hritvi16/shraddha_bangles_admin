import 'dart:convert';

import 'package:shraddha_bangles_admin/api/APIConstant.dart';
import 'package:http/http.dart' as http;
import 'package:shraddha_bangles_admin/model/CartModel.dart';
import 'package:shraddha_bangles_admin/model/CategoryModel.dart';
import 'package:shraddha_bangles_admin/model/LoginModel.dart';
import 'package:shraddha_bangles_admin/model/OrderModel.dart';
import 'package:shraddha_bangles_admin/model/ProductModel.dart';
import 'package:shraddha_bangles_admin/model/ResponseModel.dart';
import 'package:shraddha_bangles_admin/model/SearchModel.dart';
import 'package:shraddha_bangles_admin/model/SubCategoryModel.dart';
import 'package:shraddha_bangles_admin/model/UserResponse.dart';

class APIService {

  Future<Response> insertAdminFCM(Map<String, dynamic> data) async {
    String url = APIConstant.insertAdminFCM;
    var result = await http.post(Uri.parse(url), body: data);

    print(result.body);
    var resp = jsonDecode(result.body);
    Response response = Response.fromJson(resp);
    print(result.body);
    return response;
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    String url = APIConstant.login;
    var result = await http.post(Uri.parse(url), body: data);

    var response = jsonDecode(result.body);
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    print(result.body);
    return loginResponse;
  }

  Future<OrderList> getOrderByStatus(Map<String, dynamic> data) async {
    String url = APIConstant.getOrderByStatus;
    var result = await http.post(Uri.parse(url), body: data);

    var orders = jsonDecode(result.body);
    OrderList orderList = OrderList.fromJson(orders);
    print(result.body);
    return orderList;
  }

  Future<OrderData> getOrderedProducts(Map<String, dynamic> data) async {
    print(data);
    String url = APIConstant.getOrderedProducts;
    var result = await http.post(Uri.parse(url), body: data);

    var order = jsonDecode(result.body);
    OrderData orderData = OrderData.fromJson(order);
    print(result.body);
    return orderData;
  }

  Future<Response> changeOrderStatus(Map<String, dynamic> data) async {
    print(data);
    String url = APIConstant.changeOrderStatus;
    var result = await http.post(Uri.parse(url), body: data);

    var res = jsonDecode(result.body);
    Response response = Response.fromJson(res);
    print(result.body);
    return response;
  }

}
