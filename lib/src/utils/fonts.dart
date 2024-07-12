import 'package:flutter/material.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
goNextScreen(to) {
  print("calling");
  return navigatorKey.currentState!.push(to);
}

int statusCode200 = 200;
int statusCode201 = 201;
int statusCode401 = 401;
int statusCode501 = 501;
String message = "message";
String response = "response";
bool success = true;
String statusType = 'success';


IsStatus(code) => code == statusCode200 || code == statusCode201;


class FontWeight{
  /*static const backGroundColor = Colors.white;
  static const primaryColor = Color(0xff1B263b);
  static const secondaryColor = Color(0xff778Da9);*/

}
class FontSize{
  static const iconSize = 25;
  static const textSize = 14;
  static const headingSize = 25;
  static const height = 40;
  static const width = 300;

}