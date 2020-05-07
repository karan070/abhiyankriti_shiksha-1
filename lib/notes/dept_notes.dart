import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpine/model/department.dart';
import 'package:alpine/notes/notes_civil.dart';
import 'package:alpine/notes/notes_cs.dart';
import 'package:alpine/notes/notes_electrical.dart';
import 'package:alpine/notes/notes_mech.dart';
import 'package:alpine/screens/semester.dart';

class dept_notes extends StatefulWidget {
  @override
  _dept_notesState createState() => _dept_notesState();
}

class _dept_notesState extends State<dept_notes> {

  List dept;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Department"),
        centerTitle: true,
        elevation: 0.1,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Colors.teal))),
                    child: Icon(Icons.school, color: Colors.teal),
                  ),
                  isThreeLine: true,

                  title: Text(
                    "Civil Engineering",
                    style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                  ),
                  enabled: true,
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("School of Civil Engineering", style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)))
                    ],
                  ),
                  trailing:
                  Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                  onTap: (){
                    String dept = "Civil Engineering";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sub_civil(dept)));
                  },
                ),
              ),
            ),
            Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Colors.teal))),
                    child: Icon(Icons.school, color: Colors.teal),
                  ),
                  isThreeLine: true,

                  title: Text(
                    "Computer Science Engineering",
                    style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                  ),
                  enabled: true,
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("School of Computing and Information Technology", style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)))
                    ],
                  ),
                  trailing:
                  Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                  onTap: (){
                    String dept = "Computer Science Engineering";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sub_cs(dept)));
                  },
                ),
              ),
            ),
            Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Colors.teal))),
                    child: Icon(Icons.school, color: Colors.teal),
                  ),
                  isThreeLine: true,

                  title: Text(
                    "Electrical Engineering",
                    style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                  ),
                  enabled: true,
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("School of Electrical and Electronics Engineering", style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)))
                    ],
                  ),
                  trailing:
                  Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                  onTap: (){
                    String dept = "Electrical Engineering";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sub_electrical(dept)));
                  },
                ),
              ),
            ),
            Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Colors.teal))),
                    child: Icon(Icons.school, color: Colors.teal),
                  ),
                  isThreeLine: true,

                  title: Text(
                    "Mechanical Engineering",
                    style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold),
                  ),
                  enabled: true,
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("School of Mechanincal Engineering", style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)))
                    ],
                  ),
                  trailing:
                  Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                  onTap: (){
                    String dept = "Mechanical Engineering";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sub_mech(dept)));
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

