import 'package:book/constants/color.constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchHome extends StatefulWidget {
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLengthEnforced: true,
      style: GoogleFonts.openSans(
        fontSize: 11,
        color: kBlackColor,
        fontWeight: FontWeight.w600
      ),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: 19, bottom: 15),
        border: InputBorder.none,
          hintText: 'Search Book..',
          prefixIcon: Icon(Icons.search, color: kGreyColor
        ),
        hintStyle: GoogleFonts.openSans(
          fontSize: 11,
          color: kGreyColor,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}