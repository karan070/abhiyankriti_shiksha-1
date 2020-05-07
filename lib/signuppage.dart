import 'package:alpine/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


final FirebaseAuth mAuth = FirebaseAuth.instance;

class signup_page extends StatefulWidget {
  @override
  _signup_pageState createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  bool _showpwd = false;
  final _formkey = GlobalKey<FormState>();
  bool _isTapped ;

  TextEditingController _fullname = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _year = new TextEditingController();
  TextEditingController _sem = new TextEditingController();
  TextEditingController _dept = new TextEditingController();
  TextEditingController _reg_no = new TextEditingController();


  final FirebaseMessaging _mess = FirebaseMessaging();
  String tok;

  String getToken(){
    _mess.getToken().then((token){
      tok = token;
      Tokenz();
    });
  }

  void Tokenz() async{
    final databaseReference = Firestore.instance;
    DocumentReference ref = await databaseReference.collection('pushtokens').add({
      'devtoken' : tok,
    });
    print(ref.documentID);
  }



  @override
  void initState(){
    super.initState();
    _isTapped = false;
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



  Future adduser() async{
    var _userdetails = Map<String, String>();
    _userdetails["Name"] = _fullname.text;
    _userdetails["Registration Number"] = _reg_no.text;
    _userdetails["email"] = _email.text;
    _userdetails["password"] = _password.text;
    _userdetails["Date of birth"] = _dob.text;
    _userdetails["Year"] = _year.text;
    _userdetails["Semester"] = _sem.text;
    _userdetails["Department"] = _dept.text;

    await Firestore.instance.collection("Student User").document(_email.text).setData(_userdetails).whenComplete(() {
      setState(() {
        _isTapped = false;
        print('data pushed');
      });
      _shDialog();
    });
  }

  void _shDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("User Added"),
            actions: <Widget>[
              FlatButton(
                child: Text("Go to Login"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: new Text("Sign Up Page"),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.of(context).pushReplacementNamed('/landingpage') ),
      ),
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
            padding: EdgeInsets.only(top: 50.0),
            child: SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    height: 200,
                    color: Colors.grey,
                    image: new AssetImage('assets/applogo.png'),
                    fit: BoxFit.fitWidth,
                    colorBlendMode: BlendMode.darken,
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
                                labelText: "Enter Full Name",
                                hintText: "eg. Mark Zuckerberg",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _fullname,
                            validator: (value){
                              if(value.isEmpty){
                                return "Cannot be left empty";
                              }else{
                                return null;
                              }
                            },
                          ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter Registration Number",
                                  hintText: "eg. 10345",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.number,
                              controller: _reg_no,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter e-mail",
                                hintText: "Enter e-mail eg. xyz@abc.cm",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            new Padding(
                              padding: EdgeInsets.only( bottom: 10.0),
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter Password",
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
                              controller: _password,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            new Padding(
                                padding: EdgeInsets.only(bottom:10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter Date of Birth",
                                  hintText: " eg. 12/12/2012",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.datetime,
                              controller : _dob,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            new Padding(
                                padding : EdgeInsets.only(bottom: 10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter Year",
                                  hintText: " eg. 3",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.number,
                              controller: _year,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            Padding(
                                padding : EdgeInsets.only(bottom: 10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter Semester",
                                  hintText: " eg. 5",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.number,
                              controller: _sem,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10.0)
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Enter your Department",
                                  hintText: " eg. Computer Science",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                  )
                              ),
                              keyboardType: TextInputType.text,
                              controller: _dept,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Cannot be left empty";
                                }else{
                                  return null;
                                }
                              },
                            ),
                            new Padding(
                                padding: EdgeInsets.only(bottom:50.0)
                            ),
                            new MaterialButton(
                                disabledColor: Colors.teal,
                                height: 40.0,
                                minWidth: 100.0,
                                color: Colors.teal,
                                splashColor: Colors.white,
                                child:(_isTapped) ? SizedBox(
                                  height: 40.0,
                                  width: 100.0,
                                  child: SpinKitWave(
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ): Text('Sign up', style: TextStyle(color: Colors.white),),
                                textColor: Colors.white,
                                onPressed: (!_isTapped) ? (){
                                  if(_formkey.currentState.validate()){
                                    setState(() {
                                      _isTapped = true;
                                    });
                                    adduser().whenComplete((){
                                      signUpWithEmailAndPwd();
                                      getToken();
                                    });
                                  }
                                } : null,
                            ),
                            ]),
                            ),
                    ),
                  )],
                      ),
                    ),
                  )
                ],
              ),
            );
  }
  Future<String> signUpWithEmailAndPwd() async {
    FirebaseUser user;
    try {
      user = (await mAuth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text)).user;
      try {
        await user.sendEmailVerification();
        return user.uid;
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }
    }catch(e){
      print(e);
    }
  }
}

