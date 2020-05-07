import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final FirebaseAuth mAuth = FirebaseAuth.instance;
var e_mail;



class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> with SingleTickerProviderStateMixin {

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _showpwd = false;
  bool isTapped = false;
  final _formkey = GlobalKey<FormState>();


  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;


  @override
  void initState(){
    super.initState();
    isTapped = false;
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 200)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.bounceInOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

  Future<void> sendResetLink (String email) async{
    await mAuth.sendPasswordResetEmail(email: email);
  }


  void _shDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please Enter your email"),
            actions: <Widget>[
              FlatButton(
                child: Text("Go to Login"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _shDialog2() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Reset email sent!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _shDialog3() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email or password entered is wrong or doesn't exist."),
            actions: <Widget>[
              FlatButton(
                child: Text("Go to Login"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isTapped = false;
                  });
                },
              )
            ],
          );
        });
  }

  void _shDialog4() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email not verified"),
            actions: <Widget>[
              FlatButton(
                child: Text("Go to Login"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isTapped = false;
                  });
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('assets/okay.jpg'),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            padding: EdgeInsets.only(top: 120.0),
            child: SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    height: 80.0,
                  ), new Image(
                    height: 200,
                    color: Colors.grey,
                    image: new AssetImage('assets/applogo.png'),
                    fit: BoxFit.fitWidth,
                    colorBlendMode: BlendMode.darken,
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.teal,
                                fontSize: 20.0
                            )
                        )
                    ),
                    child: Form(
                      key: _formkey,
                      child: new Container(
                        padding: EdgeInsets.all(40.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "E-mail",
                                  hintText: "Enter e-mail eg. xyz@abc.cm",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller : _email,
                              validator: (value){
                                  if(value.isEmpty){
                                    return "Cannot be left empty";
                                  }else{
                                    return null;
                                  }
                              },
                            ),
                            new Padding(
                              padding: EdgeInsets.only(top:10.0 , bottom: 10.0),
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Password",
                                  hintText: "Must be above 6 characters",
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _showpwd =! _showpwd;
                                      });
                                    },
                                    child: Icon(
                                        _showpwd? Icons.visibility : Icons.visibility_off
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: !_showpwd,
                              controller : _password,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            new Padding(
                                padding: EdgeInsets.only(top:40.0)
                            ),
                            Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                  child: Text("Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.teal
                                  ),
                                  ),
                                  splashColor: Colors.white,
                                  hoverColor: Colors.white,
                                  focusColor: Colors.white,
                                  onTap: (){
                                    if(_email.text.isNotEmpty){
                                    sendResetLink(_email.text).whenComplete((){
                                      _shDialog2();
                                    });}else{
                                      _shDialog();
                                    }
                                  },
                                ),
                            ),
                            new SizedBox(
                              height: 18.0,
                            ),
                            new MaterialButton(
                                height: 40.0,
                                minWidth: 100.0,
                                color: Colors.teal,
                                splashColor: Colors.white,
                              child:(isTapped) ? Container(
                                height: 40.0,
                                width: 100.0,
                                color: Colors.teal,
                                child: SpinKitWave(
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ): Text('Login as a Student', style: TextStyle(color: Colors.white),),
                                textColor: Colors.white,
                                onPressed: (!isTapped) ? (){
                                  if(_formkey.currentState.validate()){
                                    setState(() {
                                      isTapped = true;
                                    });
                                      loginWithEmailandPwd();
                                  }
                                } : null,
                            ),
                            new Padding(
                              padding: EdgeInsets.only(top:14.0),
                            ),
                            new Text("Don't have an account?",style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                            new Padding(
                              padding: EdgeInsets.only(bottom: 14.0),
                            ),
                            new MaterialButton(
                                height: 40.0,
                                minWidth: 100.0,
                                color: Colors.teal,
                                splashColor: Colors.white,
                                child: new Text("Sign Up as a Student"),
                                textColor: Colors.white,
                                onPressed: (){
                                  Navigator.of(context).pushNamed('/signup');
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<String> loginWithEmailandPwd() async {
    FirebaseUser user;
      try{ user = (await mAuth.signInWithEmailAndPassword(
        email: _email.text, password: _password.text)).user;
    if (user.isEmailVerified) {
      e_mail = _email.text;
      Navigator.of(context).pushNamed('/homepage');
      return user.uid;
    }
    else {
      print("Error lol");
      _shDialog4();
    }}catch(e){
        isTapped = false;
        _shDialog3();
        print(e.toString());
      }
  }
}


