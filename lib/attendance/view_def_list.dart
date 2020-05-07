import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class view_list extends StatefulWidget {
  @override
  _view_listState createState() => _view_listState();
}

class _view_listState extends State<view_list> {

  Widget _get_list() {
    return SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance.collection('Attendance').snapshots(),
          builder: (BuildContext context , snapshot){
            if(!snapshot.hasData){
              return Text("Loading Please Wait...");
            }
            else{
              return ListView(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Card(
                      elevation: 10.0,
                      color: Color.fromRGBO(58, 66, 86, 1.0),
                      margin: new EdgeInsets.symmetric(horizontal: 1.0, vertical:  3.0),
                      child: Padding(
                        padding: EdgeInsets.all( 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('Name',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 15),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('Reg. No.',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 15),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('Subject',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 15),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('Percentage',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 15),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:  20.0,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context , index){
                      DocumentSnapshot doc = snapshot.data.documents[index];
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: int.parse(doc['NumberOfSub']),
                          itemBuilder: (context , i){
                            return (double.parse(doc['Percentage${i+1}']) < 75) ?
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 70.0,
                              child: Card(
                                elevation: 7.0,
                                color: Color.fromRGBO(58, 66, 86, 1.0),
                                margin: new EdgeInsets.symmetric(horizontal: 1.0, vertical:  3.0),
                                child: Padding(
                                  padding: EdgeInsets.all( 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.2,
                                        child: Text(doc['Name of student'],style: TextStyle(color: Colors.white),),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.2,
                                        child: Text(doc['Registration Number'],style: TextStyle(color: Colors.white),),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.2,
                                        child: Text(doc['Subject'+(i+1).toString()],style: TextStyle(color: Colors.white),),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.2,
                                        child: Text('${doc['Percentage'+'${i+1}']}%',style: TextStyle(color: Colors.white),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ) : SizedBox();
                          }
                      );
                    },
                  ),
                ],
              );
            }
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58,66,86,1.0),
        appBar: AppBar(
          title: Text("Defaulter's List"),
          elevation: 0.1,
          centerTitle: true,
        ),
        body: _get_list()
    );
  }
}