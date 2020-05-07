import 'package:alpine/assignment/upload_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class sub_assign extends StatefulWidget {

  final String department;
  final String semesterr;
  sub_assign(this.department , this.semesterr, {Key key}) : super(key : key);

  @override
  _sub_assignState createState() => _sub_assignState();
}

class _sub_assignState extends State<sub_assign> {


  TextEditingController _subject = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isTapped ;


  void initState(){
    print(widget.department);
    print(widget.semesterr);
    _isTapped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose the Subject"),
        centerTitle: true,
        elevation: 0.1,
      ),
      backgroundColor: Color.fromRGBO(58,66,86,1.0),
      body: Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.teal,
              splashColor: Colors.teal,
              inputDecorationTheme: new InputDecorationTheme(
                  labelStyle: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                  )
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formkey,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal,width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            labelText: "Enter the Subject Code",
                            hintText: "eg. CS01JAVA , CS02C etc."
                        ),
                        cursorColor: Colors.teal,
                        controller: _subject,
                        validator: (value){
                          if(value.isEmpty){
                            return "Cannot be left empty";
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
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
                ): Text('Submit', style: TextStyle(color: Colors.white),),
                textColor: Colors.white,
                onPressed: (!_isTapped) ? (){
                  if(_formkey.currentState.validate()){
                    setState(() {
                      _isTapped = true;
                    });
                    String Dept = widget.department;
                    String semesterr = widget.semesterr;
                    String subject = _subject.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => assignment(Dept , semesterr , subject))).whenComplete((){
                              setState(() {
                                _isTapped = false;
                              });
                    });
                  }
                } : null,
              ),
            ],
          )
      ),
    );
  }
}

