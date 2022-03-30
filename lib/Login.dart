import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shraddha_bangles_admin/Home.dart';
// import 'package:shraddha_bangles_admin/ForgotPassword/Checkmobile.dart';
import 'package:shraddha_bangles_admin/api/APIConstant.dart';
import 'package:shraddha_bangles_admin/api/Environment.dart';
import 'package:shraddha_bangles_admin/model/LoginModel.dart';
import 'package:shraddha_bangles_admin/model/ResponseModel.dart';
import 'package:shraddha_bangles_admin/colors/MyColors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api/APIService.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences sharedPreferences;
  bool _passwordVisible = false;

  bool username_validate, pass_validate;
  String username_error, pass_error;

  @override
  void initState() {
    username_validate = pass_validate = false;
    username_error = pass_error = "";
    _passwordVisible = false;
    super.initState();
  }

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage("assets/top.png"),
            //       fit: BoxFit.fitWidth,
            //       alignment: Alignment.topCenter),
            // ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Logging",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Enter your username and password",
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: username,
                    maxLines: 1,
                    decoration: InputDecoration(
                        errorText: username_validate ? username_error : null,
                        label: Text("Username")),
                    // keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: password,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      errorText: pass_validate ? pass_error : null,
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: FlatButton(
                  //         onPressed: () {
                  //           // Navigator.push(
                  //           //     context,
                  //           //     MaterialPageRoute(
                  //           //         builder: (context) => Checkmobile()));
                  //         },
                  //         child: Text("Forgot Password ?"))),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          if (validate() == 0) {
                            login();
                          }
                        },
                        child: Text("Log In")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {

    Map<String, dynamic> data = new Map();

    data['username'] = username.text;
    data['password'] = password.text;
    print(data);


    LoginResponse loginResponse = await APIService().login(data);

    print(loginResponse.message);
    if (loginResponse.message == "success") {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("user_id", username.text);
      // sharedPreferences.setString("user_id", loginResponse.user_id.toString());
      sharedPreferences.setString("status", "logged in");
      print('sharedPreferences.getString("user_id")');
      print(sharedPreferences.getString("user_id"));
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loginResponse.message)));
    }
  }

  int validate() {
    int cnt = 0;

    if (username.text.isEmpty) {
      setState(() {
        username_validate = true;
        username_error = "Enter Username";
      });
      cnt++;
    } else {
      username_validate = false;
      username_error = "";
    }
    if (password.text.isEmpty) {
      setState(() {
        pass_validate = true;
        pass_error = "Enter Password";
      });
      cnt++;
    } else {
      pass_validate = false;
      pass_error = "";
    }
    return cnt;
  }
}
