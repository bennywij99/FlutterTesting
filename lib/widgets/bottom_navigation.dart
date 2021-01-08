import 'package:book/constants/color.constants.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home/home_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kGreyColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: kWhiteColor.withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                 MenuState.home == selectedMenu
                    ? "assets/icons/icon_home_colored.svg"
                    : "assets/icons/icon_home_grey.svg"
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            IconButton(
              icon: SvgPicture.asset(
                MenuState.bookmark == selectedMenu
                ? "assets/icons/icon_bookmark_colored.svg"
                : "assets/icons/icon_bookmark_grey.svg"
              ),
              onPressed: () =>
                Navigator.pushNamed(context, BookmarkScreen.routeName),
            ),
            
            IconButton(
              icon: SvgPicture.asset("assets/icons/icon_user_grey.svg"),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/icon_user_grey.svg",
                color: MenuState.account == selectedMenu
                    ? kMainColor
                    : inActiveIconColor,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
          ],
        )
      ),
    );
  }
}
