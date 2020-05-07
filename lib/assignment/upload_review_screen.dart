import 'package:alpine/homepage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:alpine/screens/semester.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

String file = "Assignment/${subject}_${department}_${semesterr}_Questions.pdf";
String fileName = "${subject} ${department} ${semesterr} Questions";
String department;
String semesterr;
String subject;
String pdfurl;
bool isTapped = false;
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class assignment extends StatefulWidget {

  final String department;
  final String semesterr;
  final String subject;
  assignment(this.department , this.semesterr , this.subject , {Key key}) : super(key : key);

  @override
  _assignmentState createState() => _assignmentState();
}

class _assignmentState extends State<assignment> {

  static String pathPDF = "";
  static String pdfUrl = "";


  bool isTapped = false;
  bool isTapped2 = false;
  String url;
  File file2;
  String _uploadedFileURL;

  void initState(){
    subject = widget.subject;
    semesterr = widget.semesterr;
    department = widget.department;
    super.initState();
  }

  Future getFile() async {
    var tempfile = await FilePicker.getFile(type: FileType.any);
    setState(() {
      file2 = tempfile;
    });
    (file2 == null) ? print("EMpty") : print("got it here");

  }

  Future uploadFile(File file)  async{
    StorageReference ref = FirebaseStorage.instance.ref().child("Assignment Solutions/${subject}_${reg_no}_Solution.pdf");
    await ref.putFile(file2).onComplete;
    print("OKay done");
  }

  int count;

  Future upload_details() async{
    await Firestore.instance.collection("${department}_${semesterr}").document(subject).get().then((val){
       count = val.data["Number Of Fields"];
       print(count);
    }).whenComplete((){
       Firestore.instance.collection("${department}_${semesterr}").document(subject).updateData({
        "Number Of Fields" : FieldValue.increment(1),
        "Student ${count} " : reg_no
      });
    });

  }



  _getPdf(file){
    LaunchFile.loadFromFirebase(context, file).then((pdfurl) {
      setState(() {
        url = pdfurl;
      });
      print("Hi");
      print(url);
      LaunchFile.createFileFromPdfUrl(url).then((f) {
        setState(() {
          if (f is File) {
            pathPDF = f.path;
          }
        },
        );
      }).whenComplete((){
        setState(() {
          isTapped = false;
        });
        LaunchFile.launchPDF(
            context, "${subject} ${department} ${semesterr} Questions.pdf", pathPDF, pdfUrl);
      }
      );
    }).catchError((e){
      setState(() {
        isTapped = false;
      });
      print("Error");
      Fluttertoast.showToast(
          msg: "No File to Display!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: new AppBar(
        title: new Text("Assignment"),
        elevation: 0.1,
        centerTitle: true,
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
                  onPressed: (isTapped)?(){}:(){
                    setState(() {
                      isTapped = true;
                      file = "Assignment/${subject}_${department}_${semesterr}_Questions.pdf";
                    });
                    _getPdf(file);
                  },
                  child: (isTapped)?SizedBox(width:50,child: SpinKitWave(color: Colors.white,size: 16,)):Text("Open Assignment Questions",style: TextStyle(color: Colors.white),)
              ),
              SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
                  Expanded(
                      child: Divider(color: Colors.white,)
                  ),
                  Padding(padding: EdgeInsets.all(5.0),),
                  Text("OR",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Expanded(
                      child: Divider(color: Colors.white,)
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
                ],
              ),
              SizedBox(height: 30.0,),
              FlatButton(
                  splashColor: Colors.white,
                  color:Colors.teal,
                  onPressed:() async{
                    setState(() {
                      isTapped2 = true;
                    });
                    await getFile();
                    if(file2 == null){
                      setState(() {
                        isTapped2 = false;
                      });
                      Fluttertoast.showToast(
                          msg: "No File Selected!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.teal,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else{
                      uploadFile(file2).whenComplete((){
                        setState(() {
                          isTapped2 = false;
                        });
                        upload_details();
                        Fluttertoast.showToast(
                            msg: "File Uploaded!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      );
                    }
                  },
                  child:(isTapped2) ? Container(
                    height: 40.0,
                    width: 100.0,
                    color: Colors.teal,
                    child: SpinKitWave(
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ) :Text('Upload Solution',style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
class LaunchFile {
  static void launchPDF(
      BuildContext context, String title, String pdfPath, String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(title, pdfUrl),
      ),
    );
  }



  static Future<dynamic> loadFromFirebase(
      BuildContext context, String url) async {
    return FireStorageService.loadFromStorage(context, file) ;
  }

  static Future<dynamic> createFileFromPdfUrl(dynamic url) async {
    final filename = "${subject} ${department} ${semesterr} Questions" ; //I did it on purpose to avoid strange naming conflicts
    print(filename);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

class PDFScreen extends StatefulWidget {

  String title;
  String pdurl;
  PDFScreen(this.title ,this.pdurl , {Key key}) : super(key :key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  PDFDocument _doc;
  bool isok = false;

  @override
  void initState() {
    print(pdfurl);
    super.initState();
    loadDocument();
  }

  Future <void> loadDocument() async {
    setState(() {
      isok = true;
    });
    final doc =  await PDFDocument.fromURL(pdfurl);
    setState(() {
      _doc = doc;
      isok = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isok ? Center(child: CircularProgressIndicator(),) :
      PDFViewer(document: _doc,),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService._();
  FireStorageService();

  static Future<dynamic> loadFromStorage(
      BuildContext context, String file) async {
    print(file);
    print("Henloooooo");
    print( await FirebaseStorage.instance.ref().child(file).getDownloadURL());
    pdfurl = await FirebaseStorage.instance.ref().child(file).getDownloadURL();
    print("Hi $pdfurl");
    return pdfurl;
  }
}