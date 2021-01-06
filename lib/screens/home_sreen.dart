import 'package:book/constants/color.constants.dart';
import 'package:book/models/newbook_model.dart';
import 'package:book/models/popularbook_model.dart';
import 'package:book/screens/auth/login.dart';
import 'package:book/screens/selected_book_screen.dart';
import 'package:book/widgets/custom_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title:     
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded( 
                child: Text(
                  'Hi, Benny',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kGreyColor),
                ),
              ),
              IconButton(
                icon: Icon(MdiIcons.cart, color: kGreyColor,),
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
                },
              ),
              IconButton(
                icon: Icon(MdiIcons.bell, color: kGreyColor,),
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
                },
              ),
              IconButton(
                icon: Icon(MdiIcons.logout, color: kGreyColor,),
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
                },
              ),
            ]
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: kMainColor,
      // bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: Container(
          color: kWhiteColor,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: 39,
                margin: EdgeInsets.only(left: 25, right: 25, top: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kLightGreyColor),
                child: Stack(
                  children: <Widget>[
                    TextField(
                      maxLengthEnforced: true,
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: kBlackColor,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 19, right: 50, bottom: 8),
                        border: InputBorder.none,
                        hintText: 'Search Book..',
                        hintStyle: GoogleFonts.openSans(
                            fontSize: 12,
                            color: kGreyColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SvgPicture.asset('assets/svg/background_search.svg'),
                    ),
                    Positioned(
                      top: 8,
                      right: 9,
                      child:
                          SvgPicture.asset('assets/icons/icon_search_white.svg'),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(left: 25),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    indicatorPadding: EdgeInsets.all(0),
                    isScrollable: true,
                    labelColor: kBlackColor,
                    unselectedLabelColor: kGreyColor,
                    labelStyle: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    indicator: RoundedRectangleTabIndicator(
                        weight: 2, width: 10, color: kBlackColor),
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
              Container(
                margin: EdgeInsets.only(top: 21),
                height: 210,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 25, right: 6),
                  itemCount: newbooks.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 19),
                      height: 210,
                      width: 153,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kMainColor,
                          image: DecorationImage(
                            image: AssetImage(newbooks[index].image),
                          )),
                    );
                  },
                ),
              ),
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
                          color: kBlackColor),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.only(top: 25, right: 25, left: 25),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: populars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('ListView Tapped');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedBookScreen(
                                popularBookModel: populars[index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 19),
                        height: 81,
                        width: MediaQuery.of(context).size.width - 50,
                        color: kBackgroundColor,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 81,
                              width: 62,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(populars[index].image),
                                  ),
                                  color: kMainColor),
                            ),
                            SizedBox(
                              width: 21,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  populars[index].title,
                                  style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  populars[index].author,
                                  style: GoogleFonts.openSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: kGreyColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '\$' + populars[index].price,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
