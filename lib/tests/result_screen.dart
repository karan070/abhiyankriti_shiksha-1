import 'package:alpine/tests/take_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alpine/homepage.dart';

class results extends StatefulWidget {
  @override
  _resultsState createState() => _resultsState();
}

class _resultsState extends State<results> {

  bool isTapped ;

  @override
  void initState(){
    isTapped = false;
    super.initState();
  }


    _shDialog() {
     showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Your Result has been recorded"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void Result() async{
    var _details = Map<String,String>();
    _details['Name'] = name;
    _details['Reg. No'] = reg_no;
    _details['Marks'] = correctAns.toString();
    _details['Total Questions'] = total_ques.toString();
    _details['Percentage'] = ((correctAns/total_ques)*100).toString();
    await Firestore.instance.collection('Result_$code_sub').document(reg_no).setData(_details).whenComplete((){
      setState(() {
        isTapped = false;
      });
      _shDialog();
    });

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58,66,86,1.0),
        appBar: AppBar(
          title: Text("Result",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          elevation: 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Center(
                    child: Image(
                        image: new AssetImage('assets/trophy.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 80.0,),
                  Text("YOUR SCORE : " , style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold),),
                  SizedBox(height: 40.0,),
                  Text("$correctAns"+"/"+"$total_ques",style: TextStyle(color: Colors.white,fontSize: 50.0)),
                  SizedBox(height: 80.0,),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                        disabledColor: Colors.teal,
                      color: Colors.teal,
                      child: (isTapped)
                          ? SpinKitWave(
                        size: 20.0,
                        color: Colors.white,
                      )
                          : Text(
                        "Done",
                        style: TextStyle(color: Colors.white, ),
                      ),
                      onPressed: (!isTapped)?(){
                        setState(() {
                          isTapped = true;
                        });
                        Result();
                      } : null
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        
      ),
    );
  }
}
