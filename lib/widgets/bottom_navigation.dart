import 'package:book/constants/color.constants.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home_sreen.dart';
import 'package:book/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500);

  PageController _pageController = PageController();
  List<Widget> _screens = [HomeScreen(), BookmarkScreen(), SplashScreen()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  void _onItemTapped(int selectedIndex) {
    print(selectedIndex);
    // _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
  PageView(
      controller: _pageController,
      children: _screens,
      onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    );
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 5))
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: BottomNavigationBar(
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? new SvgPicture.asset('assets/icons/icon_home_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_home_grey.svg'),
            title: Text(
              'Home',
              style: bottomTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? new SvgPicture.asset('assets/icons/icon_bookmark_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_bookmark_grey.svg'),
            title: Text(
              'Bookmark',
              style: bottomTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? new SvgPicture.asset('assets/icons/icon_user_colored.svg')
                : new SvgPicture.asset('assets/icons/icon_user_grey.svg'),
            title: Text(
              'Account',
              style: bottomTextStyle,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGreyColor,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}
