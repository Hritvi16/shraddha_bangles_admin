import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shraddha_bangles_admin/OrderDetails.dart';
import 'package:shraddha_bangles_admin/api/APIService.dart';

import 'package:shraddha_bangles_admin/colors/MyColors.dart';
import 'package:shraddha_bangles_admin/model/OrderModel.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> tabsList = ["PENDING", "ASSIGNED", "COMPLETED", "REJECTED"];
  bool load = false;

  SharedPreferences sharedPreferences;
  /*List<String> proImage = [
    "assets/face_a.jpg",
    "assets/face_b.jpg",
    "assets/face_c.jpg",
    "assets/face_d.jpg",
  ];*/
  List<OrderData> orders = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabsList.length, vsync: this);
    fetchOrdersbyStatus("PENDING");
    _tabController.addListener(() {
      print(_tabController.index);
      int index = _tabController.index;
      String status = index==0 ? "PENDING" : index==1 ? "ASSIGNED" : index==2 ? "COMPLETED" : "REJECTED";
      fetchOrdersbyStatus(status);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                logoutTask();
          }, icon: Icon(Icons.logout, color: MyColors.white))
        ],
        title: Text("Shraddha Store Admin"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0),
                    insets: EdgeInsets.symmetric(horizontal: 30.0)),
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: MyColors.colorPrimary,
                indicatorColor: MyColors.colorPrimary,
                tabs: List<Widget>.generate(tabsList.length, (int index) {
                  return new Tab(text: tabsList[index]);
                }),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                child: Container(
                  child: load ? TabBarView(
                    children: List<Widget>.generate(tabsList.length, (int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: orderListDesign(),
                      );
                    }),
                    controller: _tabController,
                  ) : Center(
                    child: CircularProgressIndicator(
                      color: MyColors.colorPrimary,
                    ),
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }

  Widget orderListDesign() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: orders.length,
      itemBuilder: (_, i) => getOrderDesign(orders[i]),
    );
  }

  Widget getOrderDesign(OrderData orderData) {
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(orderData.order.po_date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var date = outputFormat.format(inputDate);
    outputFormat = DateFormat('hh:mm a');
    var time = outputFormat.format(inputDate);
    print(date);

    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderDetails(order_id: orderData.order.po_id,)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: MyColors.grey10),
            color: Colors.white,
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Name : " + orderData.user.user_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Shop Name : ',
                      style: TextStyle(color: MyColors.black,  fontWeight: FontWeight.bold, fontSize: 18),
                      children: [
                        TextSpan(
                            text: orderData.user.shop_name.toString(),
                            style: TextStyle(
                                color: MyColors.black,  fontWeight: FontWeight.normal, fontSize: 18)),
                      ])),
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Order ID : ',
                      style: TextStyle(color: MyColors.black,  fontWeight: FontWeight.bold, fontSize: 18),
                      children: [
                        TextSpan(
                            text: orderData.order.po_id.toString(),
                            style: TextStyle(
                                color: MyColors.black,  fontWeight: FontWeight.normal, fontSize: 18)),
                      ])),
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Date : ',
                      style: TextStyle(color: MyColors.black,  fontWeight: FontWeight.bold, fontSize: 18),
                      children: [
                        TextSpan(
                            text: date,
                            style: TextStyle(
                                color: MyColors.black,  fontWeight: FontWeight.normal, fontSize: 18)),
                      ])),
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Time : ',
                      style: TextStyle(color: MyColors.black,  fontWeight: FontWeight.bold, fontSize: 18),
                      children: [
                        TextSpan(
                            text: time,
                            style: TextStyle(
                                color: MyColors.black,  fontWeight: FontWeight.normal, fontSize: 18)),
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchOrdersbyStatus(String poStatus) async {
    setState(() {
      load = false;
    });
    Map<String, dynamic> map = Map();
    map["po_status"] = poStatus;

    print(map);

    OrderList result = await APIService().getOrderByStatus(map);
    setState(() {
      orders = result.data;
      load = true;
    });
  }


  void logoutTask() {
    confirmLogout();
  }

  void confirmLogout() {
    BuildContext dialogContext;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 10, top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Text("Are you sure you want to logout?",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new TextButton(
                        onPressed: (){
                          Navigator.pop(dialogContext);
                        },
                        child: Text("No",
                          style: TextStyle(
                              color: MyColors.colorAccent
                          ),
                        )
                    ),
                    new TextButton(
                        onPressed: (){
                          Navigator.pop(dialogContext);
                          logout();
                        },
                        child: Text("Yes",
                          style: TextStyle(
                              color: MyColors.colorAccent
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    if(sharedPreferences==null)
      await start();
    sharedPreferences.setString("status", "logged out");
    sharedPreferences.setString("user_id", "");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Login()),
            (Route<dynamic> route) => false
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
