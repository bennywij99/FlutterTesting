import 'package:book/constants/color.constants.dart';
import 'package:book/screens/auth/login.dart';
import 'package:book/screens/home/components/iconBtnWithCounter.dart';
import 'package:book/screens/home/components/search.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHome extends StatefulWidget {
  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
    SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kMainColor,
      expandedHeight: 200.0,
      pinned: true,
       title: Column(
          children: <Widget>[
            Container(
              height: 25,
              margin: EdgeInsets.only(left: 3, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kLightGreyColor
              ),
              child: Stack(
                children: <Widget>[
                  SearchHome()
                ],
              ),
            ),
          ],
        ),
        flexibleSpace:  FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
          background: Image.asset(
            "assets/images/book.png",
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconBtnWithCounter(
            ikonSrc: MdiIcons.cart,
            numOfitem: 3,
            toolTip: 'Cart',
            press: () {
              sharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
          ),
          IconBtnWithCounter(
            ikonSrc: MdiIcons.bell,
            numOfitem: 5,
            toolTip: 'Notification',
            press: () {/* ... */},
          ),
        ],
      );
  }
}