import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';


String file = "Notes/${department}_${sub}_Notes.pdf";
String fileName = "${department} ${sub} Notes";
String department;
String sub;
bool isTapped = false;
String pdfurl;
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class open_notesPage extends StatefulWidget {

  final String department;
  final String sub;
  open_notesPage(this.department , this.sub , {Key key}) : super(key: key);

  @override
  _open_notesPageState createState() => _open_notesPageState();
}

class _open_notesPageState extends State<open_notesPage> {

  static String pathPDF = "";
  static String pdfUrl = "";
  String url;

  void initState(){
    print("${widget.department}_${widget.sub}");
    department = widget.department;
    sub = widget.sub;
    super.initState();

  }

  _getPdf(file){
    LaunchFile.loadFromFirebase(context, file).then((pdfurl) {
      setState(() {
        url = pdfurl;
      });
      print("Hi");
      print(url);
      print("Got the url");
      LaunchFile.createFileFromPdfUrl(url).then((f) {
        setState(() {
          if (f is File) {
            print("create file executed");
            pathPDF = f.path;
            print(f.path);
          }
        },
        );
      }).whenComplete((){
        setState(() {
          print("file from url created");
          isTapped = false;
        });
        LaunchFile.launchPDF(
            context ," ${sub} ", pathPDF, pdfUrl);
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
        title: new Text("Notes"),
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
                      file = "Notes/${department}_${sub}_Notes.pdf";
                    });
                    _getPdf(file);
                  },
                  child: (isTapped)?SizedBox(width:50,child: SpinKitWave(color: Colors.white,size: 16,)):Text("Open Notes",style: TextStyle(color: Colors.white),)
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
    print(pdfPath);
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
    final filename = '${department}_${sub}_Notes.pdf'; //I did it on purpose to avoid strange naming conflicts
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
    pdfurl = await FirebaseStorage.instance.ref().child(file).getDownloadURL();
    print("Hi $pdfurl");
    return pdfurl;
  }
}