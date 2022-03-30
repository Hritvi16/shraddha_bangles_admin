import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shraddha_bangles_admin/api/APIConstant.dart';
import 'package:shraddha_bangles_admin/api/APIService.dart';
import 'package:shraddha_bangles_admin/api/Environment.dart';
import 'package:shraddha_bangles_admin/colors/MyColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shraddha_bangles_admin/model/CartModel.dart';
import 'package:shraddha_bangles_admin/model/OrderModel.dart';

import 'model/ResponseModel.dart';

class OrderDetails extends StatefulWidget {

  final int order_id;

  const OrderDetails({Key key, this.order_id}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  SharedPreferences sharedPreferences;
  List<OrderedProduct> orderedProductList;
  OrderData orderData;
  bool load = false;

  int order_id;
  String selectedStatus = "";

  List<String> status;


  @override
  void initState() {
    order_id = widget.order_id;
    orderData = new OrderData();
    orderedProductList = [];
    status = ['PENDING', 'ASSIGNED', 'COMPLETED', 'REJECTED'];
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: ()
            {
              Share.share(getOrderDetails(), subject: 'Ordered Products');
            },
          ),
        ],
        title: Text(
          "ORDER ID: "+order_id.toString(),
          style: TextStyle(color: MyColors.white),
        ),
        backgroundColor: MyColors.colorPrimary,
      ),
      body: Stack(children: [
        load ?
          orderedProductList.isEmpty ?
            Container(
              child: Center(
                child: Text("Cart is empty."),
              ),
            ) :
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: orderedProductList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return getOrderedProductListDesign(
                        orderedProduct: orderedProductList[index],
                      );
                    }),
              ),
            ) :
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.colorPrimary,
              ),
            ),
          ),
        Positioned(
            bottom: 10,
            left: 35,
            child: Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  showChangeStatusBottom();
                },
                child: Text("CHANGE STATUS"),
              ),
            ))
      ]),
    );
  }

  Future<void> getOrderedProducts() async {
    Map<String, dynamic> map = new Map();

    print(sharedPreferences.getString("user_id"));

    map['po_id'] = order_id.toString();

    OrderData orderData = await APIService().getOrderedProducts(map);

    setState(() {
      this.orderData = orderData;
      orderedProductList = orderData.product;
      selectedStatus = orderData.order.po_status;
      load = true;
    });
  }

  int getTotalProducts() {
    int qty = 0;
    // for (int i = 0; i < orderedProductList.length; i++) {
    //   qty += orderedProductList[i].cart.cartTotal;
    // }
    return qty;
  }

  Future<void> getData() async {

    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences = sharedPref;
    });
  }

  Future<void> start() async {
    await getData();
    getOrderedProducts();
  }

  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 440,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          'Checkout',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.highlight_remove)),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => AddressShow()))
                      //     .then((value) {
                      //   setState(() {
                      //     GetAddressdata data = value;
                      //     UAId = data.UAId.toString();
                      //     AddStatus = data.AddStatus;
                      //   });
                      //   Navigator.pop(context);
                      //   showBottom();
                      // });
                    },
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            // AddStatus.isEmpty ? 'Delivery' : AddStatus,
                            'Delivery',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Select Address"),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PromoCode())).then((value) {
                      //   setState(() {
                      //     promoCode = value == null ? "" : value;
                      //   });
                      //   Navigator.pop(context);
                      //   showBottom();
                      // });
                    },
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            'Promo Code',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Pick discount"),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            // applyPromoCode();
                          },
                          child: Text("Apply Promo Code"))),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            'Total Cost',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'By placing an order you agree to our \n',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                        TextSpan(
                            text: 'Terms ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        TextSpan(
                            text: " and ",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        TextSpan(
                            text: 'Condition',
                            style: TextStyle(color: Colors.black, fontSize: 12))
                      ])),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      child: Text('Place Order'),
                      onPressed: () async {
                        // if (UAId.isEmpty) {
                        //   AlertAddress();
                        // } else {
                        //   Navigator.pop(context);
                        //   await makePayment();
                        // }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  void AlertAddress() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Please Select Address'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }



  calculateAmount(String amount) {
    final a = (double.parse(amount).round()) * 100;
    return a.toString();
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 480,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.highlight_remove)),
                  ),
                  Image.asset(
                    "assets/alertimg.png",
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Ops! Order Faild",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Somthing went tembly wrong.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                          onPressed: () async {
                            //insertOrder();
                            // Navigator.pop(context);
                            // await makePayment();
                          },
                          child: Text("please Try Again"))),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Back to home"))
                ],
              ),
            ),
          );
        });
  }

  Widget getOrderedProductListDesign({OrderedProduct orderedProduct}) {
    print("carttttt");
    print(orderedProduct.toJson());
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                Environment.imageUrl +
                    orderedProduct.images[0].pi_path,
                height: 110,
                width: 110,
                fit: BoxFit.cover,
              ),

              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderedProduct.product.product_name,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: 5,),
                                RichText(
                                    text: TextSpan(
                                        text: orderedProduct.sub_product_type.spt_type+' : ',
                                        style:
                                        TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: orderedProduct.sub_product.sp_code.toString(),
                                              style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.bold))
                                        ])),
                                SizedBox(height: 5,),
                                RichText(
                                    text: TextSpan(
                                        text: 'ITEM NO : ',
                                        style:
                                        TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: orderedProduct.product.item_code.toString(),
                                              style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.bold))
                                        ])),
                                SizedBox(height: 5,),
                                RichText(
                                    text: TextSpan(
                                        text: 'PRODUCT CODE : ',
                                        style:
                                        TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: orderedProduct.product.product_code.toString(),
                                              style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.bold))
                                        ])),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: 'Qty : ',
                                            style:
                                            TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                  text: orderedProduct.cart.cp_quantity.toString()+" ",
                                                  style: TextStyle(
                                                      fontSize: 15, fontWeight: FontWeight.bold)),
                                              TextSpan(
                                                  text: orderedProduct.quantity_type.qt_type.toString(),
                                                  style: TextStyle(
                                                      fontSize: 15, fontWeight: FontWeight.bold))
                                            ])
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 8,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  void showAlertDelete(int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure want to delete this Product'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('NO'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('YES'),
          ),
        ],
      ),
    );
  }

  void confirmStatus(String status) {
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
                new Text("Are you sure you want to order status?",
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
                              color: MyColors.colorPrimary
                          ),
                        )
                    ),
                    new TextButton(
                        onPressed: (){
                          Navigator.pop(dialogContext);
                          Navigator.pop(context);
                          changeStatus(status);
                        },
                        child: Text("Yes",
                          style: TextStyle(
                              color: MyColors.colorPrimary
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


  String getOrderDetails() {
    String orderDetails = "";

    orderDetails+="*ORDER ID:* "+orderData.order.po_id.toString()+"\n*Customer Name:* "+orderData.user.user_name+"\n*Shop Name:* "+orderData.user.shop_name+
        "\n*Mobile No.:* "+orderData.user.user_phone.toString()+"\n*Address:* "+orderData.user.user_address+"\n\n\n"+getProducts();
    return orderDetails;
  }

  String getProducts() {
    String products = "";

    for(int i = 0; i<orderedProductList.length; i++)
      {
        products+="*ITEM "+(i+1).toString()+"*\n"+"*Product:* "+orderedProductList[i].product.product_name+"\n*"+orderedProductList[i].sub_product_type.spt_type+":* "+orderedProductList[i].sub_product.sp_code+
            "\n"+"*ITEM NO:* "+orderedProductList[i].product.item_code+"\n"+"*PRODUCT CODE:* "+orderedProductList[i].product.product_code+"\n"+"*QTY:* "+orderedProductList[i].cart.cp_quantity.toString();

        if(i<orderedProductList.length-1)
          products+="\n\n";
      }

    return products;
  }

  void showChangeStatusBottom() {
    String selectStatus = selectedStatus;
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, myState) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.only(bottom: 3),
                      child: ListTile(
                        title: RichText(
                            text: TextSpan(
                                text: 'Change status from ',
                                style:
                                TextStyle(color: Colors.black, fontSize: 15),
                                children: [
                                  TextSpan(
                                      text: orderData.order.po_status+" ",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: " to",
                                      style: TextStyle(
                                          fontSize: 15))
                                ])
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        trailing: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: false,
                            value: selectStatus,
                            items: status.map((item) {
                              return new DropdownMenuItem(

                                child: Container(
                                  width: 150,                    //expand here
                                  child: new Text(
                                    item,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              myState(() {
                                selectStatus = value;
                              });
                            },
                            hint: Container(
                              width: 150,                      //and here
                              child: Text(
                                "Select Status",
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            style:
                            TextStyle(color: Colors.black, decorationColor: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        child: Text('Change'),
                        onPressed: () {
                          confirmStatus(selectStatus);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
      });
      },
    );
  }

  Future<void> changeStatus(String status) async {
    Map<String, dynamic> map = new Map();


    map['po_id'] = orderData.order.po_id.toString();
    map['po_status'] = status;

    Response response = await APIService().changeOrderStatus(map);

    if(response.message=="success") {
      setState(() {
        orderData.order.po_status = status;
        selectedStatus = status;
      });
      successDialog();
    }
    else
      {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message)));
      }
  }


  void successDialog() {
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
                new Text("Order status has been changed successfully.",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        Navigator.pop(dialogContext);
                      },
                      child: Text("OK",
                        style: TextStyle(
                            color: MyColors.colorPrimary
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
