import 'dart:async';
import 'package:book/constants/color.constants.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // String _versionName = 'Book Collection';
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, "/myBottom"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/book.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0),
                      // ),
                    ],
                  )),
                ),
                // Expanded(
                //   child: Column(
                //     children: <Widget>[
                //       CircularProgressIndicator(),
                //       Container(
                //         height: 10,
                //       ),
                //       Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: <Widget>[
                //             Spacer(),
                //             Text('Benny Wijaya', style: GoogleFonts.openSans(
                //               color: kMainColor,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w600
                //             ),),
                //             Spacer(
                //               flex: 8,
                //             ),
                //             Text('Book Collection', style: GoogleFonts.openSans(
                //               color: kMainColor,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w600
                //             ),),
                //             Spacer(),
                //           ])
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
