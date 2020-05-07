import 'package:alpine/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'test_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

int correctAns = 0;
int total_ques = 0;
var code_sub ;

class take_quiz extends StatefulWidget {
  @override
  _take_quizState createState() => _take_quizState();
}

class _take_quizState extends State<take_quiz> {

  TextEditingController sub_code = new TextEditingController();
  bool isTapped = false;
  bool spinEnabled = false;
  bool started = false;
  DocumentSnapshot datasnapshot;
  DocumentSnapshot check;
  var lst = [3,4,1,2];
  int group=0;
  bool isComplete = false;
  List<int> _selectedRadioTile;
  List<String> _answer;
  List<String> _ans = [] ;
  var equal;
  var shuff = 0;
  bool back = true;
  bool damn = true;
  bool disable_button = false;
  var ok;

  @override
  void initState(){
    super.initState();
    correctAns = 0;
  }

  
  Future get_test(sub_code) async{
    var doc = Firestore.instance.collection('Tests').document(sub_code);
    datasnapshot = await doc.get();
    if(datasnapshot.exists){
      setState(() {
        isTapped = true;
        started = true;
        disable_button = true;
        spinEnabled = false;
        total_ques = int.parse(datasnapshot['NumberOfQues']);
      });
    }else{
      setState(() {
        isTapped=false;
        spinEnabled = false;
      });
      print("else ");
      _shDialog();
    }
  }

  Future checkTest(sub_code) async{
    var document = Firestore.instance.collection('Result_$sub_code').document(reg_no);
    check = await document.get();
    if(check.exists){
      print("Test already given");
      setState(() {
        spinEnabled = false;
      });
      _shDialog2();
    }
    else{
      print("First Time");
      get_test(sub_code);
    }
  }

  TestData getOptions(DocumentSnapshot documentSnapshot , index){
    TestData testdata = new TestData();

    testdata.question = documentSnapshot.data['Q${index+1}'];
    testdata.answer = documentSnapshot.data['Answer${index+1}'];
    _ans.add(testdata.answer);

    List<String> opt = [
      documentSnapshot.data['Option1.${index+1}'],
      documentSnapshot.data['Option2.${index+1}'],
      documentSnapshot.data['Option3.${index+1}'],
      documentSnapshot.data['Answer${index+1}']
    ];
    opt.shuffle();

    testdata.option1 = opt[0];
    testdata.option2 = opt[1];
    testdata.option3 = opt[2];
    testdata.option4 = opt[3];

    return testdata;
  }

  void _shDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("The Test doesn't exist"),
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

  void _shDialog2() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You have already submitted the Test."),
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


  Widget take_test() {
    return WillPopScope(
      onWillPop: (){
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            Container(
              child: CountdownFormatted(
                duration: Duration(minutes: 10),
                onFinish: (){
                  checkAns();
                  Navigator.of(context).pushNamed('/result_screen');
                },
                builder: (BuildContext ctx, String remaining) {
                  return Container(
                    height: MediaQuery.of(context).size.height*0.16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text("Time Remaining : ", style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.0,
                              fontWeight: FontWeight.w300
                            ),),
                        ),
                         SizedBox(height: 10.0,),
                         Flexible(
                           child: Text(" $remaining", style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold
                            ),),
                         ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60.0,),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: total_ques,
                itemBuilder: (context , index){
                 if(equal != total_ques){
                   equal = total_ques;
                   _selectedRadioTile = List.generate(total_ques, (index) => null);
                   _answer = List.generate(total_ques, (index) => null);
                 }
                  return testData(getOptions(datasnapshot, index),index , _selectedRadioTile , _answer);
                }
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: 40.0,
                width: 300,
                child: RaisedButton(
                    child: Text("Submit",style: TextStyle(fontSize: 18.0),),
                    onPressed: (){
                        checkAns();
                        Navigator.of(context).pushNamed('/result_screen');
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  int checkAns(){
    print(_ans);
    for(int i =0 ; i < _answer.length; i++){
      if(_answer[i] == _ans[i]){
        correctAns = correctAns + 1;
      }
    }
    print("Result : ${correctAns}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Take Test"),
        automaticallyImplyLeading: false,
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
        child: new ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal,width: 2.0),
                              borderRadius: BorderRadius.circular(10.0)
                          ),border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                          labelText: "Enter the Subject Code",
                          hintText: "eg. JAVA,C etc."
                      ),
                      controller: sub_code,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:10.0),
                      child: RaisedButton(
                          color: Colors.teal,
                          elevation: 3.0,
                          splashColor: Colors.white,
                          child: (spinEnabled) ? SizedBox(width: 40.0,child: SpinKitWave(
                            color: Colors.white,
                            size: 16.0,
                          ),)
                              :Text("Take Test",style: TextStyle(color: Colors.white),),
                          onPressed: () {
                              if(disable_button){
                              }
                              else{
                              setState(() {
                                spinEnabled = true;
                              });
                              checkTest(sub_code.text);
                              code_sub = sub_code.text;
                          }
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (isTapped) ? take_test() : SizedBox(),
          ],
        ),
      )
    );
  }
}

class testData extends StatefulWidget {

 final TestData test;
 final int index;
 final List<int> _selectedRadioTile;
 final List<String> _answer;
  testData( this.test, this.index , this._selectedRadioTile, this._answer , {Key key} ) : super(key : key);

  @override
  _testDataState createState() => _testDataState();
}

class _testDataState extends State<testData> {

  String optionSelected = "";
  int rightans;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.teal,
            width: 3.0,
          ),
        ),
        elevation: 8.0,
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0,),
                Text( "Q${widget.index+1} : " + widget.test.question,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 30.0,),
                RadioListTile(
                    title: Text(
                      widget.test.option1 , style: TextStyle(
                        color: Colors.white, fontSize: 18.0
                    ),),
                    value: 1,
                    groupValue: widget._selectedRadioTile[widget.index],
                    onChanged: (t) {
                      print(1);
                      setState(() {
                        widget._selectedRadioTile[widget.index] = t;
                        optionSelected = widget.test.option1;
                        widget._answer[widget.index] = optionSelected;
                        print(widget._answer);
                      });
                    }
                ),
                RadioListTile(
                    title: Text(
                      widget.test.option2 , style: TextStyle(
                        color: Colors.white, fontSize: 18.0
                    ),),
                    value: 2,
                    groupValue: widget._selectedRadioTile[widget.index],
                    onChanged: (t) {
                      print(2);
                      setState(() {
                        widget._selectedRadioTile[widget.index] = t;
                        optionSelected = widget.test.option2;
                        widget._answer[widget.index] = optionSelected;
                        print(widget._answer);
                      });
                    }
                ),
                RadioListTile(
                    title: Text(
                      widget.test.option3 , style: TextStyle(
                        color: Colors.white, fontSize: 18.0
                    ),),
                    value: 3,
                    groupValue: widget._selectedRadioTile[widget.index],
                    onChanged: (t) {
                      print(3);
                      setState(() {
                        widget._selectedRadioTile[widget.index] = t;
                        optionSelected = widget.test.option3;
                        widget._answer[widget.index] = optionSelected;
                        print(widget._answer);
                      });
                    }
                ),
                RadioListTile(
                    title: Text(
                      widget.test.option4 , style: TextStyle(
                        color: Colors.white, fontSize: 18.0
                    ),),
                    value: 4,
                    groupValue: widget._selectedRadioTile[widget.index],
                    onChanged: (t) {
                      print(4);
                      setState(() {
                        widget._selectedRadioTile[widget.index] = t;
                        optionSelected = widget.test.option4;
                        widget._answer[widget.index] = optionSelected;
                        print(widget._answer);
                      });
                    }
                ),
              ]
          ),
        )
    );
  }
}



