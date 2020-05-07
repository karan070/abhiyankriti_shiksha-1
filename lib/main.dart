import 'package:alpine/Syllabus/Dept_Syllabus.dart';
import 'package:alpine/Syllabus/download_syllabus.dart';
import 'package:alpine/Syllabus/sem_syllabus.dart';
import 'package:alpine/assignment/dept_assign.dart';
import 'package:alpine/assignment/upload_review_screen.dart';
import 'package:alpine/attendance/att_screen.dart';
import 'package:alpine/attendance/check_attendance.dart';
import 'package:alpine/attendance/view_def_list.dart';
import 'package:alpine/profile.dart';
import 'package:alpine/screens/dept.dart';
import 'package:alpine/screens/download.dart';
import 'package:alpine/screens/semester.dart';
import 'package:alpine/tests/result_screen.dart';
import 'package:alpine/tests/take_quiz.dart';
import 'package:alpine/video_conferencing/video.dart';
import 'package:flutter/material.dart';
import 'package:alpine/loginpage.dart';
import 'package:alpine/homepage.dart';
import 'package:alpine/signuppage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'assignment/sem_assign.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  final FirebaseMessaging _messaging = new FirebaseMessaging();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58,66,86,1.0)
      ),
      debugShowCheckedModeBanner: false,
      home: login_page(),
      routes: <String , WidgetBuilder>{
        '/landingpage' : (BuildContext context) => new MyApp(),
        '/loginpage' : (BuildContext context) => new login_page(),
        '/signup' : (BuildContext context) => new signup_page(),
        '/homepage' : (BuildContext context) => new HomePage(),
        '/department' : (BuildContext context) => new dept_page(),
        '/dept_syllabus' : (BuildContext context) => new dept_syllabus_page(),
        '/take_test' : (BuildContext context) => new take_quiz(),
        '/dept_Assign' : (BuildContext context) => new dept_assign_page(),
        '/result_screen' : (BuildContext context) => new results(),
        '/profile' : (BuildContext context) => new profile(),
        '/attendance' : (BuildContext context) => new check_att(),
        '/choose_att' : (BuildContext context) => new upload_att(),
        '/def_list' : (BuildContext context) => new view_list(),
        '/video' : (BuildContext context) => new video()
      },
    );
  }
}
