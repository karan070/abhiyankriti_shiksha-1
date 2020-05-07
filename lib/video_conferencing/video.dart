import 'package:alpine/video_conferencing/src/pages/index.dart';
import 'package:flutter/material.dart';

class video extends StatefulWidget {
  @override
  _videoState createState() => _videoState();
}

class _videoState extends State<video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Conferencing"),
        centerTitle: true,
        elevation: 0.1,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: IndexPage(),
    );
  }
}
