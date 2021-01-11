import 'package:book/constants/color.constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.toolTip,
    @required this.ikonSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String toolTip;
  final IconData ikonSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            child: Icon(ikonSrc),
            padding: EdgeInsets.only(right: 15, top: 10),
            height: 46,
            width:46,
          ),
          if (numOfitem != 0)
          Positioned(
            top: -12,
            right: 12,
            bottom: 10,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: kWhiteColor,
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: kMainColor),
              ),
              child: Center(
                child: Text(
                  "$numOfitem",
                  style: GoogleFonts.openSans(
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    color: kMainColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
