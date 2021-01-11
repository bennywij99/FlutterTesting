import 'package:book/constants/color.constants.dart';
import 'package:book/screens/bookmark_screen.dart';
import 'package:book/screens/home/home_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10),
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
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: "Home",
              icon: SvgPicture.asset(
                 MenuState.home == selectedMenu
                    ? "assets/icons/icon_home_colored.svg"
                    : "assets/icons/icon_home_grey.svg"
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            IconButton(
              tooltip: "Bookmark",
              icon: SvgPicture.asset(
                MenuState.bookmark == selectedMenu
                ? "assets/icons/icon_bookmark_colored.svg"
                : "assets/icons/icon_bookmark_grey.svg"
              ),
              onPressed: () =>
                Navigator.pushNamed(context, BookmarkScreen.routeName),
            ),
            
            IconButton(
              tooltip: "Chat",
              icon: Icon( 
                MdiIcons.chatProcessingOutline, color: kGreyColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: "Account",
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
