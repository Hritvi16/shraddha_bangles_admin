import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shraddha_bangles_admin/Home.dart';

import 'Login.dart';
import 'api/APIService.dart';
import 'colors/MyColors.dart';
import 'model/ResponseModel.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a background message${message.messageId}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance notification",
    "This channel is used fro important notification.",
    importance: Importance.high);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
          primaryColor: MyColors.colorPrimary,
        ),
        title: "",
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    icon: "launch_background")));
      }
    });

    getToken();
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      checkStatus();
    });
    Future.delayed(Duration(seconds: 3), () {
      taketo();
    });
  }
  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print("token");
    print(token);
    print("token");
    insertAdminFCM(token);
  }

  void taketo() {
    if (sharedPreferences.getString("status") == "logged in") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
              (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
              (Route<dynamic> route) => false);
    }

  }

  void checkStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/bangles/bangles.png",
                height: 200,
                width: 200,
              ),
              Text(
                "Shraddha Store",
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
    );
  }

  Future<void> insertAdminFCM(String token) async {
    Map<String, dynamic> data = new Map();

    data['af_key'] = token;

    Response response = await APIService().insertAdminFCM(data);
    print("response.message");
    print(response.message);
  }
}
