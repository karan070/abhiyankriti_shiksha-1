import 'package:flutter/material.dart';
import 'open_notes.dart';

class sub_civil extends StatefulWidget {

  final String dept;
  sub_civil(this.dept, {Key key}) : super(key: key);

  @override
  _sub_civilState createState() => _sub_civilState();
}

class _sub_civilState extends State<sub_civil> {

  void initState(){
    super.initState();
    print(widget.dept);
  }

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
                  "Building Technology",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Building Technology";
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
                  "Construction Engineering",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Construction Engineering";
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
                  "Coastal Engineering",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Coastal Engineering";
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
                  "Material Science and Engineering",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                onTap: () {
                  String sub = "Material Science and Engineering";
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
