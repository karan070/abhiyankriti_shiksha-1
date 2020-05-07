import 'package:alpine/Syllabus/sem_syllabus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpine/model/department.dart';

class dept_syllabus_page extends StatefulWidget {
  @override
  _dept_syllabus_pageState createState() => _dept_syllabus_pageState();
}

class _dept_syllabus_pageState extends State<dept_syllabus_page> {

  List dept;

  @override
  void initState(){
    dept = getdept();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Department department) => ListTile(
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
        department.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              child: Text(department.school, style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)))
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
      onTap: (){
        String dept = department.title;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => sem_syllabus_screen(dept)));
      },
    );


    Card makeCard (Department department) => Card(
      elevation: 10.0,
      margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(department),
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          title: Text("Departments"),
          elevation: 0.1,
        ),
        backgroundColor: Color.fromRGBO(58,66,86,1.0),
        body: Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dept.length ,
                itemBuilder: (BuildContext context , int index) {
                  return makeCard(dept[index]);
                }
            )
        )
    );
  }
}

List getdept(){
  return [
    Department(
        title: "Civil Engineering",
        school: "School of Civil Engineering",
        content: "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."
    ),
    Department(
        title: "Computer Science Engineering",
        school: "School of Computing and Information Technology",
        content: "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."
    ),
    Department(
        title: "Electrical Engineering",
        school: "School of Electrical and Electronics Engineering",
        content: "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."
    ),
    Department(
        title: "Mechanical Engineering",
        school: "School of Mechanincal Engineering",
        content: "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."
    ),
  ];
}