import 'package:flutter/material.dart';

class upload_att extends StatefulWidget {
  @override
  _upload_attState createState() => _upload_attState();
}

class _upload_attState extends State<upload_att> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58,66,86,1.0),
      appBar: AppBar(
        title: Text("Attendance"),
        centerTitle: true,
        elevation: 0.1,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  splashColor: Colors.white,
                  color: Colors.teal,
                  onPressed:(){
                    Navigator.of(context).pushNamed('/attendance');
                  },
                  child: Text(
                    "Check Attendance",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  ),
                  Expanded(
                      child: Divider(
                        color: Colors.white,
                      )),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Expanded(
                      child: Divider(
                        color: Colors.white,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                  splashColor: Colors.white,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/def_list');
                  },
                  child: Text('View Defaulters List',
                      style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
