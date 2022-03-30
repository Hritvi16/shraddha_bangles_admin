import 'package:shraddha_bangles_admin/api/Environment.dart';

class APIConstant {
  static String insertAdminFCM = Environment.url + Environment.api + "insertAdminFcm/";
  static String login = Environment.url + Environment.api + "adminLogin/";
  static String getOrderByStatus = Environment.url + Environment.api + "fetchOrdersbyStatus/";
  static String getOrderedProducts = Environment.url + Environment.api + "fetchOrderProductsbyID/";
  static String changeOrderStatus = Environment.url + Environment.api + "changeOrderStatus/";
}
