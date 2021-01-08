import 'dart:convert';

import 'package:book/constants/color.constants.dart';
import 'package:book/screens/home/home_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  int _pageState = 0;

  var _backgroundColor = kMainColor;
  var _headingColor = kMainColor;

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginOpacity = 1;

  double _loginHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
   void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    windowHeight  = MediaQuery.of(context).size.height;
    windowWidth   = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 220;
    _registerHeight = windowHeight -220;

    switch (_pageState) {
      case 0:
        _backgroundColor = kWhiteColor;
        _headingColor = kMainColor;

        _headingTop = 70;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginXOffset = 0;

        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = kMainColor;
        _headingColor = kWhiteColor;
        
        _headingTop = 70;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 220;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 220;
        _loginXOffset = 0;

        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = kMainColor;
        _headingColor = kWhiteColor;

        _headingTop = 60;

        _loginWidth = windowWidth - 35;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 200;
        _loginXOffset = 18;
        
        _registerYOffset = _keyboardVisible ? 40 : 220;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight-220;  
        break;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Stack(
          children: <Widget>[
            splashSection(),
            loginSection(),
            registerSection()
          ],
        ),
      ),
    );
  }

  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password
    };
    var jsonResponse;
    var response = await http.post("http://jerrysibarani.com/androidserverapi/myapi/login_api", body: data);
    print(response.statusCode);
    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        print(jsonResponse);
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  AnimatedContainer splashSection() {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(
        milliseconds: 1000
      ),
      color: _backgroundColor,
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ 
          GestureDetector(
            onTap: () {
              setState(() {
                _pageState = 0;
              });
            },
            child: Container(  
              child: Column( 
                children: <Widget>[
                  AnimatedContainer( 
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(
                      milliseconds: 1000
                    ),
                    margin: EdgeInsets.only(top: _headingTop),
                    child: Text(
                      'Book Collection',
                      style: GoogleFonts.openSans( 
                        color: _headingColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text('Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum.', 
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans( 
                      fontSize: 14,
                      color: _headingColor
                    ),),
                  )
                ],
              ),
            ),
          ),
          Container( 
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Center( 
              child: Image.asset('assets/images/book.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if(_pageState != 0) {
                  _pageState = 0;
                } else {
                  _pageState = 1;
                }
              });
            },
            child: Container(
              child: Container(
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration( 
                  color: _headingColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text( 
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans( 
                    color: _backgroundColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  AnimatedContainer loginSection() {
    return AnimatedContainer(
      padding: EdgeInsets.all(20),
      width: _loginWidth,
      height: _loginHeight,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration( 
        milliseconds: 1000
      ),
      transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
      decoration: BoxDecoration( 
        color: kWhiteColor.withOpacity(_loginOpacity),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        )
      ),
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ 
          Column( 
            children: <Widget>[
              Container( 
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Login To Continue",
                  style: GoogleFonts.openSans( 
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kMainColor
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration( 
                  border: Border.all( 
                    color: kMainColor
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row( 
                  children: <Widget>[ 
                    Container( 
                      width: 60,
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: kGreyColor,
                        ),
                    ),
                    Expanded(
                      child: TextFormField( 
                        controller: usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border: InputBorder.none,
                          hintText: "Enter Username..."
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration( 
                  border: Border.all( 
                    color: kMainColor
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row( 
                  children: <Widget>[ 
                    Container( 
                      width: 60,
                      child: Icon(
                        Icons.vpn_key,
                        size: 20,
                        color: kGreyColor,
                        ),
                    ),
                    Expanded(
                      child: TextFormField( 
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            color: kGreyColor,
                            icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border: InputBorder.none,
                          hintText: "Enter Password...",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column( 
            children: <Widget>[ 
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration( 
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                padding: EdgeInsets.all(10),
                child: MaterialButton( 
                  onPressed: usernameController.text == "" || passwordController.text == "" ? null : () {
                    setState(() {
                      _isLoading = true;
                    });
                  signIn(usernameController.text, passwordController.text);
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.openSans( 
                      color: kWhiteColor,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),      
              GestureDetector(
                onTap: () {
                    setState(() {
                    _pageState = 2;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration( 
                    border: Border.all( 
                      color: kMainColor,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Create New Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans( 
                      color: kMainColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer registerSection() {
    return AnimatedContainer( 
      height: _registerHeight,
      padding: EdgeInsets.all(20),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration( 
        milliseconds: 1000
      ),
      transform: Matrix4.translationValues(0, _registerYOffset, 1),
      decoration: BoxDecoration( 
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ 
          Column( 
            children: <Widget>[ 
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Create a New Account",
                  style: GoogleFonts.openSans( 
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kMainColor
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration( 
                  border: Border.all( 
                    color: kMainColor
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row( 
                  children: <Widget>[ 
                    Container( 
                      width: 60,
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: kGreyColor,
                        ),
                    ),

                    Expanded(
                      child: TextField( 
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border: InputBorder.none,
                          hintText: "Enter Username..."
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration( 
                  border: Border.all( 
                    color: kMainColor
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Row( 
                  children: <Widget>[ 
                    Container( 
                      width: 60,
                      child: Icon(
                        Icons.vpn_key,
                        size: 20,
                        color: kGreyColor,
                        ),
                    ),

                    Expanded(
                      child: TextField( 
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            color: kGreyColor,
                            icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border: InputBorder.none,
                          hintText: "Enter Password...",
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Column( 
            children: <Widget>[ 
              Container(
                decoration: BoxDecoration( 
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                padding: EdgeInsets.all(20),
                child: Center( 
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.openSans( 
                      color: kWhiteColor,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageState = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration( 
                    border: Border.all( 
                      color: kMainColor,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Center( 
                    child: Text(
                      "Back To Login",
                      style: GoogleFonts.openSans( 
                        color: kMainColor,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
