import 'package:book/config/routes.dart';
import 'package:book/constants/color.constants.dart';
import 'package:book/screens/home/home_sreen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: kMainColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}