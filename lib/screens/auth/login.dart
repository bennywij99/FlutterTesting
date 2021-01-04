import 'dart:convert';

import 'package:book/constants/color.constants.dart';
import 'package:book/screens/home_sreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  login() async {
    //http://192.168.100.15:777/androidserverapi/myapi/login_api",
    final response = await http.post(
        "http://jerrysibarani.com/androidserverapi/myapi/login_api",
        body: {"username": username, "password": password});
    final data = jsonDecode(response.body);
    int status = data['status'];
    String message = data['message'];
    String usernameAPI = data['username'];
    String namalengkapAPI = data['namalengkap'];
    String id = data['id'];
    print(status);
       if (status == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, namalengkapAPI, id);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) { 
          return AlertDialog(
            title: new Text("Error Message"),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  }

  savePref(int status, String username, String namalengkap, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("status", status);
      preferences.setString("namalengkap", namalengkap);
      preferences.setString("username", username);
      preferences.setString("id", id);  
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
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
    getPref();
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
        
        _registerYOffset = _keyboardVisible ? 55 : 220;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight-220;  
        break;
    }
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            child: Stack( 
              children: <Widget>[
                AnimatedContainer(
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
                ),

                AnimatedContainer(
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
                          Form(
                            key: _key,
                            child: Column( 
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
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Username cannot be empty';
                                            }
                                            return null;
                                          },
                                          onSaved: (e) => username = e,
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
                                          obscureText: _secureText,
                                          onSaved: (e) => password = e,
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
                            )
                          ),
                        ],
                      ),
                      Column( 
                        children: <Widget>[ 
                          Container(
                            decoration: BoxDecoration( 
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center( 
                             child: MaterialButton( 
                              onPressed: () {
                                check();
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
                          ),
                          SizedBox( 
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _pageState = 2;
                              });
                            },
                            child: OutlineButton( 
                              btnText: "Create New Account",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                AnimatedContainer( 
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
                      InputWithIcon(
                        icon: Icons.email,
                        hint: "Enter Email...",
                      ),
                      SizedBox(height: 20,),
                      PasswordWithIcon(
                        icon: Icons.vpn_key,
                        hint: "Enter Password...",
                      )
                    ],
                  ),
                  Column( 
                    children: <Widget>[ 
                      PrimaryButton(
                        btnText: "Create Account",
                      ),
                      SizedBox( 
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        child: OutlineButton( 
                          btnText: "Back To Login",
                        ),
                      )
                    ],
                  ),
                ],
              ),
                ),
              ],
            ),
          ),
        );
      break;
        case LoginStatus.signIn:
        return HomeScreen();
      break;
    }
  }
}

class PasswordWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  PasswordWithIcon({this.icon, this.hint});
  @override
  _PasswordWithIconState createState() => _PasswordWithIconState();
}

class _PasswordWithIconState extends State<PasswordWithIcon> {
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  @override
  Widget build(BuildContext context) {
   return Container(
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
              widget.icon,
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
                hintText: widget.hint,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              widget.icon,
              size: 20,
              color: kGreyColor,
              ),
          ),
          
          Expanded(
            child: TextField( 
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({ 
    this.btnText
  });

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
        color: kMainColor,
        borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center( 
        child: Text(
          widget.btnText,
          style: GoogleFonts.openSans( 
            color: kWhiteColor,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}

class OutlineButton extends StatefulWidget {
  final String btnText;
  OutlineButton({ 
    this.btnText
  });

  @override
  _OutlineButtonState createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          widget.btnText,
          style: GoogleFonts.openSans( 
            color: kMainColor,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}


