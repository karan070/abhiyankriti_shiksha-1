import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


String file = "Syllabus/${department}_${semesterr}_Syllabus.pdf";
String fileName = "${department} ${semesterr} Syllabus";
String department;
String semesterr;
bool isTapped = false;
String pdfurl;
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class downloadSyllabusPage extends StatefulWidget {

  final String department;
  final String semesterr;
  downloadSyllabusPage(this.department , this.semesterr , {Key key}) : super(key: key);

  @override
  _downloadSyllabusPageState createState() => _downloadSyllabusPageState();
}

class _downloadSyllabusPageState extends State<downloadSyllabusPage> {

  static String pathPDF = "";
  static String pdfUrl = "";
  String url;

  void initState(){
    print("${widget.department}_${widget.semesterr}");
    department = widget.department;
    semesterr = widget.semesterr;
    super.initState();

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
            context, "${department} ${semesterr} Syllabus.pdf", pathPDF, pdfUrl);
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
        title: new Text("Syllabus"),
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
                      file = "Syllabus/${department}_${semesterr}_Syllabus.pdf";
                    });
                    _getPdf(file);
                  },
                  child: (isTapped)?SizedBox(width:50,child: SpinKitWave(color: Colors.white,size: 16,)):Text("Open Syllabus",style: TextStyle(color: Colors.white),)
              ),

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
    final filename = '${department}_${semesterr}_Syllabus.pdf'; //I did it on purpose to avoid strange naming conflicts
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