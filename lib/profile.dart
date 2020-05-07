import 'package:alpine/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {



  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0.1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
                SizedBox(
                  height : 20.0
                ),
              Center(
                child: new CircularProfileAvatar(
                  '',
                  radius: 80,
                  backgroundColor: Colors.teal,
                  borderWidth: 10,
                  borderColor: Colors.white,
                  elevation: 5.0,
                  foregroundColor: Colors.grey.shade800,
                  initialsText: Text(name[0],style: TextStyle(color: Colors.white,fontSize: 70.0),),
                  cacheImage: true,
                  onTap: (){
                  },
                  showInitialTextAbovePicture: true,
                )
              ),
              SizedBox(height: 30.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      name !=null ? name: ' ',
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 15.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.recent_actors,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      reg_no!=null ? reg_no:' ',
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 15.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      email!=null? email:' ',
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 15.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.cake,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      dob!=null? dob: '',
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 15.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.content_paste,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      dept!=null?dept:'',
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 15.0,),
              Card(
                  color: Colors.teal,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      " Year : $year :: Semester : $sem",
                      style:
                      TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
              SizedBox(height: 20.0,),
              Container(
                height: 40.0,
                width: 200.0,
                child: RaisedButton(
                  splashColor: Colors.white,
                  color: Colors.teal,
                 textColor: Colors.white,
                  child: Text('Log Out',style: TextStyle(color: Colors.white,),) ,
                 onPressed: (){
                   FirebaseAuth.instance.signOut().then((value) {
                     Navigator.of(context).pop();
                     Navigator.of(context).pop();
                     Navigator
                         .of(context)
                         .pushReplacementNamed('/loginpage');
                   }).catchError((e) {
                     print(e);
                   });
                 },
                ),
              ),
              SizedBox(height: 50.0,)
            ],
          ),
        ),
      )
    );
  }
}
