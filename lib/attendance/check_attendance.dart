import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class check_att extends StatefulWidget {
  @override
  _check_attState createState() => _check_attState();
}

class _check_attState extends State<check_att> {

  TextEditingController _name = new TextEditingController();
  bool isTapped = false;
  bool isTapped2 = false;
  DocumentSnapshot datasnapshot;

  void _shDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Student doesn't exist"),
            actions: <Widget>[
              FlatButton(
                child: Text("Return"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  Future getAttendance(_name) async{
    var doc = Firestore.instance.collection('Attendance').document(_name);
    datasnapshot = await doc.get();
    if(datasnapshot.exists){
      setState(() {
        isTapped2 = true;
        isTapped = false;
      });
    }else{
      setState(() {
        isTapped2=false;
        isTapped = false;
      });
      _shDialog();
    }
  }

  Widget att() {
    return  Column(
      children: <Widget>[
        SizedBox(height: 20.0,),
        Center(child: Text("Name of Student: " + datasnapshot['Name of student'],style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),
        SizedBox(height: 15.0,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70.0,
          child: Card(
            elevation: 7.0,
            color: Color.fromRGBO(58, 66, 86, 1.0),
            margin: new EdgeInsets.symmetric(horizontal: 2.0, vertical:  3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Text('Subject'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Text("Present"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Text('Absent'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: Text('Percentage'),
                )
              ],
            ),
          ),
        ),
        ListView.builder(
              shrinkWrap: true,
              itemCount: int.parse(datasnapshot["NumberOfSub"]),
              itemBuilder: (context , index){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70.0,
                  child: Card(
                    elevation: 7.0,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                    margin: new EdgeInsets.symmetric(horizontal: 1.0, vertical:  3.0),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width*0.2,
                            child: Text(datasnapshot['Subject'+(index+1).toString()]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            child: Text(datasnapshot['Present'+(index+1).toString()]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            child: Text(datasnapshot['Absent'+(index+1).toString()]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            child: Text('${datasnapshot['Percentage'+'${index+1}']}%'),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text("Attendance"),
          centerTitle: true,
          elevation: 0.1,
        ),
        body: Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.teal,
              splashColor: Colors.teal,
              inputDecorationTheme: new InputDecorationTheme(
                  labelStyle: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                  )
              )
          ),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal,width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)
                            ),border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                            labelText: "Enter the Registration Number",
                            hintText: "eg. 123456"
                        ),
                        cursorColor: Colors.teal,
                        controller: _name,
                      ),
                      SizedBox(height: 15.0,),
                      RaisedButton(
                        color: Colors.teal,
                        splashColor: Colors.white,
                        child: (isTapped) ? SizedBox(width:50,child: SpinKitWave(color: Colors.white,size: 16,)): Text("Search",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          setState(() {
                            isTapped = true;
                          });
                          getAttendance(_name.text);
                        },
                      ),
                      (isTapped2) ? att() : SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}

