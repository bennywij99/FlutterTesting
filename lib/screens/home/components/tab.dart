import 'package:book/constants/color.constants.dart';
import 'package:book/models/newbook_model.dart';
import 'package:flutter/material.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              )
            ),
          );
        },
      ),
    );       
  }
}