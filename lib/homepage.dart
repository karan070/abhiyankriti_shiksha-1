import 'package:alpine/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpine/screens/dept.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'notes/dept_notes.dart';

var name;
var reg_no;
var email;
var dob;
var sem;
var year;
var dept;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
      getUserdata().whenComplete((){
        print("User details recieved");
      });

    super.initState();
  }

  Future getUserdata() async{
    DocumentReference docs = Firestore.instance.collection('Student User').document(e_mail);
    await docs.get().then((datasnapshot){
      if(datasnapshot.exists){
        name = datasnapshot.data['Name'].toString();
        reg_no = datasnapshot.data['Registration Number'].toString();
        email = datasnapshot.data['email'].toString();
        dob = datasnapshot.data['Date of birth'].toString();
        sem = datasnapshot.data['Semester'].toString();
        year = datasnapshot.data['Year'].toString();
        dept = datasnapshot.data['Department'].toString();
        print("Done");
      }
      else{
        print("No such User");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return null;
      },
      child: new Scaffold(
        backgroundColor: Color.fromRGBO(58,66,86,1.0),
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            elevation: 10.0,
            title: new Text('DASHBOARD',style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w300
            ),),
            centerTitle: true,
          ),
          body: Stack(
            children:<Widget>[

              Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(3.0),
                children: <Widget>[
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/dept_Assign');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.import_contacts,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('ASSIGNMENT',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/choose_att');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.border_color,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('ATTENDANCE',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  makeDashboardItem("NOTES", Icons.note),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/profile');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('PROFILE',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/dept_syllabus');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.format_list_bulleted,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('SYLLABUS',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/take_test');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.content_paste,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('TESTS',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/department');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.book,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 20.0),
                              new Center(
                                child: new Text('TIME TABLE',
                                    style:
                                    new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                      )),
                  Card(
                      elevation: 9.0,
                      margin: new EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1.0),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/video');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                    Icons.videocam,
                                    size: 40.0,
                                    color: Colors.teal,
                                  )),
                              SizedBox(height: 10.0),
                              new Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('VIDEO',
                                        style:
                                        new TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400)),
                                    new Text('CONFERENCING',
                                        style:
                                        new TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),

                ],
              ),
              ),
          ]),
          ),
    );
  }
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        color: Color.fromRGBO(58,66,86,1.0),
        elevation: 9.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0),
          borderRadius: BorderRadius.circular(5.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => dept_notes()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.teal,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w400)),
                )
              ],
            ),
          ),
        ));
  }
}