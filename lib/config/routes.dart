import 'package:book/main.dart';
import 'package:book/screens/auth/login.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home_sreen.dart';
import 'package:flutter/material.dart';

final routesMap = {
  '/' : (BuildContext context) => new LoginPage(),
  '/homeScreen': (BuildContext context) => new HomeScreen(),
  '/bookmark': (BuildContext context) => new BookmarkScreen(),
  '/myBottom': (BuildContext context) => new MyBottomNavigationBar(),
};