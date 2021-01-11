import 'package:book/constants/color.constants.dart';
import 'package:book/screens/auth/login.dart';
import 'package:book/screens/home/components/category.dart';
import 'package:book/screens/home/components/header.dart';
import 'package:book/screens/home/components/popular.dart';
import 'package:book/screens/home/components/tab.dart';
import 'package:book/widgets/custom_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    return NestedScrollView(
      scrollDirection: Axis.vertical,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          HeaderHome(),
        ];
      },
      body: SafeArea(
        child: Container(
          color: kWhiteColor,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[ 
            
              Categories(),
              Container(
                height: 25,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 25),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    indicatorPadding: EdgeInsets.all(0),
                    isScrollable: true,
                    labelColor: kBlackColor,
                    unselectedLabelColor: kGreyColor,
                    labelStyle: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
                    indicator: RoundedRectangleTabIndicator(weight: 2, width: 10, color: kBlackColor),
                    tabs: [
                      Tab(
                        child: Container(
                          margin: EdgeInsets.only(right: 23),
                          child: Text('New'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          margin: EdgeInsets.only(right: 23),
                          child: Text('Trending'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          margin: EdgeInsets.only(right: 23),
                          child: Text('Best Seller'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TabHome(),

              Padding(
                padding: EdgeInsets.only(left: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Popular',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor
                      ),
                    ),
                  ],
                ),
              ),
              PopularHome(),
            ],
          ),
        ),
      ),
    );
  }
}