
import 'package:book/constants/color.constants.dart';
import 'package:book/screens/auth/login.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
          highlightColor: Colors.transparent),
          home: LoginPage(),
      //routes: routesMap
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500);
  var bottomTextStyleAct =
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: kMainColor);
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    BookmarkScreen(),
    LoginPage()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? new SvgPicture.asset('assets/icons/icon_home_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_home_grey.svg'),
            title: Text(
              'Home',
              style: _currentIndex == 0 ? bottomTextStyleAct : bottomTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? new SvgPicture.asset('assets/icons/icon_bookmark_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_bookmark_grey.svg'),
            title: Text(
              'Bookmark',
               style: _currentIndex == 1 ? bottomTextStyleAct : bottomTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? new SvgPicture.asset('assets/icons/icon_user_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_user_grey.svg'),
            title: Text(
              'Account',
               style: _currentIndex == 2 ? bottomTextStyleAct : bottomTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
