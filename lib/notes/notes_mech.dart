import 'package:flutter/material.dart';
import 'open_notes.dart';

class sub_mech extends StatefulWidget {

  final String dept;
  sub_mech(this.dept , {Key key}) : super(key: key);

  @override
  _sub_mechState createState() => _sub_mechState();
}

class _sub_mechState extends State<sub_mech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Subjects"),
        centerTitle: true,
        elevation: 0.1,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.teal))),
                  child: Icon(Icons.school, color: Colors.teal),
                ),
                title: Text(
                  "Engineering Graphics",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Engineering Graphics";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => open_notesPage(widget.dept , sub)));
                },
              ),
            ),
          ),
          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.teal))),
                  child: Icon(Icons.school, color: Colors.teal),
                ),
                title: Text(
                  "Kinematics",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Kinematics";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => open_notesPage(widget.dept , sub)));
                },
              ),
            ),
          ),
          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.teal))),
                  child: Icon(Icons.school, color: Colors.teal),
                ),
                title: Text(
                  "Thermodynamics",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Thermodynamics";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => open_notesPage(widget.dept , sub)));
                },
              ),
            ),
          ),
          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.teal))),
                  child: Icon(Icons.school, color: Colors.teal),
                ),
                title: Text(
                  "Fluid Mechanics",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Fluid Mechanics";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => open_notesPage(widget.dept , sub)));
                },
              ),
            ),
          ),
        ],
      ),


    );
  }
}
