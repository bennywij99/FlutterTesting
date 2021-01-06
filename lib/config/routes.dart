import 'package:book/screens/auth/login.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home_sreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String homeScreen = '/homeScreen';
  static const String bookmark = '/bookmark';
  static const String myBottom = '/myBottom';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => LoginPage(),
      homeScreen: (context) => HomeScreen(),
      
      bookmark: (context) => BookmarkScreen(),
    };
  }
}