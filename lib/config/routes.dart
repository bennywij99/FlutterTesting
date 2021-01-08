
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home/home_sreen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  BookmarkScreen.routeName: (context) => BookmarkScreen()
};
