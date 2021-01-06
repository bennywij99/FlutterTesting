import 'package:book/config/routes.dart';
import 'package:book/constants/color.constants.dart';
import 'package:book/models/popularbook_model.dart';
import 'package:book/widgets/custom_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedBookScreen extends StatelessWidget {
  final PopularBookModel popularBookModel;

  SelectedBookScreen({Key key, @required this.popularBookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: kMainColor,
          onPressed: () {},
          child: Text(
            'Add to Library',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: kWhiteColor),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kMainColor,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Color(popularBookModel.color),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 25,
                        top: 35,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.myBottom);
                             //Navigator.pushReplacementNamed(context, "/myBottom");
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kWhiteColor),
                            child: SvgPicture.asset(
                                'assets/icons/icon_back_arrow.svg'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 62),
                          width: 172,
                          height: 225,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(popularBookModel.image),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 25),
                    child: Text(
                      popularBookModel.title,
                      style: GoogleFonts.openSans(
                          fontSize: 27,
                          color: kBlackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25),
                    child: Text(
                      popularBookModel.author,
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: kGreyColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '\$',
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: kMainColor,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          popularBookModel.price,
                          style: GoogleFonts.openSans(
                              fontSize: 32,
                              color: kMainColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28,
                    margin: EdgeInsets.only(top: 23, bottom: 36),
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
                            weight: 2, width: 30, color: kBlackColor),
                        tabs: [
                          Tab(
                            child: Container(
                              margin: EdgeInsets.only(right: 39),
                              child: Text('Description'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: EdgeInsets.only(right: 39),
                              child: Text('Reviews'),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: EdgeInsets.only(right: 39),
                              child: Text('Similliar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Text(
                      "“Holding brain science in one hand and rich emotional presence in the other, this book feels timely and necessary.”—Shauna Niequist, New York Times bestselling author of Present Over Perfect\n\nWhy is there such a gap between what you want to do and what you actually do? The host of Ask Science Mike explains why our desires and our real lives are so wildly different—and what you can do to close the gap.\n\nFor thousands of years, scientists, philosophers, and self-help gurus have wrestled with one of the basic conundrums of human life: Why do we do the things we do? Or, rather, why do we so often not do the things we want to do? As a podcast host whose voice goes out to millions each month, Mike McHargue gets countless emails from people seeking to understand their own misbehavior—why we binge on Netflix when we know taking a walk outside would be better for us, or why we argue politics on Facebook when our real friends live just down the street. Everyone wants to be a good person, but few of us, twenty years into the new millennium, have any idea how to do that.\n\nIn You’re a Miracle (and a Pain in the Ass), McHargue addresses these issues. We like to think we’re in control of our thoughts and decisions, he writes, but science has shown that a host of competing impulses, emotions, and environmental factors are at play in every action we undertake. Touching on his podcast listeners’ most pressing questions, from relationships and ethics to stress and mental health, and sharing some of the biggest triumphs and hardships from his own life, McHargue shows us how some of our qualities that seem most frustrating—including “negative” emotions like sadness, anger, and anxiety—are actually key to helping humans survive and thrive. In doing so, he invites us on a path of self-understanding and, ultimately, self-acceptance.\n\nYou’re a Miracle (and a Pain in the Ass) is a guided tour through the mystery of human consciousness, showing readers how to live more at peace with themselves in a complex world.",
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: kGreyColor,
                          letterSpacing: 1.5,
                          height: 2),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
